`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentCallSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    before:
      embedded: 'always'
    after:
      embedded: 'always'
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # IDs should be numeric
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized.component_id = parseInt(serialized.component_id, 10) if serialized.component_id?
    serialized.remote_endpoint_id = parseInt(serialized.remote_endpoint_id, 10) if serialized.remote_endpoint_id?
    serialized

`export default ProxyEndpointComponentCallSerializer`
