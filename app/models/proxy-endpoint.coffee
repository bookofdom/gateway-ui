`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpoint = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'
  cors_enabled: DS.attr 'boolean'
  api: DS.belongsTo 'api', async: true
  environment: DS.belongsTo 'environment', async: true
  endpoint_group: DS.belongsTo 'endpoint-group', async: true
  routes: DS.hasMany 'proxy-endpoint-route'
  components: DS.hasMany 'proxy-endpoint-component'
  # Must manually manage isDirty for relationships:
  # http://paulferrett.com/2014/ember-model-isdirty-when-belongsto-changes/
  environmentDirty: Ember.computed 'environment.@each', ->
    original = @get('_data.environment.id') or null
    current = @get('environment.id') or null
    original != current
  endpointGroupDirty: Ember.computed 'endpoint_group.@each', ->
    original = @get('_data.endpoint_group.id') or null
    current = @get('endpoint_group.id') or null
    original != current
  routesDirty: Ember.computed 'routes.@each.isDirty', ->
    @get('routes').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDirty', 'endpointGroupDirty', 'routesDirty', ->
    @get('environmentDirty') or @get('endpointGroupDirty') or @get('routesDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  # copy errors from proxy endpoint into embedded relationships if necessary,
  # for proper UI messaging
  onComponentErrors: Ember.observer 'errors.components', ->
    @get('errors.components').forEach (error) =>
      @get('components').forEach (component) ->
        component.get('errors').add 'base', error.message
  # given a list of component IDs,
  # re-order the underlaying components array and save
  moveComponentByIdTo: (id, position) ->
    components = @get 'components'
    component = components.findBy 'id', id
    components.removeObject component
    components.insertAt position, component
    @save()
  reload: ->
    @rollback()
    @_super.apply @, arguments

`export default ProxyEndpoint`
