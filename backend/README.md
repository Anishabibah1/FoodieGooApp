---
title: FoodieGoo API v1.0
language_tabs:
  - shell: Shell
  - javascript: JavaScript
language_clients:
  - shell: ""
  - javascript: ""
toc_footers: []
includes: []
search: true
highlight_theme: darkula
headingLevel: 2

---

<!-- Generator: Widdershins v4.0.1 -->

<h1 id="foodiegoo-api">FoodieGoo API v1.0</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

REST API untuk aplikasi FoodieGoo food delivery

Base URLs:

* <a href="//localhost:8080/">//localhost:8080/</a>

<h1 id="foodiegoo-api-menu">menu</h1>

## get__api_menu_{id}

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/menu/{id} \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/menu/{id}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/menu/{id}`

*Get menu by ID*

Get menu item detail by ID

<h3 id="get__api_menu_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Menu ID|

> Example responses

> 200 Response

```json
{
  "category": "string",
  "description": "string",
  "id": "string",
  "image_url": "string",
  "name": "string",
  "price": 0,
  "restaurant_id": "string"
}
```

<h3 id="get__api_menu_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.MenuItem](#schemamodels.menuitem)|

<aside class="success">
This operation does not require authentication
</aside>

## get__api_restaurants_{id}_menu

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/restaurants/{id}/menu \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/restaurants/{id}/menu',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/restaurants/{id}/menu`

*Get menu by restaurant*

Get list of menu items by restaurant ID

<h3 id="get__api_restaurants_{id}_menu-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Restaurant ID|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "category": "string",
      "description": "string",
      "id": "string",
      "image_url": "string",
      "name": "string",
      "price": 0,
      "restaurant_id": "string"
    }
  ],
  "message": "string",
  "success": true
}
```

<h3 id="get__api_restaurants_{id}_menu-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.MenuResponse](#schemamodels.menuresponse)|

<aside class="success">
This operation does not require authentication
</aside>

<h1 id="foodiegoo-api-orders">orders</h1>

## get__api_orders

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/orders \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/orders',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/orders`

*Get all orders*

Get list of all orders

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "date": "string",
      "id": "string",
      "items": [
        "string"
      ],
      "restaurant_id": "string",
      "resto_image": "string",
      "resto_name": "string",
      "status": "string",
      "total": 0
    }
  ],
  "message": "string",
  "success": true
}
```

<h3 id="get__api_orders-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.OrderResponse](#schemamodels.orderresponse)|

<aside class="success">
This operation does not require authentication
</aside>

## post__api_orders

> Code samples

```shell
# You can also use wget
curl -X POST /localhost:8080/api/orders \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'

```

```javascript
const inputBody = '{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json'
};

