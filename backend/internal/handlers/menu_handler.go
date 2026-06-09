package handlers

import (
	"foodiegoo-backend/internal/services"

	"github.com/gofiber/fiber/v2"
)

type MenuHandler struct {
	service services.MenuService
}

func NewMenuHandler(service services.MenuService) *MenuHandler {
	return &MenuHandler{service: service}
}

// GetMenuByRestaurant godoc
// @Summary Get menu by restaurant
// @Description Get list of menu items by restaurant ID
// @Tags menu
// @Accept json
// @Produce json
// @Param id path string true "Restaurant ID"
// @Success 200 {object} models.MenuResponse
// @Router /api/restaurants/{id}/menu [get]
func (h *MenuHandler) GetMenuByRestaurant(c *fiber.Ctx) error {
	restaurantID := c.Params("id")
	menus, err := h.service.GetMenuByRestaurantID(restaurantID)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil mengambil data menu",
		"data":    menus,
	})
}

// GetMenuByID godoc
// @Summary Get menu by ID
// @Description Get menu item detail by ID
// @Tags menu
// @Accept json
// @Produce json
// @Param id path string true "Menu ID"
// @Success 200 {object} models.MenuItem
// @Router /api/menu/{id} [get]
func (h *MenuHandler) GetMenuByID(c *fiber.Ctx) error {
	id := c.Params("id")
	menu, err := h.service.GetMenuByID(id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{
			"success": false,
			"message": err.Error(),
		})
	}
	if menu == nil {
		return c.Status(404).JSON(fiber.Map{
			"success": false,
			"message": "Menu tidak ditemukan",
		})
	}
	return c.JSON(fiber.Map{
		"success": true,
		"message": "Berhasil",
		"data":    menu,
	})
}