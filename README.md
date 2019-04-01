# AutoForce API

## http://localhost:3000/

## Api Version: 1.0

### Overview

A platform to receive Purchase Orders from other systems, group them on Batches and follow the Orders in the production pipeline until the dispatch.

## Actions

### Order

#### New Order

Creates a new Order and receives all the new params.

##### URL
```
POST /orders
```

##### Params
- `reference`,
- `purchase_channel`,
- `client_name`,
- `address`,
- `delivery_service`,
- `total_value`,
- `line_item`.

##### Exemple
```
curl http://localhost:3000/orders -X POST -H "Content-Type: application/json" -d '{"reference":"BR102030", "purchase_channel":"Site BR", "client_name":"Joao", "address":"rua do limao", "delivery_service":"SEDEX", "total_value":666.66, "line_item":"iphone"}'
```

#### Status of an Order

Search an Order by refernce or client name and receives all params from it.

##### URL
```
GET /orders/search/reference/:reference
GET /orders/search/client_name/:client_name
```
##### Params
- `reference`, or
- `client_name`.

##### Exemple
```
curl http://localhost:3000/orders/search/reference/B0002I6HKW
```

#### Order list from a purchase channel

Search an Order list by purchase channel and return all of them.

##### URL
```
GET orders/search/purchase_channel/:purchase_channel
```

##### Params
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/orders/search/purchase_channel/SiteBR
```

### Batch

#### New Batch

Creates a new Batch, set all orders with the same purchase channel to this batch and with production status, and receives all the new params with the amount of orders modified.

##### URL
```
POST /batches
```

##### Params
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/batches -X POST -H "Content-Type: application/json" -d '{"purchase_channel":"Site BR"}'
```

#### Produce a Batch

Search and Batch from reference, and set all Orders related to closing status.

##### URL
```
GET /batches/produce/reference/:reference
```

##### Params
- `reference`.

##### Exemple
```
curl http://localhost:3000/batches/produce/reference/201956-2
```

#### Close part of a Batch for a Delivery Service

Search and Batch from reference, and set all Orders related from the delivery service, also searched, to sent status.

##### URL
```
GET /batches/close/:reference/:delivery_service
```

##### Params
- `reference`,
- `delivery_service`.

##### Exemple
```
curl http://localhost:3000/batches/close/201956-2/SEDEX
```

#### Financial report

Search a Batch from purchase channel and receives itself with the sum of total values from all Orders on this channl, and also the amount.

##### URL
```
GET /batches/financial_report/:purchase_channel
```

##### Params
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/batches/financial_report/Site BR
```

### TO-DO
- `Finish all tests with RSpec`,
- `Put implementation tests as rails_best_pratice, ubycritc or/and rubocop`,
- `Finish all exceptions errors`,
- `Action for edit Order in production`.

### About

#### A security layer, to prevent script kiddies from messing up our Orders and putting on YouTube/A permission layer, that way we can be sure that each user is only working with their stuff.
```
We just need to implement a HTTP Token to prevent security troubles. But if need of a better security layer, we can use gems like 'Devise Token Auth'.
```

#### A web UI to control everything directly, without the need of going thought the API.
```
This is a awesome idea, with a front-end developer we can do that.
```