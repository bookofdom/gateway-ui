`import jsonSchemaSchema from 'gateway-ui/schemas/json-schema'`

env = jjv()
env.addSchema 'schema', jsonSchemaSchema

jsonSchemaValidatorHelper = (schemaObj) ->
  env.validate 'schema', schemaObj

`export default jsonSchemaValidatorHelper`
