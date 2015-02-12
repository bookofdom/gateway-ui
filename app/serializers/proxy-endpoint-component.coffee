`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    call:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  # Serializes `body` back into `data`
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data = model.get 'body'
    delete serialized['body']
    serialized

`export default ProxyEndpointComponentSerializer`
