`import { Factory, faker } from 'ember-cli-mirage'`

ProxyEndpointSchemaFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()} Schema"
  request_schema_type: 'json_schema'
  response_schema_type: 'json_schema'
  response_same_as_request: true
  response_schema: ''
  request_schema: ->
    JSON.stringify
      title: 'Example Schema'
      type: 'object'
      properties:
      	firstName:
      		type: 'string'
      	lastName:
      		type: 'string'
      	age:
      		description: 'Age in years'
      		type: 'integer'
      		minimum: 0
        nickNames:
          type: 'array'
          minItems: 1
          items:
            type: 'string'
          uniqueItems: true
      required: [
        'firstName'
        'lastName'
        'age'
      ]

`export default ProxyEndpointSchemaFactory`
