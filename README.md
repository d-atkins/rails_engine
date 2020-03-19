# Rails Engine
This readme is a work in progress.

[Project Site](https://backend.turing.io/module3/projects/rails_engine/)
[Technical Requirements](https://backend.turing.io/module3/projects/rails_engine/requirements)
[Extensions](https://backend.turing.io/module3/projects/rails_engine/extensions)
[Evaluation](https://backend.turing.io/module3/projects/rails_engine/evaluation)

## Overview
Rails Engine is an API currently being developed in a simulated service-oriented architecture. Its purpose is to expose the data that powers an E-Commerce Application.

This API is being created as a part of Turing School of Software & Design's back-end engineering program.

## Setup
clone, bundle, rake db:{create,migrate}, rake csv:reseed, bundle exec rspec

## Endpoints

### Accessing Endpoints
rails s, localhost:3000 in URL of browser, navigate to desired URI

### Merchant Endpoints
```
GET /api/v1/merchants
GET /api/v1/merchants/:id
PUT /api/v1/merchants
PATCH /api/v1/merchants/:id
DELETE /api/v1/merchants/:id
```

### Business Intelligence Endpoints
```
GET /api
```
