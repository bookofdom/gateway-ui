`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

Action = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: true
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  endpoint_group: DS.belongsTo 'endpoint-group',
    async: false
    stains: true

  # given a list of component IDs,
  # re-order the underlaying components array and save
  moveComponentByIdTo: (id, position) ->
    components = @get 'components'
    component = components.findBy 'id', id
    components.removeObject component
    components.insertAt position, component
    @save()

`export default Action`
