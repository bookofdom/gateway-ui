`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestPairSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized

`export default ProxyEndpointTestPairSerializer`
