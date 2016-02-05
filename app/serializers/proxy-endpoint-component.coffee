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
    @normalizeIds hash
    @normalizeCalls hash
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  normalizeIds: (hash) ->
    hash.id = hash.proxy_endpoint_component_reference_id
    hash.pass_through_id = hash.proxy_endpoint_component_id
    delete hash.proxy_endpoint_component_id
    hash
  normalizeCalls: (hash) ->
    if (hash.type is 'single') and hash.call
      hash.calls = [hash.call]
      delete hash.call
    hash

  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    @serializeIds serialized
    @serializeCalls serialized
    # Serializes `body` back into `data`
    serialized.data = serialized.body
    delete serialized['body']
    serialized
  serializeIds: (serialized) ->
    id = serialized.id
    passThroughId = serialized.pass_through_id
    serialized.proxy_endpoint_component_reference_id = parseInt(id, 10) if id
    serialized.proxy_endpoint_component_id = parseInt(passThroughId, 10) if passThroughId
    delete serialized.id
    delete serialized.pass_through_id
  serializeCalls: (serialized) ->
    if serialized.type == 'single'
      serialized.call = serialized.calls[0] if serialized.calls
      delete serialized.calls
    serialized

`export default ProxyEndpointComponentSerializer`
