package main

import (
	"fmt"
	"log"
	"time"

	"foodiegoo-backend/config"
	"foodiegoo-backend/internal/handlers"
	"foodiegoo-backend/internal/middleware"
	"foodiegoo-backend/internal/repositories"
	"foodiegoo-backend/internal/services"
	_ "foodiegoo-backend/docs"

	"github.com/gofiber/contrib/websocket"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/logger"
	fiberSwagger "github.com/swaggo/fiber-swagger"
)

// @title FoodieGoo API
// @version 1.0
// @description REST API untuk aplikasi FoodieGoo food delivery
// @host localhost:8080
// @BasePath /
func main() {
	cfg := config.LoadConfig()

	app := fiber.New(fiber.Config{
		AppName: "FoodieGoo API v1.0",
	})

	// Middleware
	app.Use(logger.New())
	app.Use(cors.New(cors.Config{
		AllowOrigins: "*",
		AllowHeaders: "Origin, Content-Type, Accept",
		AllowMethods: "GET, POST, PUT, DELETE",
	}))

	// Swagger UI
	app.Get("/swagger/*", fiberSwagger.WrapHandler)

	// Init repositories
	restaurantRepo := repositories.NewRestaurantRepository()
	menuRepo := repositories.NewMenuRepository()
	orderRepo := repositories.NewOrderRepository()

	// Init services
	restaurantService := services.NewRestaurantService(restaurantRepo)
	menuService := services.NewMenuService(menuRepo)
	orderService := services.NewOrderService(orderRepo)

	// Init handlers
	restaurantHandler := handlers.NewRestaurantHandler(restaurantService)
	menuHandler := handlers.NewMenuHandler(menuService)
	orderHandler := handlers.NewOrderHandler(orderService)

	// Routes
	api := app.Group("/api")

	// Restaurant routes
	restaurants := api.Group("/restaurants")
	restaurants.Get("/", middleware.CacheMiddleware(5*time.Minute), restaurantHandler.GetRestaurants)
	restaurants.Get("/search", restaurantHandler.SearchRestaurants)
	restaurants.Get("/:id", restaurantHandler.GetRestaurantByID)
	restaurants.Get("/:id/menu", middleware.CacheMiddleware(5*time.Minute), menuHandler.GetMenuByRestaurant)

	// Menu routes
	menu := api.Group("/menu")
	menu.Get("/:id", menuHandler.GetMenuByID)

	// Order routes
	orders := api.Group("/orders")
	orders.Get("/", orderHandler.GetOrders)
	orders.Get("/:id", orderHandler.GetOrderByID)
	orders.Post("/", orderHandler.CreateOrder)
	orders.Put("/:id/status", orderHandler.UpdateOrderStatus)

	// WebSocket route
	app.Use("/ws", func(c *fiber.Ctx) error {
		if websocket.IsWebSocketUpgrade(c) {
			return c.Next()
		}
		return fiber.ErrUpgradeRequired
	})
	app.Get("/ws/tracking/:orderId", websocket.New(handlers.WebSocketHandler))

	// Health check
	app.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"status":  "ok",
			"message": "FoodieGoo API is running",
		})
	})

	fmt.Printf("FoodieGoo API running on port %s\n", cfg.AppPort)
	fmt.Printf("Swagger UI: http://localhost:%s/swagger/index.html\n", cfg.AppPort)
	log.Fatal(app.Listen(":" + cfg.AppPort))

	// tambahkan di bagian restaurants routes
	restaurants.Delete("/:id", restaurantHandler.DeleteRestaurant)

	// tambahkan di bagian orders routes
	orders.Delete("/:id", orderHandler.DeleteOrder)
}