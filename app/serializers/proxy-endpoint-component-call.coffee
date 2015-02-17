`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentCallSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # IDs should be numeric
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized

`export default ProxyEndpointComponentCallSerializer`
