package services

import (
	"foodiegoo-backend/internal/models"
	"foodiegoo-backend/internal/repositories"
)

type MenuService interface {
	GetMenuByRestaurantID(restaurantID string) ([]models.MenuItem, error)
	GetMenuByID(id string) (*models.MenuItem, error)
}

type menuService struct {
	repo repositories.MenuRepository
}

func NewMenuService(repo repositories.MenuRepository) MenuService {
	return &menuService{repo: repo}
}

func (s *menuService) GetMenuByRestaurantID(restaurantID string) ([]models.MenuItem, error) {
	return s.repo.GetByRestaurantID(restaurantID)
}

func (s *menuService) GetMenuByID(id string) (*models.MenuItem, error) {
	return s.repo.GetByID(id)
}