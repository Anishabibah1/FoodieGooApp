package repositories

import "foodiegoo-backend/internal/models"

type MenuRepository interface {
	GetByRestaurantID(restaurantID string) ([]models.MenuItem, error)
	GetByID(id string) (*models.MenuItem, error)
}

type menuRepository struct{}

func NewMenuRepository() MenuRepository {
	return &menuRepository{}
}

func (r *menuRepository) GetByRestaurantID(restaurantID string) ([]models.MenuItem, error) {
	allMenus := map[string][]models.MenuItem{
		"1": {
			{ID: "101", RestaurantID: "1", Name: "Rendang Daging", Category: "Makanan Utama", ImageURL: "https://www.themealdb.com/images/media/meals/ssrysq1487323169.jpg", Price: 35000, Description: "Rendang daging sapi empuk bumbu rempah"},
			{ID: "102", RestaurantID: "1", Name: "Ayam Pop", Category: "Makanan Utama", ImageURL: "https://www.themealdb.com/images/media/meals/ysxwuq1487323065.jpg", Price: 28000, Description: "Ayam pop khas Padang"},
			{ID: "103", RestaurantID: "1", Name: "Gulai Ikan", Category: "Makanan Utama", ImageURL: "https://www.themealdb.com/images/media/meals/qqpwsy1511796276.jpg", Price: 30000, Description: "Gulai ikan segar bumbu kuning"},
			{ID: "104", RestaurantID: "1", Name: "Nasi Putih", Category: "Makanan Utama", ImageURL: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg", Price: 5000, Description: "Nasi putih pulen"},
			{ID: "105", RestaurantID: "1", Name: "Es Teh Manis", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/xqwwpv1511626875.jpg", Price: 5000, Description: "Es teh manis segar"},
			{ID: "106", RestaurantID: "1", Name: "Es Jeruk", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg", Price: 8000, Description: "Es jeruk peras segar"},
		},
		"2": {
			{ID: "201", RestaurantID: "2", Name: "Burger Beef Spesial", Category: "Burger", ImageURL: "https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg", Price: 35000, Description: "Burger daging sapi dengan saus spesial"},
			{ID: "202", RestaurantID: "2", Name: "Burger Chicken Crispy", Category: "Burger", ImageURL: "https://www.themealdb.com/images/media/meals/xqxvwv1511638337.jpg", Price: 30000, Description: "Burger ayam crispy renyah"},
			{ID: "203", RestaurantID: "2", Name: "Double Smash Burger", Category: "Burger", ImageURL: "https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg", Price: 45000, Description: "Double smash burger dengan keju"},
			{ID: "204", RestaurantID: "2", Name: "Kentang Goreng", Category: "Snack", ImageURL: "https://www.themealdb.com/images/media/meals/sxysrt1468240488.jpg", Price: 15000, Description: "Kentang goreng crispy"},
			{ID: "205", RestaurantID: "2", Name: "Cola", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/xqwwpv1511626875.jpg", Price: 8000, Description: "Cola dingin segar"},
		},
		"3": {
			{ID: "301", RestaurantID: "3", Name: "Pizza Margherita", Category: "Pizza", ImageURL: "https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg", Price: 65000, Description: "Pizza margherita dengan saus tomat dan keju"},
			{ID: "302", RestaurantID: "3", Name: "Pizza Pepperoni", Category: "Pizza", ImageURL: "https://www.themealdb.com/images/media/meals/rqvwxt1511384809.jpg", Price: 75000, Description: "Pizza pepperoni dengan topping melimpah"},
			{ID: "303", RestaurantID: "3", Name: "Spaghetti Bolognese", Category: "Pasta", ImageURL: "https://www.themealdb.com/images/media/meals/sutysw1468247559.jpg", Price: 45000, Description: "Spaghetti dengan saus bolognese"},
			{ID: "304", RestaurantID: "3", Name: "Garlic Bread", Category: "Snack", ImageURL: "https://www.themealdb.com/images/media/meals/sxysrt1468240488.jpg", Price: 20000, Description: "Roti bawang putih panggang"},
			{ID: "305", RestaurantID: "3", Name: "Jus Jeruk", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg", Price: 15000, Description: "Jus jeruk segar"},
		},
		"4": {
			{ID: "401", RestaurantID: "4", Name: "Mie Hompimpa Level 2", Category: "Mie", ImageURL: "https://www.themealdb.com/images/media/meals/tsswss1534796439.jpg", Price: 20000, Description: "Mie pedas level 2"},
			{ID: "402", RestaurantID: "4", Name: "Mie Setan Level 4", Category: "Mie", ImageURL: "https://www.themealdb.com/images/media/meals/xqwwpv1511626875.jpg", Price: 22000, Description: "Mie pedas level 4"},
			{ID: "403", RestaurantID: "4", Name: "Mie Iblis Level 6", Category: "Mie", ImageURL: "https://www.themealdb.com/images/media/meals/qqpwsy1511796276.jpg", Price: 25000, Description: "Mie pedas level 6"},
			{ID: "404", RestaurantID: "4", Name: "Dimsum Goreng", Category: "Snack", ImageURL: "https://www.themealdb.com/images/media/meals/sxysrt1468240488.jpg", Price: 15000, Description: "Dimsum goreng crispy"},
			{ID: "405", RestaurantID: "4", Name: "Es Teh Jumbo", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg", Price: 8000, Description: "Es teh manis jumbo"},
		},
		"5": {
			{ID: "501", RestaurantID: "5", Name: "Ayam Geprek Original", Category: "Ayam", ImageURL: "https://www.themealdb.com/images/media/meals/ysxwuq1487323065.jpg", Price: 18000, Description: "Ayam geprek original pedas"},
			{ID: "502", RestaurantID: "5", Name: "Ayam Geprek Keju", Category: "Ayam", ImageURL: "https://www.themealdb.com/images/media/meals/ssrysq1487323169.jpg", Price: 23000, Description: "Ayam geprek dengan topping keju"},
			{ID: "503", RestaurantID: "5", Name: "Ayam Geprek Mozarella", Category: "Ayam", ImageURL: "https://www.themealdb.com/images/media/meals/xqwwpv1511626875.jpg", Price: 28000, Description: "Ayam geprek dengan keju mozarella"},
			{ID: "504", RestaurantID: "5", Name: "Nasi Putih", Category: "Makanan Utama", ImageURL: "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg", Price: 4000, Description: "Nasi putih pulen"},
			{ID: "505", RestaurantID: "5", Name: "Es Teh", Category: "Minuman", ImageURL: "https://www.themealdb.com/images/media/meals/utxqpt1511639216.jpg", Price: 5000, Description: "Es teh manis"},
		},
	}

	menus, exists := allMenus[restaurantID]
	if !exists {
		return []models.MenuItem{}, nil
	}
	return menus, nil
}

func (r *menuRepository) GetByID(id string) (*models.MenuItem, error) {
	for i := 1; i <= 5; i++ {
		menus, _ := r.GetByRestaurantID(string(rune('0'+i)))
		for _, menu := range menus {
			if menu.ID == id {
				return &menu, nil
			}
		}
	}
	return nil, nil
}

