`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

EnvironmentSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # add data placeholder for now since the field is required by the server
    serialized.data = {}
    serialized

`export default EnvironmentSerializer`