fetch('/localhost:8080/api/orders',
{
  method: 'POST',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`POST /api/orders`

*Create new order*

Create a new order

> Body parameter

```json
{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}
```

<h3 id="post__api_orders-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[models.Order](#schemamodels.order)|true|Order data|

> Example responses

> 201 Response

```json
{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}
```

<h3 id="post__api_orders-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|[models.Order](#schemamodels.order)|

<aside class="success">
This operation does not require authentication
</aside>

## delete__api_orders_{id}

> Code samples

```shell
# You can also use wget
curl -X DELETE /localhost:8080/api/orders/{id} \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/orders/{id}',
{
  method: 'DELETE',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`DELETE /api/orders/{id}`

*Delete order*

Delete an order by ID

<h3 id="delete__api_orders_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Order ID|

> Example responses

> 200 Response

```json
{}
```

<h3 id="delete__api_orders_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|Inline|

<h3 id="delete__api_orders_{id}-responseschema">Response Schema</h3>

<aside class="success">
This operation does not require authentication
</aside>

## get__api_orders_{id}

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/orders/{id} \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/orders/{id}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/orders/{id}`

*Get order by ID*

Get order detail by ID

<h3 id="get__api_orders_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Order ID|

> Example responses

> 200 Response

```json
{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}
```

<h3 id="get__api_orders_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.Order](#schemamodels.order)|

<aside class="success">
This operation does not require authentication
</aside>

## put__api_orders_{id}_status

> Code samples

```shell
# You can also use wget
curl -X PUT /localhost:8080/api/orders/{id}/status \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'

```

```javascript
const inputBody = '{
  "property1": "string",
  "property2": "string"
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json'
};

fetch('/localhost:8080/api/orders/{id}/status',
{
  method: 'PUT',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`PUT /api/orders/{id}/status`

*Update order status*

Update status of an order

> Body parameter

```json
{
  "property1": "string",
  "property2": "string"
}
```

<h3 id="put__api_orders_{id}_status-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Order ID|
|body|body|object|true|Status|
|» **additionalProperties**|body|string|false|none|

> Example responses

> 200 Response

```json
{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}
```

<h3 id="put__api_orders_{id}_status-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.Order](#schemamodels.order)|

<aside class="success">
This operation does not require authentication
</aside>

<h1 id="foodiegoo-api-restaurants">restaurants</h1>

## get__api_restaurants

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/restaurants \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/restaurants',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/restaurants`

*Get all restaurants*

Get list of all restaurants

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "area": "string",
      "category": "string",
      "id": "string",
      "image_url": "string",
      "name": "string",
      "rating": 0,
      "time": "string"
    }
  ],
  "message": "string",
  "success": true
}
```

<h3 id="get__api_restaurants-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.RestaurantResponse](#schemamodels.restaurantresponse)|

<aside class="success">
This operation does not require authentication
</aside>

## delete__api_restaurants_{id}

> Code samples

```shell
# You can also use wget
curl -X DELETE /localhost:8080/api/restaurants/{id} \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/restaurants/{id}',
{
  method: 'DELETE',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`DELETE /api/restaurants/{id}`

*Delete restaurant*

Delete a restaurant by ID

<h3 id="delete__api_restaurants_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Restaurant ID|

> Example responses

> 200 Response

```json
{}
```

<h3 id="delete__api_restaurants_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|Inline|

<h3 id="delete__api_restaurants_{id}-responseschema">Response Schema</h3>

<aside class="success">
This operation does not require authentication
</aside>

## get__api_restaurants_{id}

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/restaurants/{id} \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/restaurants/{id}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/restaurants/{id}`

*Get restaurant by ID*

Get restaurant detail by ID

<h3 id="get__api_restaurants_{id}-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|id|path|string|true|Restaurant ID|

> Example responses

> 200 Response

```json
{
  "area": "string",
  "category": "string",
  "id": "string",
  "image_url": "string",
  "name": "string",
  "rating": 0,
  "time": "string"
}
```

<h3 id="get__api_restaurants_{id}-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.Restaurant](#schemamodels.restaurant)|

<aside class="success">
This operation does not require authentication
</aside>

## get__api_restaurants_search

> Code samples

```shell
# You can also use wget
curl -X GET /localhost:8080/api/restaurants/search?q=string \
  -H 'Accept: application/json'

```

```javascript

const headers = {
  'Accept':'application/json'
};

fetch('/localhost:8080/api/restaurants/search?q=string',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

`GET /api/restaurants/search`

*Search restaurants*

Search restaurants by name or category

<h3 id="get__api_restaurants_search-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|q|query|string|true|Search query|

> Example responses

> 200 Response

```json
{
  "data": [
    {
      "area": "string",
      "category": "string",
      "id": "string",
      "image_url": "string",
      "name": "string",
      "rating": 0,
      "time": "string"
    }
  ],
  "message": "string",
  "success": true
}
```

<h3 id="get__api_restaurants_search-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[models.RestaurantResponse](#schemamodels.restaurantresponse)|

<aside class="success">
This operation does not require authentication
</aside>

# Schemas

<h2 id="tocS_models.MenuItem">models.MenuItem</h2>
<!-- backwards compatibility -->
<a id="schemamodels.menuitem"></a>
<a id="schema_models.MenuItem"></a>
<a id="tocSmodels.menuitem"></a>
<a id="tocsmodels.menuitem"></a>

```json
{
  "category": "string",
  "description": "string",
  "id": "string",
  "image_url": "string",
  "name": "string",
  "price": 0,
  "restaurant_id": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|category|string|false|none|none|
|description|string|false|none|none|
|id|string|false|none|none|
|image_url|string|false|none|none|
|name|string|false|none|none|
|price|integer|false|none|none|
|restaurant_id|string|false|none|none|

<h2 id="tocS_models.MenuResponse">models.MenuResponse</h2>
<!-- backwards compatibility -->
<a id="schemamodels.menuresponse"></a>
<a id="schema_models.MenuResponse"></a>
<a id="tocSmodels.menuresponse"></a>
<a id="tocsmodels.menuresponse"></a>

```json
{
  "data": [
    {
      "category": "string",
      "description": "string",
      "id": "string",
      "image_url": "string",
      "name": "string",
      "price": 0,
      "restaurant_id": "string"
    }
  ],
  "message": "string",
  "success": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[[models.MenuItem](#schemamodels.menuitem)]|false|none|none|
|message|string|false|none|none|
|success|boolean|false|none|none|

<h2 id="tocS_models.Order">models.Order</h2>
<!-- backwards compatibility -->
<a id="schemamodels.order"></a>
<a id="schema_models.Order"></a>
<a id="tocSmodels.order"></a>
<a id="tocsmodels.order"></a>

```json
{
  "date": "string",
  "id": "string",
  "items": [
    "string"
  ],
  "restaurant_id": "string",
  "resto_image": "string",
  "resto_name": "string",
  "status": "string",
  "total": 0
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|date|string|false|none|none|
|id|string|false|none|none|
|items|[string]|false|none|none|
|restaurant_id|string|false|none|none|
|resto_image|string|false|none|none|
|resto_name|string|false|none|none|
|status|string|false|none|none|
|total|integer|false|none|none|

<h2 id="tocS_models.OrderResponse">models.OrderResponse</h2>
<!-- backwards compatibility -->
<a id="schemamodels.orderresponse"></a>
<a id="schema_models.OrderResponse"></a>
<a id="tocSmodels.orderresponse"></a>
<a id="tocsmodels.orderresponse"></a>

```json
{
  "data": [
    {
      "date": "string",
      "id": "string",
      "items": [
        "string"
      ],
      "restaurant_id": "string",
      "resto_image": "string",
      "resto_name": "string",
      "status": "string",
      "total": 0
    }
  ],
  "message": "string",
  "success": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[[models.Order](#schemamodels.order)]|false|none|none|
|message|string|false|none|none|
|success|boolean|false|none|none|

<h2 id="tocS_models.Restaurant">models.Restaurant</h2>
<!-- backwards compatibility -->
<a id="schemamodels.restaurant"></a>
<a id="schema_models.Restaurant"></a>
<a id="tocSmodels.restaurant"></a>
<a id="tocsmodels.restaurant"></a>

```json
{
  "area": "string",
  "category": "string",
  "id": "string",
  "image_url": "string",
  "name": "string",
  "rating": 0,
  "time": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|area|string|false|none|none|
|category|string|false|none|none|
|id|string|false|none|none|
|image_url|string|false|none|none|
|name|string|false|none|none|
|rating|number|false|none|none|
|time|string|false|none|none|

<h2 id="tocS_models.RestaurantResponse">models.RestaurantResponse</h2>
<!-- backwards compatibility -->
<a id="schemamodels.restaurantresponse"></a>
<a id="schema_models.RestaurantResponse"></a>
<a id="tocSmodels.restaurantresponse"></a>
<a id="tocsmodels.restaurantresponse"></a>

```json
{
  "data": [
    {
      "area": "string",
      "category": "string",
      "id": "string",
      "image_url": "string",
      "name": "string",
      "rating": 0,
      "time": "string"
    }
  ],
  "message": "string",
  "success": true
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|data|[[models.Restaurant](#schemamodels.restaurant)]|false|none|none|
|message|string|false|none|none|
|success|boolean|false|none|none|

