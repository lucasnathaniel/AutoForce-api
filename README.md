# AutoForce API

## http://localhost:3000/

## Api Version: 1.0

### Overview

A platform to receive Purchase Orders from other systems, group them on Batches and follow the Orders in the production pipeline until the dispatch.

## Actions

### Order

##### URL
```
/orders
```

#### New Order (DONE)

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
curl http://localhost:3000/orders -H "Accept: application/json" -X POST -d '{"reference":"BR102030", "purchase_channel":"Site BR", "client_name":"Joao", "address":"rua do limao", "delivery_service":"SEDEX", "total_value":666.66, "line_item":"iphone"}'
```

#### Status of an Order (TODO)

##### Params
- `reference`,
- `client_name`.

##### Exemple
```
TODO
```

#### Order list from a purchase channel (TODO)

##### Params
- `purchase_channel`.

### Batch

##### URL
```
/batchs
```

#### New Batch (DONE)

##### Params
- `reference`,
- `purchase_channel`.

##### Exemple
```
curl http://localhost:3000/batchs -H "Accept: application/json" -X POST -d '{"reference":"201803-54", "purchase_channel":"Site BR"}'
```

#### Produce a Batch (TODO)

##### Params
- `reference`,
- `purchase_channel`.

##### Exemple
```
TODO
```

#### Close part of a Batch for a Delivery Service (TODO)

##### Params
- `reference`,
- `purchase_channel`,
- `delivery_service`.

##### Exemple
```
TODO
```

#### Financial report (TODO)

##### Params
- `purchase_channel`.

##### Exemple
```
TODO
```