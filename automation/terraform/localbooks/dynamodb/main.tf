provider "aws" {
  region = "us-east-1"
}

## Create table
resource "aws_dynamodb_table" "localbooks" {
  name           = "localbooks"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "isbn"
  attribute {
    name = "isbn"
    type = "S"
  }
}

## Add sample data
resource "aws_dynamodb_table_item" "localbooks" {
  table_name = aws_dynamodb_table.localbooks.name
  hash_key   = aws_dynamodb_table.localbooks.hash_key
  for_each = {
    item1 = {
      "isbn": "978020137962",
      "title": "example1",
      "author": "Jon Doe",
      "description": "description1"
    }

    item2 = {
      "isbn": "978020137789",
      "title": "example2",
      "author": "Jane Doe",
      "description": "description2"
    }
  }
  item = <<EOF
{
  "isbn": {"S": "${each.value.isbn}"},
  "title": {"S": "${each.value.title}"},
  "author": {"S": "${each.value.author}"},
  "description": {"S": "${each.value.description}"}
}
EOF
}
