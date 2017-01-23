`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

PasswordResetConfirmationSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.new_password = ''
    @_super arguments...

`export default PasswordResetConfirmationSerializer`
