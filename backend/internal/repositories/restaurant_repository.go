package repositories

import "foodiegoo-backend/internal/models"

type RestaurantRepository interface {
	GetAll() ([]models.Restaurant, error)
	GetByID(id string) (*models.Restaurant, error)
	Search(query string) ([]models.Restaurant, error)
}

type restaurantRepository struct{}

func NewRestaurantRepository() RestaurantRepository {
	return &restaurantRepository{}
}

func (r *restaurantRepository) GetAll() ([]models.Restaurant, error) {
	restaurants := []models.Restaurant{
		{
			ID:       "1",
			Name:     "Warung Nasi Padang",
			Category: "Masakan Padang",
			ImageURL: "https://www.themealdb.com/images/media/meals/sytuqu1511786590.jpg",
			Area:     "Indonesian",
			Rating:   4.8,
			Time:     "20 menit",
		},
		{
			ID:       "2",
			Name:     "Burger Kuy!",
			Category: "Burger & Snack",
			ImageURL: "https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg",
			Area:     "American",
			Rating:   4.7,
			Time:     "25 menit",
		},
		{
			ID:       "3",
			Name:     "Pizza Hut Express",
			Category: "Pizza & Pasta",
			ImageURL: "https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg",
			Area:     "Italian",
			Rating:   4.6,
			Time:     "30 menit",
		},
		{
			ID:       "4",
			Name:     "Mie Gacoan",
			Category: "Mie & Seafood",
			ImageURL: "https://www.themealdb.com/images/media/meals/tsswss1534796439.jpg",
			Area:     "Indonesian",
			Rating:   4.9,
			Time:     "20 menit",
		},
		{
			ID:       "5",
			Name:     "Ayam Geprek Bu Tini",
			Category: "Ayam & Lalapan",
			ImageURL: "https://www.themealdb.com/images/media/meals/ysxwuq1487323065.jpg",
			Area:     "Indonesian",
			Rating:   4.7,
			Time:     "15 menit",
		},
	}
	return restaurants, nil
}

func (r *restaurantRepository) GetByID(id string) (*models.Restaurant, error) {
	restaurants, _ := r.GetAll()
	for _, restaurant := range restaurants {
		if restaurant.ID == id {
			return &restaurant, nil
		}
	}
	return nil, nil
}

func (r *restaurantRepository) Search(query string) ([]models.Restaurant, error) {
	restaurants, _ := r.GetAll()
	var results []models.Restaurant
	for _, restaurant := range restaurants {
		if containsIgnoreCase(restaurant.Name, query) ||
			containsIgnoreCase(restaurant.Category, query) {
			results = append(results, restaurant)
		}
	}
	return results, nil
}

func containsIgnoreCase(s, substr string) bool {
	if len(substr) == 0 {
		return true
	}
	if len(s) < len(substr) {
		return false
	}
	sLower := toLower(s)
	substrLower := toLower(substr)
	for i := 0; i <= len(sLower)-len(substrLower); i++ {
		if sLower[i:i+len(substrLower)] == substrLower {
			return true
		}
	}
	return false
}

func toLower(s string) string {
	result := make([]byte, len(s))
	for i := 0; i < len(s); i++ {
		c := s[i]
		if c >= 'A' && c <= 'Z' {
			c += 32
		}
		result[i] = c
	}
	return string(result)
}