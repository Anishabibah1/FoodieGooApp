package services

import (
	"foodiegoo-backend/internal/models"
	"foodiegoo-backend/internal/repositories"
)

type RestaurantService interface {
	GetAllRestaurants() ([]models.Restaurant, error)
	GetRestaurantByID(id string) (*models.Restaurant, error)
	SearchRestaurants(query string) ([]models.Restaurant, error)
}

type restaurantService struct {
	repo repositories.RestaurantRepository
}

func NewRestaurantService(repo repositories.RestaurantRepository) RestaurantService {
	return &restaurantService{repo: repo}
}

func (s *restaurantService) GetAllRestaurants() ([]models.Restaurant, error) {
	return s.repo.GetAll()
}

func (s *restaurantService) GetRestaurantByID(id string) (*models.Restaurant, error) {
	return s.repo.GetByID(id)
}

func (s *restaurantService) SearchRestaurants(query string) ([]models.Restaurant, error) {
	return s.repo.Search(query)
}