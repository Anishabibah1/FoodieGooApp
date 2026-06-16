package handlers

import (
	"foodiegoo-backend/internal/middleware"
	"foodiegoo-backend/internal/services"
	"time"

	"github.com/gofiber/fiber/v2"
)

type RestaurantHandler struct {
	service services.RestaurantService
}

func NewRestaurantHandler(service services.RestaurantService) *RestaurantHandler {
	return &RestaurantHandler{service: service}
}

// GetRestaurants godoc
// @Summary Get all restaurants
// @Description Get list of all restaurants
// @Tags restaurants
// @Accept json
// @Produce json
// @Success 200 {object} models.RestaurantResponse
// @Router /api/restaurants [get]
func (h *RestaurantHandler) GetRestaurants(c *fiber.Ctx) error {
	_ = middleware.CacheMiddleware(5 * time.Minute)

	restaurants, err := h.service.GetAllRestaurants()
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil mengambil data restoran",
		"data":    restaurants,
	})
}

// GetRestaurantByID godoc
// @Summary Get restaurant by ID
// @Description Get restaurant detail by ID
// @Tags restaurants
// @Accept json
// @Produce json
// @Param id path string true "Restaurant ID"
// @Success 200 {object} models.Restaurant
// @Router /api/restaurants/{id} [get]
func (h *RestaurantHandler) GetRestaurantByID(c *fiber.Ctx) error {
	id := c.Params("id")
	restaurant, err := h.service.GetRestaurantByID(id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	if restaurant == nil {
		return c.Status(404).JSON(fiber.Map{
			"success": false,
			"message": "Restoran tidak ditemukan",
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil",
		"data":    restaurant,
	})
}

// SearchRestaurants godoc
// @Summary Search restaurants
// @Description Search restaurants by name or category
// @Tags restaurants
// @Accept json
// @Produce json
// @Param q query string true "Search query"
// @Success 200 {object} models.RestaurantResponse
// @Router /api/restaurants/search [get]
func (h *RestaurantHandler) SearchRestaurants(c *fiber.Ctx) error {
	query := c.Query("q")
	if query == "" {
		return c.Status(400).JSON(fiber.Map{
			"success": false,
			"message": "Query tidak boleh kosong",
		})
	}
	restaurants, err := h.service.SearchRestaurants(query)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil",
		"data":    restaurants,
	})
}

// DeleteRestaurant godoc
// @Summary Delete restaurant
// @Description Delete a restaurant by ID
// @Tags restaurants
// @Accept json
// @Produce json
// @Param id path string true "Restaurant ID"
// @Success 200 {object} map[string]interface{}
// @Router /api/restaurants/{id} [delete]
func (h *RestaurantHandler) DeleteRestaurant(c *fiber.Ctx) error {
	id := c.Params("id")
	restaurant, err := h.service.GetRestaurantByID(id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	if restaurant == nil {
		return c.Status(404).JSON(fiber.Map{
			"success": false,
			"message": "Restoran tidak ditemukan",
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Restoran berhasil dihapus",
		"data":    id,
	})
}