`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

SharedComponentSerializer = ApplicationSerializer.extend  DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: 'id'
    calls:
      embedded: 'always'
    ###
    before:
      embedded: 'always'
    after:
      embedded: 'always'
    ###

  normalize: (type, hash, property) ->
    @normalizeCalls hash
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  normalizeCalls: (hash) ->
    if (hash.type is 'single') and hash.call
      hash.calls = [hash.call]
      delete hash.call
    hash

  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    @serializeCalls serialized
    # Serializes `body` back into `data`
    serialized.data = serialized.body
    delete serialized['body']
    serialized
  serializeCalls: (serialized) ->
    if serialized.type == 'single'
      serialized.call = serialized.calls[0] if serialized.calls
      delete serialized.calls
    serialized

`export default SharedComponentSerializer`
