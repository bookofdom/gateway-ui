`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string', defaultValue: ''
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  call: DS.belongsTo 'proxy-endpoint-component-call'
  calls: DS.hasMany 'proxy-endpoint-component-call'
  before: DS.hasMany 'proxy-endpoint-component-transformation'
  after: DS.hasMany 'proxy-endpoint-component-transformation'
  # computed
  single: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'single' if value? and (value != previousValue)
    @get('type') == 'single'
  multi: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'multi' if value? and (value != previousValue)
    @get('type') == 'multi'
  js: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'js' if value? and (value != previousValue)
    @get('type') == 'js'
  name: Ember.computed 'type', ->
    t(switch @get 'type'
        when 'single' then 'proxy-endpoint-component-types.single-proxy'
        when 'multi' then 'proxy-endpoint-component-types.multi-proxy'
        when 'js' then 'proxy-endpoint-component-types.javascript-logic').capitalize()
  callDirty: Ember.computed 'call.isDirty', ->
    @get('call')?.get 'isDirty'
  callsDirty: Ember.computed 'calls.@each.isDirty', ->
    @get('calls').filterBy('isDirty', true).get('length')
  beforeDirty: Ember.computed 'before.@each.isDirty', ->
    @get('before').filterBy('isDirty', true).get('length')
  afterDirty: Ember.computed 'after.@each.isDirty', ->
    @get('after').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'callDirty', 'callsDirty', 'beforeDirty', 'afterDirty', ->
    @get('callDirty') or @get('callsDirty') or @get('beforeDirty') or @get('afterDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  reload: ->
    @get('proxy_endpoint').reload()
  rollback: ->
    @get('call')?.rollback()
    @get('calls')?.forEach (record) -> record.rollback()
    @get('before')?.forEach (record) -> record.rollback()
    @get('after')?.forEach (record) -> record.rollback()
    @_super.apply @, arguments
  save: ->
    # delegate save to parent proxy endpoint and then
    # "rollback" to now-saved embedded record
    @get('proxy_endpoint').save().then (=>
      @rollback()
    ), (=>)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    proxyEndpoint = @get 'proxy_endpoint'
    proxyEndpoint.save().then (->
      proxyEndpoint.rollback()
    ), (=>)

`export default ProxyEndpointComponent`
