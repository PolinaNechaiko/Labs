# resource "aws_api_gateway_rest_api" "this" {
# #   body = jsonencode({
# #     openapi = "3.0.1"
# #     info = {
# #       title   = "example"
# #       version = "1.0"
# #     }
# #     paths = {
# #       "/path1" = {
# #         get = {
# #           x-amazon-apigateway-integration = {
# #             httpMethod           = "GET"
# #             payloadFormatVersion = "1.0"
# #             type                 = "HTTP_PROXY"
# #             uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
# #           }
# #         }
# #       }
# #     }
# #   })

#   name = module.label_api.id

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_resource" "courses" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   parent_id   = aws_api_gateway_rest_api.this.root_resource_id
#   path_part   = "courses"
# }

# resource "aws_api_gateway_method" "courses_option" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.courses.id
#   http_method   = "OPTIONS"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_method" "courses_post" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.courses.id
#   http_method   = "POST"
#   authorization = "NONE"
#   request_validator_id = aws_api_gateway_request_validator.this.id
#   request_models = {
#     "application/json" = replace("${module.label_api.id}-PostCourse", "-", "")
#   }
# }

# resource "aws_api_gateway_integration" "courses_integration" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.courses.id
#   http_method = aws_api_gateway_method.courses_option.http_method
#   type = "MOCK"
#   request_templates = { 
#     "application/json" = <<PARAMS
# { "statusCode": 200 }
# PARAMS
#   }
# }

# # # resource "aws_api_gateway_integration_response" "integration_response_get_courses" {
# # #   rest_api_id     = aws_api_gateway_rest_api.this.id
# # #   resource_id     = aws_api_gateway_resource.courses.id
# # #   http_method     = aws_api_gateway_method.courses_option.http_method
# # #   status_code     = "200"
# # # #   response_parameters = {
# # # #     # "method.response.header.access-control-allow-headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
# # # #     # "method.response.header.access-control-allow-methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
# # # #     # "method.response.header.access-control-allow-origin" = "'*'"
# # # #   }
# # # # response_parameters = { "integration.response.header.access-control-allow-origin" = "'*'" }
# # # }



# # # resource "aws_api_gateway_integration" "courses_integration" {
# # #   rest_api_id = aws_api_gateway_rest_api.this.id
# # #   resource_id = aws_api_gateway_resource.courses.id
# # #   http_method = aws_api_gateway_method.courses_option.http_method
# # # #   http_method = "OPTIONS"
# # #   type        = "AWS"
# # # }

# # resource "aws_api_gateway_method_response" "courses_option_response_200" {
# #   rest_api_id = aws_api_gateway_rest_api.this.id
# #   resource_id = aws_api_gateway_resource.courses.id
# #   http_method = aws_api_gateway_method.courses_option.http_method
# #   status_code = "200"
# # }

# # resource "aws_api_gateway_integration_response" "courses_integration_response" {
# #   rest_api_id = aws_api_gateway_rest_api.this.id
# #   resource_id = aws_api_gateway_resource.courses.id
# #   http_method = aws_api_gateway_method.courses_option.http_method
# #   status_code = aws_api_gateway_method_response.courses_option_response_200.status_code

# #   # Transforms the backend JSON response to XML
# #   response_templates = {
# #     "application/xml" = <<EOF
# # #set($inputRoot = $input.path('$'))
# # <?xml version="1.0" encoding="UTF-8"?>
# # <message>
# #     $inputRoot.body
# # </message>
# # EOF
# #   }
# # }

# resource "aws_api_gateway_deployment" "this" {
#   rest_api_id = aws_api_gateway_rest_api.this.id

#   triggers = {
#     redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_stage" "dev" {
#   deployment_id = aws_api_gateway_deployment.this.id
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   stage_name    = "dev"
# }


# # resource "aws_api_gateway_integration" "get_courses" {
# #   rest_api_id             = aws_api_gateway_rest_api.this.id
# #   resource_id             = aws_api_gateway_resource.courses.id
# #   http_method             = aws_api_gateway_method.courses_post.http_method
# #   integration_http_method = "POST"
# #   type                    = "AWS"
# #   uri                     = module.lambda.lambda_courses_invoke_arn
# #   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
# #   request_templates       = {
# #     "application/xml" = <<EOF
# #   {
# #      "body" : $input.json('$')
# #   }
# #   EOF
# #   }
# #   content_handling = "CONVERT_TO_TEXT"
# # }

# resource "aws_api_gateway_model" "post_course" {
#   rest_api_id  = aws_api_gateway_rest_api.this.id
#   name         = replace("${module.label_api.id}-PostCourse", "-", "")
#   description  = "a JSON schema"
#   content_type = "application/json"

