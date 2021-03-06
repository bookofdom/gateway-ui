`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

ProxyEndpointComponentCallSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    proxy_endpoint_component:
      serialize: false
    before:
      embedded: 'always'
    after:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.before = [] if !hash.before
    hash.after = [] if !hash.after
    @_super arguments...

`export default ProxyEndpointComponentCallSerializer`
