package handlers

import (
	"encoding/json"
	"log"
	"sync"
	"time"

	"github.com/gofiber/contrib/websocket"
)

type Client struct {
	Conn    *websocket.Conn
	OrderID string
}

type TrackingMessage struct {
	OrderID string `json:"order_id"`
	Status  string `json:"status"`
	Message string `json:"message"`
	Step    int    `json:"step"`
}

var (
	clients   = make(map[*websocket.Conn]*Client)
	clientsMu sync.RWMutex
)

var trackingSteps = []TrackingMessage{
	{Status: "order_received", Message: "Pesanan diterima oleh restoran", Step: 0},
	{Status: "preparing", Message: "Makananmu sedang disiapkan", Step: 1},
	{Status: "driver_pickup", Message: "Driver menuju ke restoran", Step: 2},
	{Status: "on_delivery", Message: "Driver sedang menuju lokasimu", Step: 3},
	{Status: "arrived", Message: "Pesananmu sudah sampai!", Step: 4},
}

func WebSocketHandler(c *websocket.Conn) {
	orderID := c.Params("orderId")

	clientsMu.Lock()
	clients[c] = &Client{Conn: c, OrderID: orderID}
	clientsMu.Unlock()

	log.Printf("Client connected for order: %s", orderID)

	defer func() {
		clientsMu.Lock()
		delete(clients, c)
		clientsMu.Unlock()
		c.Close()
		log.Printf("Client disconnected for order: %s", orderID)
	}()

	// Kirim update tracking otomatis setiap 5 detik
	go func() {
		for i, step := range trackingSteps {
			time.Sleep(5 * time.Second)

			msg := TrackingMessage{
				OrderID: orderID,
				Status:  step.Status,
				Message: step.Message,
				Step:    i,
			}

			data, err := json.Marshal(msg)
			if err != nil {
				continue
			}

			clientsMu.RLock()
			client, exists := clients[c]
			clientsMu.RUnlock()

			if !exists {
				return
			}

			if err := client.Conn.WriteMessage(websocket.TextMessage, data); err != nil {
				log.Printf("Error sending message: %v", err)
				return
			}
		}
	}()

	// Listen untuk pesan dari client
	for {
		messageType, message, err := c.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err) {
				log.Printf("Unexpected close error: %v", err)
			}
			break
		}

		log.Printf("Received message from %s: %s", orderID, message)

		// Echo pesan balik ke client
		if err := c.WriteMessage(messageType, message); err != nil {
			log.Printf("Error writing message: %v", err)
			break
		}
	}
}

func BroadcastToOrder(orderID string, message TrackingMessage) {
	data, err := json.Marshal(message)
	if err != nil {
		return
	}

	clientsMu.RLock()
	defer clientsMu.RUnlock()

	for conn, client := range clients {
		if client.OrderID == orderID {
			if err := conn.WriteMessage(websocket.TextMessage, data); err != nil {
				log.Printf("Error broadcasting to %s: %v", orderID, err)
			}
		}
	}
}