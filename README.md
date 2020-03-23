# Rails Engine
[Project Site](https://backend.turing.io/module3/projects/rails_engine/)

## Overview
Rails Engine is an API developed over one week in a service-oriented architecture. Its purpose is to expose the data that powers an E-Commerce Application.

This API was created as a part of [Turing School of Software & Design](https://turing.io/)'s [back-end engineering program](https://backend.turing.io/module3/).

## Setup
[Clone this repo](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)

#### Setting up the environment
In your terminal, run:
```
bundle
```
#### Setting up the database
In your terminal, run:
```
rake db:{drop,create,migrate}
```
#### Populating the database
In your terminal, run:
```
rake csv:reseed
```
#### Running the test suite
In your terminal, run:
```
bundle exec rspec
```

## Endpoints

### Accessing Endpoints
Navigate to the root directory of the repository. In your terminal, run:
```
rails s
```
In your browser, navigate to:
```
localhost:3000
```
For GET requests: Append URI for desired endpoint. For example:
```
localhost:3000/api/v1/merchants/6
```
For other requests, use [Postman](https://www.postman.com/) or the [front-end app](https://github.com/turingschool-examples/rails_driver/tree/656c57ab30e891b9234b96143e065f0b67d2ffa3)

### CRUD Functionality
The body for `POST` and `PATCH` requests should follow this pattern:
```
{
  "attribute1": "value1",
  "attribute2": "value2",
}
```
> Example JSON response for a created/updated/destroyed item:
```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Cruddy Store"
    }
  }
}
```

### Merchant Endpoints
```
GET /api/v1/merchants
GET /api/v1/merchants/:id
PUT /api/v1/merchants
PATCH /api/v1/merchants/:id
DELETE /api/v1/merchants/:id
```
> Example JSON response for `GET /api/v1/merchants`
```
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Dog Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Donut Store",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "Shop Store",
      }
    }
  ]
}
```
> Example JSON response for `GET /api/v1/merchants/1`
```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Dog Store"
    }
  }
}
```

### Item Endpoints
```
GET /api/v1/items
GET /api/v1/items/:id
PUT /api/v1/items
PATCH /api/v1/items/:id
DELETE /api/v1/items/:id
```
> Example JSON response for `GET /api/v1/items`
```
{
  "data": [
    {
      "id": "1",
      "type": "item",
      "attributes": {
        "name": "Item Qui Esse",
        "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
        "unit_price": 751.07,
        "merchant_id": 1
      },
      "relationships": {
        "merchant": {
          "data": {
              "id": "1",
              "type": "merchant"
          }
        }
      }
    },
    {
      "id": "2",
      "type": "item",
      "attributes": {
        "name": "Item Autem Minima",
        "description": "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.",
        "unit_price": 670.76,
        "merchant_id": 1
      },
      "relationships": {
        "merchant": {
          "data": {
            "id": "1",
            "type": "merchant"
          }
        }
      }
    },
    {
      "id": "3",
      "type": "item",
      "attributes": {
        "name": "Item Ea Voluptatum",
        "description": "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.",
        "unit_price": 323.01,
        "merchant_id": 1
      },
      "relationships": {
        "merchant": {
          "data": {
            "id": "1",
            "type": "merchant"
          }
        }
      }
    }
  ]
}
```
> Example JSON response for `GET /api/v1/items/1`
```
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Item Qui Esse",
      "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      "unit_price": 751.07,
      "merchant_id": 1
    },
    "relationships": {
      "merchant": {
        "data": {
          "id": "1",
          "type": "merchant"
        }
      }
    }
  }
}
```

### Nested Resource Endpoints
```
GET /api/v1/items/:id/merchant
GET /api/v1/merchants/:id/items
```

### Find Endpoints
#### Items

| Attribute    |  Format             |
| ------------ | ------------------- |
| id           | 1                   |
| name         | cool beans          |
| description  | great               |
| unit_price   | 19.12               |
| merchant_id  | 5                   |
| created_at   | 2012-03-27 14:53:59 |
| updated_at   | 2012-03-27 14:53:59 |

Searches for name and description are case insensitive and return partial matches.
```
GET /items/find?<attribute>=<value>
GET /items/find_all?<attribute>=<value>
```
> Example search with multiple values
```
GET /api/v1/items/find?name=pen&description=blue
```
#### Merchants

| Attribute    |  Format             |
| ------------ | ------------------- |
| id           | 1                   |
| name         | Item Shop           |
| created_at   | 2012-03-27 14:53:59 |
| updated_at   | 2012-03-27 14:53:59 |

Searches for name are case insensitive and return partial matches.
```
GET /merchants/find?<attribute>=<value>
GET /merchants/find_all?<attribute>=<value>
```
> Example search with multiple values
```
GET /api/v1/merchants/find?name=Shop&created_at=2020-03-23 14:53:59
```
### Business Intelligence Endpoints
```
GET /api/v1/merchants/most_revenue?quantity=x
GET /api/v1/merchants/most_items?quantity=x
GET /api/v1/revenue?start=<start_date>&end=<end_date>
GET /api/v1/merchants/:id/revenue
```
