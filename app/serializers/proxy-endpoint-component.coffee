`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

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
    hash.id = hash.proxy_endpoint_component_reference_id
    hash.pass_through_id = hash.proxy_endpoint_component_id
    delete hash.proxy_endpoint_component_id
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
    id = serialized.id
    serialized.proxy_endpoint_component_reference_id = parseInt(id, 10) if id
    delete serialized.id
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
