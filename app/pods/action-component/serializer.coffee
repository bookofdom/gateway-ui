`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ActionComponentSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    job:
      serialize: false
    shared_component:
      serialize: 'id'
    calls:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.calls ?= []
    hash.before ?= []
    hash.after ?= []
    @normalizeIds hash
    @normalizeCalls hash
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super arguments...
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
    serialized = @_super arguments...
    @serializeIds serialized
    @serializeCalls serialized
    # Serializes `body` back into `data`
    serialized.data = serialized.body
    delete serialized['body']
    serialized = @serializeSharedComponent serialized if serialized.shared_component_id
    serialized
  serializeIds: (serialized) ->
    id = serialized.id
    passThroughId = serialized.pass_through_id
    sharedComponentId = serialized.shared_component_id
    serialized.proxy_endpoint_component_reference_id = parseInt(id, 10) if id
    serialized.proxy_endpoint_component_id = parseInt(passThroughId, 10) if passThroughId
    serialized.shared_component_id = parseInt(sharedComponentId, 10) if sharedComponentId
    delete serialized.id
    delete serialized.pass_through_id
  serializeCalls: (serialized) ->
    if serialized.type == 'single'
      serialized.call = serialized.calls[0] if serialized.calls
      delete serialized.calls
    serialized
  serializeSharedComponent: (serialized) ->
    # components associated with a shared component have a simplified payload
    serialized =
      proxy_endpoint_component_id: serialized.proxy_endpoint_component_id
      proxy_endpoint_component_reference_id: serialized.proxy_endpoint_component_reference_id
      shared_component_id: serialized.shared_component_id

`export default ActionComponentSerializer`
