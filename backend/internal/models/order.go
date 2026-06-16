package models

type Order struct {
	ID           string   `json:"id"`
	RestaurantID string   `json:"restaurant_id"`
	RestoName    string   `json:"resto_name"`
	RestoImage   string   `json:"resto_image"`
	Items        []string `json:"items"`
	Total        int      `json:"total"`
	Status       string   `json:"status"`
	Date         string   `json:"date"`
}

type OrderResponse struct {
	Success bool    `json:"success"`
	Message string  `json:"message"`
	Data    []Order `json:"data"`
}

type TrackingStatus struct {
	OrderID string `json:"order_id"`
	Status  string `json:"status"`
	Message string `json:"message"`
	Step    int    `json:"step"`
}