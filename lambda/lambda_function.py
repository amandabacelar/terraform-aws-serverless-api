import json
import os
import uuid

import boto3


dynamodb = boto3.resource("dynamodb")
table_name = os.environ["TABLE_NAME"]
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    print("Request received")

    method = event.get("requestContext", {}).get("http", {}).get("method")
    path_parameters = event.get("pathParameters") or {}

    print(f"HTTP method: {method}")

    if method == "POST":
        return create_product(event)

    if method == "GET" and path_parameters.get("id"):
        return get_product(path_parameters["id"])

    if method == "GET":
        return list_products()

    if method == "DELETE" and path_parameters.get("id"):
        return delete_product(path_parameters["id"])

    return response(404, {"message": "Route not found"})


def create_product(event):
    body = json.loads(event.get("body") or "{}")

    product_id = str(uuid.uuid4())

    product = {
        "id": product_id,
        "name": body["name"],
        "price": body["price"],
    }

    print("Creating product")

    table.put_item(Item=product)

    print("Product created successfully")

    return response(201, product)


def list_products():
    print("Listing products")

    result = table.scan()

    return response(200, result.get("Items", []))


def get_product(product_id):
    print(f"Getting product: {product_id}")

    result = table.get_item(
        Key={
            "id": product_id
        }
    )

    item = result.get("Item")

    if not item:
        return response(404, {"message": "Product not found"})

    return response(200, item)


def delete_product(product_id):
    print(f"Deleting product: {product_id}")

    result = table.get_item(
        Key={
            "id": product_id
        }
    )

    if "Item" not in result:
        return response(404, {"message": "Product not found"})

    table.delete_item(
        Key={
            "id": product_id
        }
    )

    print("Product deleted successfully")

    return response(
        200,
        {"message": "Product deleted successfully"}
    )


def response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body, default=str)
    }