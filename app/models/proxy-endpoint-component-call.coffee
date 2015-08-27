`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component',
    inverse: null
    async: false

  # manual dirtying
  remoteEndpointDirty: Ember.computed 'remote_endpoint.[]', ->
    original = @get('_data.remote_endpoint.id') or null
    current = @get('remote_endpoint.id') or null
    original != current
  beforeDirty: Ember.computed 'before.@each.hasDirtyAttributes', ->
    @get('before').filterBy('hasDirtyAttributes', true).get('length')
  afterDirty: Ember.computed 'after.@each.hasDirtyAttributes', ->
    @get('after').filterBy('hasDirtyAttributes', true).get('length')
  relationshipsDirty: Ember.computed 'remoteEndpointDirty', 'beforeDirty', 'afterDirty', ->
    @get('remoteEndpointDirty') or @get('beforeDirty') or @get('afterDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

  reload: ->
    # delegate reload to parent proxy endpoint component
    @get('proxy_endpoint_component').reload()
  rollback: ->
    @get('before')?.forEach (record) -> record.rollback()
    @get('after')?.forEach (record) -> record.rollback()
    @_super.apply @, arguments
  save: ->
    # delegate save to parent proxy endpoint component and then
    # "rollback" to now-saved embedded record
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('proxy_endpoint_component').save().then (=>
        @rollback()
        resolve @
      ), (=> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @get('proxy_endpoint_component.calls').removeObject @
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    component = @get 'proxy_endpoint_component'
    component.save().then (->
      component.rollback()
    ), (=>)

`export default ProxyEndpointComponentCall`
