`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string', defaultValue: ''

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  call: DS.belongsTo 'proxy-endpoint-component-call', async: false
  calls: DS.hasMany 'proxy-endpoint-component-call', async: false
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false

  # computed
  single: Ember.computed 'type',
    get: -> @get('type') == 'single'
    set: (key, value) ->
      @set 'type', 'single' if value?
      @get 'single'
  multi: Ember.computed 'type',
    get: -> @get('type') == 'multi'
    set: (key, value) ->
      @set 'type', 'multi' if value?
      @get 'multi'
  js: Ember.computed 'type',
    get: -> @get('type') == 'js'
    set: (key, value) ->
      @set 'type', 'js' if value?
      @get 'js'
  name: Ember.computed 'type', ->
    t(switch @get 'type'
        when 'single' then 'proxy-endpoint-component-types.single-proxy'
        when 'multi' then 'proxy-endpoint-component-types.multi-proxy'
        when 'js' then 'proxy-endpoint-component-types.javascript-logic').capitalize()

  callDirty: Ember.computed 'call.hasDirtyAttributes', ->
    @get('call')?.get 'hasDirtyAttributes'
  callsDirty: Ember.computed 'calls.@each.hasDirtyAttributes', ->
    @get('calls').filterBy('hasDirtyAttributes', true).get('length')
  beforeDirty: Ember.computed 'before.@each.hasDirtyAttributes', ->
    @get('before').filterBy('hasDirtyAttributes', true).get('length')
  afterDirty: Ember.computed 'after.@each.hasDirtyAttributes', ->
    @get('after').filterBy('hasDirtyAttributes', true).get('length')
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
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('errors').clear()
      @get('proxy_endpoint').save().then (=>
        @rollback()
        resolve @
      ), (-> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    @transitionTo 'loaded.saved' # clear deleted state
    proxyEndpoint = @get 'proxy_endpoint'
    proxyEndpoint.save().then (->
      proxyEndpoint.rollback()
    ), (=>)

`export default ProxyEndpointComponent`
