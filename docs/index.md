# Xanyah API Documentation

This document is here to explain the workflow about creating data in Xanyah API. It will refer to the different endpoints documented [here](https://xanyah.github.io/xanyah-api/).

## User management

We're using [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) to manage users. The usage documentation can be found [here](https://github.com/lynndylanhurley/devise_token_auth#usage-tldr).

## Products

Products are a complex entity to handle. The problem of a product is that it can have a lot of similar items, and a product can have different prices depending on its color, or provider. To avoid all those duplicates, we created another entity, named `Variant`, that belongs to a product. The product will have the main caracteristics (name, category and manufacturer), and its variants will have their own price, provider or [custom attributes](#custom-attributes).

## How to create a product

- [Create a product](https://xanyah.github.io/xanyah-api/#products-products-collection-post)
- [Create a variant](https://xanyah.github.io/xanyah-api/#variants-variants-collection-post)

The default quantity of a variant is 0. It can't be changed. If you want to add items to your variant, you must [create an inventory](#inventories) of [create a shipping](#shippings)

## Custom attributes

Since each store will have its own way to define variants, we added [custom attributes](https://xanyah.github.io/xanyah-api/#custom-attributes). Each custom attribute has a name and a type (only `text` or `number` at the time of writing).
If you want to add a custom attribute to a variant, you must [create a variant attribute](https://xanyah.github.io/xanyah-api/#variant-attributes-variant-attributes-collection-post) that is linked to the variant and the custom attribute, with the value of the attribute.

## Inventories

An inventory is a temporary state of products willing to replace the current one. To avoid conflicts with the current state of products, an inventory has many `inventory_variants` that refer to a variant, with the new quantity. Once the inventory is locked, it will replace the current state of products and a stock backup will be created.
You can [delete an inventory](https://xanyah.github.io/xanyah-api/#inventories-single-inventory-delete) while it isn't locked.

### How to create an inventory

- [Create an inventory](https://xanyah.github.io/xanyah-api/#inventories-inventories-collection-post)
- [Create inventory variants](https://xanyah.github.io/xanyah-api/#inventory-variants-inventory-variants-collection-post)
- [Lock the inventory](https://xanyah.github.io/xanyah-api/#inventories-single-inventory-patch)

:warning: Locking the inventory will replace the current state of products forever, even if a stock backup is created :warning:

## Shippings

A shipping is an entity created to allow users adding quantities to their products. The quantity of the variant is only updated when the shipping is locked. To avoid conflicts, a shipping has many `shipping_variants` that refer to a variant, with the quantity to add to the current variant.
You can [delete a shipping](https://xanyah.github.io/xanyah-api/#shippings-single-shipping-delete) while it isn't locked.

## How to create a shipping

- [Create a shipping](https://xanyah.github.io/xanyah-api/#shippings-shippings-collection-post)
- [Create shipping variants](https://xanyah.github.io/xanyah-api/#shipping-variants-shipping-variants-collection-post)
- [Lock the shipping](https://xanyah.github.io/xanyah-api/#shippings-single-shipping-patch)

:warning: Locking the shipping **will not** replace the quantity of the variant but add it. If your variant had a quantity of 10 and the shipping variant 2, locking will change the quantity to 12. :warning:

## How to import variants

`POST /file_imports`

### Headers

Login headers are required

`Content-Type: multipart/form-data`

### Supported file types

JSON, CSV

#### CSV

CSV files must have a header line with the required keys (see below)

#### JSON

JSON files must be an array of objects with the required keys (see below)

### Required keys

- `product_name`
- `product_category`
- `product_manufacturer`
- `product_store`
- `variant_original_barcode`
- `variant_buying_price`
- `variant_tax_free_price`
- `variant_provider`
- `variant_ratio`

### Example

```
POST /file_imports HTTP/1.1
Host: localhost:3000
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
access-token: 0JSxBZnR2Oh4ZCsOnfZY6A
token-type: Bearer
client: rF6m_YENfHsg0twyKMXEeQ
expiry: 1526138245
uid: owner@xanyah.io
Cache-Control: no-cache
Postman-Token: 17cbb578-fa15-4d35-ab10-b8d9a5bc6929

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="file"; filename="variants.csv"
Content-Type: text/csv


------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="store_id"

b435b8b7-de9c-45b9-857f-573910ac8c6a
------WebKitFormBoundary7MA4YWxkTrZu0gW--
```
