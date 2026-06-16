package repositories

import "foodiegoo-backend/internal/models"

type OrderRepository interface {
	GetAll() ([]models.Order, error)
	GetByID(id string) (*models.Order, error)
	Create(order models.Order) (*models.Order, error)
	UpdateStatus(id string, status string) (*models.Order, error)
}

type orderRepository struct{}

func NewOrderRepository() OrderRepository {
	return &orderRepository{}
}

func (r *orderRepository) GetAll() ([]models.Order, error) {
	orders := []models.Order{
		{
			ID:           "#FG-001",
			RestaurantID: "1",
			RestoName:    "Warung Nasi Padang",
			RestoImage:   "https://www.themealdb.com/images/media/meals/sytuqu1511786590.jpg",
			Items:        []string{"Nasi Goreng Spesial", "Es Teh Manis"},
			Total:        33000,
			Status:       "Selesai",
			Date:         "04 Jun 2026",
		},
		{
			ID:           "#FG-002",
			RestaurantID: "2",
			RestoName:    "Burger Kuy!",
			RestoImage:   "https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg",
			Items:        []string{"Burger Spesial", "Kentang Goreng"},
			Total:        45000,
			Status:       "Selesai",
			Date:         "03 Jun 2026",
		},
		{
			ID:           "#FG-003",
			RestaurantID: "3",
			RestoName:    "Pizza Hut Express",
			RestoImage:   "https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg",
			Items:        []string{"Pizza Margherita"},
			Total:        75000,
			Status:       "Dibatalkan",
			Date:         "01 Jun 2026",
		},
	}
	return orders, nil
}

func (r *orderRepository) GetByID(id string) (*models.Order, error) {
	orders, _ := r.GetAll()
	for _, order := range orders {
		if order.ID == id {
			return &order, nil
		}
	}
	return nil, nil
}

func (r *orderRepository) Create(order models.Order) (*models.Order, error) {
	return &order, nil
}

func (r *orderRepository) UpdateStatus(id string, status string) (*models.Order, error) {
	order, _ := r.GetByID(id)
	if order != nil {
		order.Status = status
	}
	return order, nil
}