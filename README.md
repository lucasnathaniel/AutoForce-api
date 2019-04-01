# AutoForce API

## http://localhost:3000/

## Api Version: 1.0

### Overview

A platform to receive Purchase Orders from other systems, group them on Batches and follow the Orders in the production pipeline until the dispatch.

## Actions

### Order

#### New Order

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