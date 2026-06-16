package models

type Restaurant struct {
	ID       string  `json:"id"`
	Name     string  `json:"name"`
	Category string  `json:"category"`
	ImageURL string  `json:"image_url"`
	Area     string  `json:"area"`
	Rating   float64 `json:"rating"`
	Time     string  `json:"time"`
}

type RestaurantResponse struct {
	Success bool         `json:"success"`
	Message string       `json:"message"`
	Data    []Restaurant `json:"data"`
}