#   schema = <<EOF
# {
#   "$schema": "http://json-schema.org/schema#",
#   "title": "CourseInputModel",
#   "type": "object",
#   "properties": {
#     "title": {"type": "string"},
#     "authorId": {"type": "string"},
#     "length": {"type": "string"},
#     "category": {"type": "string"}
#   },
#   "required": ["title", "authorId", "length", "category"]
# }
# EOF
# }

# resource "aws_api_gateway_request_validator" "this" {
#   name                        = "validate_request_body"
#   rest_api_id                 = aws_api_gateway_rest_api.this.id
#   validate_request_body       = true
# }




# # #####################


# resource "aws_api_gateway_resource" "authors" {
#   parent_id   = aws_api_gateway_rest_api.this.root_resource_id
#   path_part   = "authors"
#   rest_api_id = aws_api_gateway_rest_api.this.id
# }

# resource "aws_api_gateway_method" "get_authors" {
#   authorization = "NONE"
#   http_method   = "GET"
#   resource_id   = aws_api_gateway_resource.authors.id
#   rest_api_id   = aws_api_gateway_rest_api.this.id
# }

# resource "aws_api_gateway_integration" "get_authors" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.authors.id
#   http_method             = aws_api_gateway_method.get_authors.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
#   request_templates       = {
#     "application/xml" = <<EOF
#   {
#      "body" : $input.json('$')
#   }
#   EOF
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "get_authors" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.authors.id
#   http_method     = aws_api_gateway_method.get_authors.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "get_authors" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.authors.id
#   http_method = aws_api_gateway_method.get_authors.http_method
#   status_code = aws_api_gateway_method_response.get_authors.status_code

#   # # Transforms the backend JSON response to XML
#   # response_templates = {
#   #   "application/xml" = <<EOF
#   # {
#   #    "body" : $input.json('$')
#   # }
#   # EOF
#   # }
#   response_parameters ={
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }
# }

# module "cors" {
#   source = "squidfunk/api-gateway-enable-cors/aws"
#   version = "0.3.3"

#   api_id          = aws_api_gateway_rest_api.this.id
#   api_resource_id = aws_api_gateway_resource.authors.id
# }




# /////////////////////////////////////////////////////////////////////////
# //////////////////////////////////////////////////////////////////////////

# ////////////////////////////////////////////////////////////////////////////


# # resource "aws_api_gateway_method" "courses_option" {
# #   rest_api_id   = aws_api_gateway_rest_api.this.id
# #   resource_id   = aws_api_gateway_resource.courses.id
# #   http_method   = "OPTIONS"
# #   authorization = "NONE"
# # }

# # resource "aws_api_gateway_method" "courses_post" {
# #   rest_api_id   = aws_api_gateway_rest_api.this.id
# #   resource_id   = aws_api_gateway_resource.courses.id
# #   http_method   = "POST"
# #   authorization = "NONE"
# #   request_validator_id = aws_api_gateway_request_validator.this.id
# #   request_models = {
# #     "application/json" = replace("${module.label_api.id}-PostCourse", "-", "")
# #   }
# # }

# # resource "aws_api_gateway_integration" "courses_integration" {
# #   rest_api_id = aws_api_gateway_rest_api.this.id
# #   resource_id = aws_api_gateway_resource.courses.id
# #   http_method = aws_api_gateway_method.courses_option.http_method
# #   type = "MOCK"
# #   request_templates = { 
# #     "application/json" = <<PARAMS
# # { "statusCode": 200 }
# # PARAMS
# #   }
# # }


# resource "aws_api_gateway_resource" "Id"{
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   parent_id = aws_api_gateway_resource.courses.id
#   path_part = "{id}"
# }

# resource "aws_api_gateway_method" "Id_option" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.Id.id
#   http_method   = "OPTIONS"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "Id_integration" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.Id.id
#   http_method = aws_api_gateway_method.Id_option.http_method
#   type = "MOCK"
#   request_templates = { 
#     "application/json" = <<PARAMS
# { "statusCode": 200 }
# PARAMS
#   }
# }



# resource "aws_api_gateway_method" "delete_courses" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.Id.id
#   http_method   = "DELETE"
#   authorization = "NONE"
# }


# resource "aws_api_gateway_integration" "delete_courses" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.Id.id
#   http_method             = aws_api_gateway_method.delete_courses.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_delete_course_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
#   request_templates = {
#     "application/json" = jsonencode({
#       id = "$input.params('id')"
#     })
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "delete_courses" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.Id.id
#   http_method     = aws_api_gateway_method.delete_courses.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "delete_courses" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.Id.id
#   http_method = aws_api_gateway_method.delete_courses.http_method
#   status_code = aws_api_gateway_method_response.delete_courses.status_code

