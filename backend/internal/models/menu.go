package models

type MenuItem struct {
	ID           string `json:"id"`
	RestaurantID string `json:"restaurant_id"`
	Name         string `json:"name"`
	Category     string `json:"category"`
	ImageURL     string `json:"image_url"`
	Price        int    `json:"price"`
	Description  string `json:"description"`
}

type MenuResponse struct {
	Success bool       `json:"success"`
	Message string     `json:"message"`
	Data    []MenuItem `json:"data"`
}