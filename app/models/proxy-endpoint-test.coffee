`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string', defaultValue: 'Test'
  method: DS.attr 'string', defaultValue: 'GET'
  route: DS.attr 'string'
  body: DS.attr 'string'

  # Computed
  methodType: Ember.computed 'method', ->
    method = @get 'method'
    ProxyEndpointTest.methods.findBy 'value', method

  # Relationships
  pairs: DS.hasMany 'proxy-endpoint-test-pairs'
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'

  # manually manage relationship dirty
  pairsDirty: Ember.computed 'pairs.@each.isDirty', ->
    @get('pairs').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'pairsDirty', ->
    @get('pairsDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

  reload: ->
    @get('proxy_endpoint').reload()
  rollback: ->
    @get('pairs')?.forEach (record) -> record.rollback()
    @_super.apply @, arguments
  save: ->
    # delegate save to parent proxy endpoint and then
    # "rollback" to now-saved embedded record
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('errors').clear()
      @get('proxy_endpoint').save().then (=>
        @rollback()
        @get('proxy_endpoint')?.rollback()
        resolve @
      ), (-> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    proxyEndpoint = @get 'proxy_endpoint'
    proxyEndpoint.save().then (->
      proxyEndpoint.rollback()
    ), (=>)

# Declare available methods and their human-readable names
methods = 'get post put delete'.split(' ').map (method) ->
  name: t "http-methods.#{method}"
  slug: method
  value: method.toUpperCase()

ProxyEndpointTest.reopenClass
  methods: methods

`export default ProxyEndpointTest`