#   # # Transforms the backend JSON response to XML
#   # response_templates = {
#   #   "application/xml" = <<EOF
#   # {
#   #    "body" : $input.json('$')
#   # }
#   # EOF
#   # }
#   response_parameters ={
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }
# }



# resource "aws_api_gateway_method" "put_courses" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.Id.id
#   http_method   = "PUT"
#   authorization = "NONE"
# }


# resource "aws_api_gateway_integration" "put_courses" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.Id.id
#   http_method             = aws_api_gateway_method.put_courses.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_update_course_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
#   request_templates       = {
#     "application/xml" = <<EOF
#   {
#      "body" : $input.json('$')
#   }
#   EOF
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "put_courses" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.Id.id
#   http_method     = aws_api_gateway_method.put_courses.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "put_courses" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.Id.id
#   http_method = aws_api_gateway_method.put_courses.http_method
#   status_code = aws_api_gateway_method_response.put_courses.status_code

#   # # Transforms the backend JSON response to XML
#   # response_templates = {
#   #   "application/xml" = <<EOF
#   # {
#   #    "body" : $input.json('$')
#   # }
#   # EOF
#   # }
#   response_parameters ={
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }
# }



# # resource "aws_api_gateway_method" "course_post" {
# #   rest_api_id   = aws_api_gateway_rest_api.this.id
# #   resource_id   = aws_api_gateway_resource.courses.id
# #   http_method   = "POST"
# #   authorization = "NONE"
# #   request_validator_id = aws_api_gateway_request_validator.this.id
# #   request_models = {
# #     "application/json" = replace("${module.label_api.id}-PostCourse", "-", "")
# #   }
# # }

# # старі пост

# resource "aws_api_gateway_integration" "post_course" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.courses.id
#   http_method             = aws_api_gateway_method.courses_post.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_save_course_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
#   request_templates       = {
#     "application/xml" = <<EOF
#   {
#      "body" : $input.json('$')
#   }
#   EOF
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "post_course" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.courses.id
#   http_method     = aws_api_gateway_method.courses_post.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "post_course" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.courses.id
#   http_method = aws_api_gateway_method.courses_post.http_method
#   status_code = aws_api_gateway_method_response.post_course.status_code

#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin"  = "'*'"
#   }
# }

# //get_courses_id

# resource "aws_api_gateway_method" "get_courses_id" {
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   resource_id   = aws_api_gateway_resource.Id.id
#   http_method   = "GET"
#   authorization = "NONE"
#   request_parameters = {
#     "method.request.path.id" = true
#   }
# }

# resource "aws_api_gateway_integration" "get_courses_id" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.Id.id
#   http_method             = aws_api_gateway_method.get_courses_id.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_get_course_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
# request_templates = {
#     "application/json" = jsonencode({
#       id = "$input.params('id')"
#     })
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "get_courses_id" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.Id.id
#   http_method     = aws_api_gateway_method.get_courses_id.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "get_courses_id" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.Id.id
#   http_method = aws_api_gateway_method.get_courses_id.http_method
#   status_code = aws_api_gateway_method_response.get_courses_id.status_code

#   # # Transforms the backend JSON response to XML
#   # response_templates = {
#   #   "application/xml" = <<EOF
#   # {
#   #    "body" : $input.json('$')
#   # }
#   # EOF
#   # }
#   response_parameters ={
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }
# }



# // get_courses


# resource "aws_api_gateway_method" "get_courses" {
#   authorization = "NONE"
#   http_method   = "GET"
#   resource_id   = aws_api_gateway_resource.courses.id
#   rest_api_id   = aws_api_gateway_rest_api.this.id
# }

# resource "aws_api_gateway_integration" "get_courses" {
#   rest_api_id             = aws_api_gateway_rest_api.this.id
#   resource_id             = aws_api_gateway_resource.courses.id
#   http_method             = aws_api_gateway_method.get_courses.http_method
#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = module.lambda.lambda_courses_invoke_arn
#   request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
#   request_templates       = {
#     "application/xml" = <<EOF
#   {
#      "body" : $input.json('$')
#   }
#   EOF
#   }
#   content_handling = "CONVERT_TO_TEXT"
# }

# resource "aws_api_gateway_method_response" "get_courses" {
#   rest_api_id     = aws_api_gateway_rest_api.this.id
#   resource_id     = aws_api_gateway_resource.courses.id
#   http_method     = aws_api_gateway_method.get_courses.http_method
#   status_code     = "200"
#   response_models = { "application/json" = "Empty" }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = false
#   }
# }

