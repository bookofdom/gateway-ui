`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

UserSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.password = ''
    hash.password_confirmation = ''
    @_super arguments...

`export default UserSerializer`
