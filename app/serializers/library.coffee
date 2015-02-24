`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

LibrarySerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # Serializes `body` back into `data`
    serialized.data = model.get 'body'
    delete serialized['body']
    serialized

`export default LibrarySerializer`