# AutoForce API

## http://localhost:3000/

## Api Version: 1.0

### Overview

A platform to receive Purchase Orders from other systems, group them on Batches and follow the Orders in the production pipeline until the dispatch.

## Actions

### Order

#### New Order (DONE)

##### URL
```
/orders
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

#### Status of an Order (DONE)

##### URL
```
/orders/search/reference/:reference
/orders/search/client_name/:client_name
```
##### Params
- `reference`, or
- `client_name`.

##### Exemple
```
curl http://localhost:3000/orders/search/reference/B0002I6HKW
```

#### Order list from a purchase channel (DONE)

##### URL
```
orders/search/purchase_channel/:purchase_channel
```

##### Params
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/orders/search/purchase_channel/SiteBR
```

### Batch

#### New Batch (DONE)

##### URL
```
/batches
```

##### Params
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/batches -X POST -H "Content-Type: application/json" -d '{"purchase_channel":"Site BR"}'
```

#### Produce a Batch (DONE)

##### URL
```
/batches/produce/reference/:reference
```

##### Params
- `reference`.

##### Exemple
```
curl http://localhost:3000/batches/produce/reference/201956-2
```

#### Close part of a Batch for a Delivery Service (TODO)

##### URL
```
/batches/reference/:reference/:delivery_service
```

##### Params
- `reference`,
- `purchase_channel`,
- `delivery_service`.

##### Exemple
```
TODO
```

#### Financial report (TODO)

##### URL
```
/batches/financial
```

##### Params
- `purchase_channel`.

##### Exemple
```
TODO
```