# resource "aws_api_gateway_integration_response" "get_courses" {
#   rest_api_id = aws_api_gateway_rest_api.this.id
#   resource_id = aws_api_gateway_resource.courses.id
#   http_method = aws_api_gateway_method.get_courses.http_method
#   status_code = aws_api_gateway_method_response.get_courses.status_code

#   # # Transforms the backend JSON response to XML
#   # response_templates = {
#   #   "application/xml" = <<EOF
#   # {
#   #    "body" : $input.json('$')
#   # }
#   # EOF
#   # }
#   response_parameters ={
#     "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#     "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }
# }

resource "aws_api_gateway_rest_api" "this" {
  name = module.label_api.id

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

// create aws_api_gateway_resource

resource "aws_api_gateway_resource" "authors" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "authors"
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "courses"
}

resource "aws_api_gateway_resource" "course"{
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id = aws_api_gateway_resource.courses.id
  path_part = "{id}"
}

// create get-authors

resource "aws_api_gateway_method" "get_authors" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.authors.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "get_authors" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.get_authors.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_authors_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_authors" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.authors.id
  http_method     = aws_api_gateway_method.get_authors.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "get_authors" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_authors.http_method
  status_code = aws_api_gateway_method_response.get_authors.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

// create get-courses

resource "aws_api_gateway_method" "get_courses" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.courses.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_integration" "get_courses" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.get_courses.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_courses_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_courses" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.courses.id
  http_method     = aws_api_gateway_method.get_courses.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "get_courses" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_courses.http_method
  status_code = aws_api_gateway_method_response.get_courses.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

// create post-course

resource "aws_api_gateway_method" "post_course" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "POST"
  authorization = "NONE"
  request_validator_id = aws_api_gateway_request_validator.this.id
  request_models = {
    "application/json" = replace("${module.label_api.id}-PostCourse", "-", "")
  }
}

resource "aws_api_gateway_model" "post_course" {
  rest_api_id  = aws_api_gateway_rest_api.this.id
  name         = replace("${module.label_api.id}-PostCourse", "-", "")
  description  = "a JSON schema"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/schema#",
  "title": "CourseInputModel",
  "type": "object",
  "properties": {
    "title": {"type": "string"},
    "authorId": {"type": "string"},
    "length": {"type": "string"},
    "category": {"type": "string"}
  },
  "required": ["title", "authorId", "length", "category"]
}
EOF
}

resource "aws_api_gateway_integration" "post_course" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.post_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_save_course_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "post_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.courses.id
  http_method     = aws_api_gateway_method.post_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "post_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_course.http_method
  status_code = aws_api_gateway_method_response.post_course.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

// create get-course


resource "aws_api_gateway_method" "get_course" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.course.id
  http_method   = "GET"
  authorization = "NONE"
   request_validator_id = aws_api_gateway_request_validator.this.id
  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_integration" "get_course" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_get_course_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates = {
    "application/json" = jsonencode({
      id = "$input.params('id')"
    })
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.get_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

// create put-course

resource "aws_api_gateway_method" "put_course" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.course.id
  http_method   = "PUT"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "put_course" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.put_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_update_course_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "put_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.put_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "put_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.put_course.http_method
  status_code = aws_api_gateway_method_response.put_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

// create delete-course

resource "aws_api_gateway_method" "delete_course" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.course.id
  http_method   = "DELETE"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "delete_course" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.course.id
  http_method             = aws_api_gateway_method.delete_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.lambda_delete_course_invoke_arn
  request_parameters      = {"integration.request.header.X-Authorization" = "'static'"}
  request_templates       = {
    "application/xml" = <<EOF
  {
     "body" : $input.json('$')
  }
  EOF
  }
  content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "delete_course" {
  rest_api_id     = aws_api_gateway_rest_api.this.id
  resource_id     = aws_api_gateway_resource.course.id
  http_method     = aws_api_gateway_method.delete_course.http_method
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.course.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = aws_api_gateway_method_response.delete_course.status_code

  response_parameters ={
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

// create cors

module "cors_authors" {
  source  = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.this.id
  api_resource_id = aws_api_gateway_resource.authors.id
}

module "cors_courses" {
  source  = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.this.id
  api_resource_id = aws_api_gateway_resource.courses.id
}

module "cors_course" {
  source  = "squidfunk/api-gateway-enable-cors/aws"
  version = "0.3.3"

  api_id          = aws_api_gateway_rest_api.this.id
  api_resource_id = aws_api_gateway_resource.course.id
}

// create stage, validator, aws_api_gateway_deployment

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "dev"
}

resource "aws_api_gateway_request_validator" "this" {
  name                        = "validate_request_body"
  rest_api_id                 = aws_api_gateway_rest_api.this.id
  validate_request_body       = true
}
