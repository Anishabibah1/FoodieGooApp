package services

import (
	"foodiegoo-backend/internal/models"
	"foodiegoo-backend/internal/repositories"
)

type OrderService interface {
	GetAllOrders() ([]models.Order, error)
	GetOrderByID(id string) (*models.Order, error)
	CreateOrder(order models.Order) (*models.Order, error)
	UpdateOrderStatus(id string, status string) (*models.Order, error)
}

type orderService struct {
	repo repositories.OrderRepository
}

func NewOrderService(repo repositories.OrderRepository) OrderService {
	return &orderService{repo: repo}
}

func (s *orderService) GetAllOrders() ([]models.Order, error) {
	return s.repo.GetAll()
}

func (s *orderService) GetOrderByID(id string) (*models.Order, error) {
	return s.repo.GetByID(id)
}

func (s *orderService) CreateOrder(order models.Order) (*models.Order, error) {
	return s.repo.Create(order)
}

func (s *orderService) UpdateOrderStatus(id string, status string) (*models.Order, error) {
	return s.repo.UpdateStatus(id, status)
}