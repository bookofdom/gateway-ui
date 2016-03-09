`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ProxyEndpointComponentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    proxy_endpoint:
      serialize: false
    calls:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'
  normalize: (type, hash, property) ->
    hash.calls = [] if !hash.calls
    hash.before = [] if !hash.before
    hash.after = [] if !hash.after
    @normalizeCalls hash
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  normalizeCalls: (hash) ->
    if hash.type == 'single'
      hash.calls = [hash.call]
      delete hash.call
    hash
  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    @serializeCalls serialized
    # Serializes `body` back into `data`
    serialized.data = snapshot.attributes().body
    delete serialized['body']
    serialized
  serializeCalls: (serialized) ->
    if serialized.type == 'single'
      serialized.call = serialized.calls[0] if serialized.calls
      delete serialized.calls
    serialized

`export default ProxyEndpointComponentSerializer`
