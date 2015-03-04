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
    serialized

`export default ProxyEndpointComponentCallSerializer`
