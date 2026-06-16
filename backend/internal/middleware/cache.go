package middleware

import (
	"sync"
	"time"

	"github.com/gofiber/fiber/v2"
)

type CacheItem struct {
	Value     []byte
	ExpiresAt time.Time
}

type Cache struct {
	mu    sync.RWMutex
	items map[string]CacheItem
}

var cache = &Cache{
	items: make(map[string]CacheItem),
}

func (c *Cache) Set(key string, value []byte, duration time.Duration) {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.items[key] = CacheItem{
		Value:     value,
		ExpiresAt: time.Now().Add(duration),
	}
}

func (c *Cache) Get(key string) ([]byte, bool) {
	c.mu.RLock()
	defer c.mu.RUnlock()
	item, exists := c.items[key]
	if !exists {
		return nil, false
	}
	if time.Now().After(item.ExpiresAt) {
		return nil, false
	}
	return item.Value, true
}

func (c *Cache) Delete(key string) {
	c.mu.Lock()
	defer c.mu.Unlock()
	delete(c.items, key)
}

func CacheMiddleware(duration time.Duration) fiber.Handler {
	return func(c *fiber.Ctx) error {
		key := c.Path() + "?" + string(c.Request().URI().QueryString())

		if cached, found := cache.Get(key); found {
			c.Set("X-Cache", "HIT")
			c.Set("Content-Type", "application/json")
			return c.Send(cached)
		}

		err := c.Next()

		if err == nil && c.Response().StatusCode() == 200 {
			cache.Set(key, c.Response().Body(), duration)
			c.Set("X-Cache", "MISS")
		}

		return err
	}
}