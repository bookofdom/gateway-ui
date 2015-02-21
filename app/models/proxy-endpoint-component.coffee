`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string'
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string'
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  call: DS.belongsTo 'proxy-endpoint-component-call'
  #calls: DS.hasMany 'proxy-endpoint-component-call'
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
  beforeDirty: Ember.computed 'before.@each.isDirty', ->
    @get('before').filterBy('isDirty', true).get('length')
  afterDirty: Ember.computed 'after.@each.isDirty', ->
    @get('after').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'callDirty', 'beforeDirty', 'afterDirty', ->
    @get('callDirty') or @get('beforeDirty') or @get('afterDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  reload: ->
    # no op reload, since components are embedded records
    new Ember.RSVP.Promise (resolve, reject) => resolve @
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
