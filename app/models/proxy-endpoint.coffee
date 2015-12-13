`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpoint = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'
  cors_enabled: DS.attr 'boolean'

  # Relationships
  api: DS.belongsTo 'api', async: true
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  endpoint_group: DS.belongsTo 'endpoint-group',
    async: false
    stains: true
  routes: DS.hasMany 'proxy-endpoint-route',
    async: false
    stains: true
    embedded: true
  components: DS.hasMany 'proxy-endpoint-component',
    async: false
    embedded: true
    errors: true
  tests: DS.hasMany 'proxy-endpoint-test',
    async: false
    embedded: true
    errors: true
  schemas: DS.hasMany 'proxy-endpoint-schema', async: true

  # given a list of component IDs,
  # re-order the underlaying components array and save
  moveComponentByIdTo: (id, position) ->
    components = @get 'components'
    component = components.findBy 'id', id
    components.removeObject component
    components.insertAt position, component
    @save()

`export default ProxyEndpoint`
