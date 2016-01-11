`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    calls:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeCalls hash
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  normalizeCalls: (hash) ->
    if hash.type == 'single'
      hash.calls = [hash.call]
      delete hash.call
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    @serializeCalls serialized
    # Serializes `body` back into `data`
    serialized.data = model.get 'body'
    delete serialized['body']
    serialized
  serializeCalls: (serialized) ->
    if serialized.type == 'single'
      serialized.call = serialized.calls[0] if serialized.calls
      delete serialized.calls
    serialized

`export default ProxyEndpointComponentSerializer`
