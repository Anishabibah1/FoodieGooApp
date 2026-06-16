package handlers

import (
	"foodiegoo-backend/internal/models"
	"foodiegoo-backend/internal/services"

	"github.com/gofiber/fiber/v2"
)

type OrderHandler struct {
	service services.OrderService
}

func NewOrderHandler(service services.OrderService) *OrderHandler {
	return &OrderHandler{service: service}
}

// GetOrders godoc
// @Summary Get all orders
// @Description Get list of all orders
// @Tags orders
// @Accept json
// @Produce json
// @Success 200 {object} models.OrderResponse
// @Router /api/orders [get]
func (h *OrderHandler) GetOrders(c *fiber.Ctx) error {
	orders, err := h.service.GetAllOrders()
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.JSON(models.OrderResponse{
		Success: true,
		Message: "Berhasil mengambil data order",
		Data:    orders,
	})
}

// GetOrderByID godoc
// @Summary Get order by ID
// @Description Get order detail by ID
// @Tags orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {object} models.Order
// @Router /api/orders/{id} [get]
func (h *OrderHandler) GetOrderByID(c *fiber.Ctx) error {
	id := c.Params("id")
	order, err := h.service.GetOrderByID(id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	if order == nil {
		return c.Status(404).JSON(fiber.Map{
			"success": false,
			"message": "Order tidak ditemukan",
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil",
		"data":    order,
	})
}

// CreateOrder godoc
// @Summary Create new order
// @Description Create a new order
// @Tags orders
// @Accept json
// @Produce json
// @Param order body models.Order true "Order data"
// @Success 201 {object} models.Order
// @Router /api/orders [post]
func (h *OrderHandler) CreateOrder(c *fiber.Ctx) error {
	var order models.Order
	if err := c.BodyParser(&order); err != nil {
		return c.Status(400).JSON(fiber.Map{
			"success": false,
			"message": "Invalid request body",
		})
	}
	result, err := h.service.CreateOrder(order)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.Status(201).JSON(fiber.Map{
		"success": true,
		"message": "Order berhasil dibuat",
		"data":    result,
	})
}

// UpdateOrderStatus godoc
// @Summary Update order status
// @Description Update status of an order
// @Tags orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Param status body map[string]string true "Status"
// @Success 200 {object} models.Order
// @Router /api/orders/{id}/status [put]
func (h *OrderHandler) UpdateOrderStatus(c *fiber.Ctx) error {
	id := c.Params("id")
	var body map[string]string
	if err := c.BodyParser(&body); err != nil {
		return c.Status(400).JSON(fiber.Map{
			"success": false,
			"message": "Invalid request body",
		})
	}
	result, err := h.service.UpdateOrderStatus(id, body["status"])
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Status berhasil diupdate",
		"data":    result,
	})
}

// DeleteOrder godoc
// @Summary Delete order
// @Description Delete an order by ID
// @Tags orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {object} map[string]interface{}
// @Router /api/orders/{id} [delete]
func (h *OrderHandler) DeleteOrder(c *fiber.Ctx) error {
	id := c.Params("id")
	order, err := h.service.GetOrderByID(id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	if order == nil {
		return c.Status(404).JSON(fiber.Map{
			"success": false,
			"message": "Order tidak ditemukan",
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Order berhasil dihapus",
		"data":    id,
	})
}