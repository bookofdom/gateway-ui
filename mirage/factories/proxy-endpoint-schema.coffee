`import { Factory, faker } from 'ember-cli-mirage'`

ProxyEndpointSchemaFactory = Factory.extend
  name: -> "#{faker.lorem.words()[0].capitalize()} Schema"
  request_schema_type: 'json_schema'
  response_schema_type: 'json_schema'
  response_same_as_request: false
  response_schema: ->
    JSON.stringify
      title: 'Example Schema'
      type: 'object'
      # `children` are serialized as `properties` or `patternProperties` for `object` type nodes.
      patternProperties:
        'job|occupation':
          type: 'string'
      properties:
        # Children of an object are serialized as key/value pairs,
        # where `name` is the key and the value is... the serialized child.
        firstName:
          type: 'string'
        age:
          description: 'Age in years'
          type: 'integer'
          minimum: 0
        nickNames:
          type: 'array'
          uniqueItems: true
          minItems: 1
          # `children` are serialized to `items` for `array` type nodes.
          # Unlike children of an object, there are no key/value pairs.
          # Only one child is expected.  And the (only) child's serialization is
          # assigned directly to `items`.
          items:
            type: 'string'
            pattern: '[\w\s]*'
      # In JSON schema, required fields are expressed in their own array!
      # Exactly where you'd expect to find them!
      required: [
        'firstName'
        'age'
      ]
  request_schema: ->
    JSON.stringify
      title: 'Example Schema'
      type: 'object'
      description: 'An example schema'
      additionalProperties: false
      patternProperties:
        '^S_':
          type: 'string'
        '^I_':
          type: 'integer'
        '^N_':
          type: 'number'
        '^A_':
          type: 'array'
        '^O_':
          type: 'object'
      required: ['^O_']
      properties:
        name:
          type: 'string'
          title: 'Name'
          description: 'A name'
          pattern: '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$'
          minLength: 1
          maxLength: 10
        age:
          type: 'integer'
          title: 'Age'
          description: 'An age'
          multipleOf: 1.0
          minimum: 0
          maximum: 100
          exclusiveMinimum: true
          exclusiveMaximum: true
        size:
          type: 'number'
          title: 'Size'
          description: 'A size'
          multipleOf: 5.0
          minimum: 5
          maximum: 55
          exclusiveMinimum: true
          exclusiveMaximum: true
        friends:
          type: 'array'
          title: 'Friends'
          description: 'A list of friends'
          minItems: 1
          maxItems: 100
          uniqueItems: true
          items: [
            type: 'string'
          ,
            type: 'integer'
          ]
        phoneNumber:
          type: 'object'
          title: 'Phone Number'
          description: 'A phone number'
          minProperties: 1
          maxProperties: 10
          patternProperties:
            '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$':
              type: 'string'
          properties:
            zip:
              type: 'string'
          required: ['^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$']

`export default ProxyEndpointSchemaFactory`
