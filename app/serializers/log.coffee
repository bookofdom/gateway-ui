`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

LogSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.body = hash.logs
    @_super.apply @, arguments

`export default LogSerializer`
