`import DS from 'ember-data'`
`import ProxyEndpointRelatedAdapter from 'gateway-ui/pods/proxy-endpoint-related/adapter'`
`import config from  'gateway-ui/config/environment'`
`import t from 'gateway-ui/helpers/i18n'`
`import jsonSchemaValidatorHelper from 'gateway-ui/helpers/json-schema-validator'`


# Takes a nested object and returns an array of dotted root to leaf paths
# through the object.
# For example:  ['root.node1.node2.leaf1', 'root.node1.node3.leaf2']
expandKeyPaths = (obj) ->
  keyPaths = []
  currentBuffer = []
  buffer = (obj) ->
    keys = Object.keys(obj) if typeof obj is 'object'
    # if no keys (this is a leaf node), push the buffer
    if !keys?.length
      keyPaths.push currentBuffer.join('.')
    else
      keys.forEach (key) ->
        currentBuffer.push key if (key != 'schema') and (key != 'enum')
        buffer obj[key]
        currentBuffer.pop() if (key != 'schema') and (key != 'enum')
  buffer obj
  keyPaths


# Checks validity of schemas.  If schemas are invalid JSON, a `DS.InvalidError`
# is returned.
getSchemaJsonValidationError = (snapshot) ->
  data = card = snapshot.attributes()
  {request_schema, response_schema} = data if data

  # Validate that schemas are JSON.
  try
    parsedRequestSchema = JSON.parse(request_schema) if request_schema
  catch e
    errorField = 'request_schema'
    message = t 'errors.invalid-json'
  try
    parsedResponseSchema = JSON.parse(response_schema) if response_schema
  catch e
    errorField = 'response_schema'
    message = t 'errors.invalid-json'

  # Validate that schemas are valid JSON schemas.
  # TODO:  HTML-formatted error messages are not ideal
  if parsedRequestSchema
    errors = jsonSchemaValidatorHelper parsedRequestSchema
    if errors
      errorField = 'request_schema'
      errorMessage = t 'errors.invalid-json-schema'
      errorFields = expandKeyPaths(errors.validation).map((path) -> "<li><code>#{path}</code></li>").join('')
      message = "#{errorMessage.capitalize()}: <ul><li>#{t 'fields.request_schema'}:<ul>#{errorFields}</ul></li></ul>".htmlSafe()
  if parsedResponseSchema
    errors = jsonSchemaValidatorHelper parsedResponseSchema
    if errors
      errorField = 'response_schema'
      errorMessage = t 'errors.invalid-json-schema'
      errorFields = expandKeyPaths(errors.validation).map((path) -> "<li><code>#{path}</code></li>").join('')
      message = "#{errorMessage.capitalize()}: <ul><li>#{t 'fields.response_schema'}:<ul>#{errorFields}</ul></li></ul>".htmlSafe()

  if errorField and message
    new DS.InvalidError [
      detail: message
      source:
        pointer: '/data'
    ]


createOrUpdateRecord = (store, type, snapshot) ->
  err = getSchemaJsonValidationError snapshot
  if err
    Ember.RSVP.reject err
  else
    @_super arguments...


ProxyEndpointSchemaAdapter = ProxyEndpointRelatedAdapter.extend
  createRecord: createOrUpdateRecord
  updateRecord: createOrUpdateRecord

`export default ProxyEndpointSchemaAdapter`
