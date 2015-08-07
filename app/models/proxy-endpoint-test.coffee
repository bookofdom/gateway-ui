`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string'
  method: DS.attr 'string', defaultValue: 'GET'
  route: DS.attr 'string'
  content_type: DS.attr 'string'
  body: DS.attr 'string'

  # Observers
  cleanContentType: Ember.observer 'method', ->
    # unset content_type when method is GET or DELETE
    method = @get 'method'
    @set 'content_type', null if (method is 'GET') or (method is 'DELETE')

  # Computed
  methodType: Ember.computed 'method', ->
    method = @get 'method'
    ProxyEndpointTest.methods.findBy 'value', method
  isFormEncoded: Ember.computed 'content_type', ->
    @get('content_type') is 'application/x-www-form-urlencoded'
  isJson: Ember.computed 'content_type', ->
    @get('content_type') is 'application/json'
  isXml: Ember.computed 'content_type', ->
    @get('content_type') is 'application/xml'

  # Relationships
  headers: DS.hasMany 'proxy-endpoint-test-header'
  query: DS.hasMany 'proxy-endpoint-test-query-parameter'
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'

  # manually manage relationship dirty
  headersDirty: Ember.computed 'headers.@each.isDirty', ->
    @get('headers').filterBy('isDirty', true).get 'length'
  queryDirty: Ember.computed 'query.@each.isDirty', ->
    @get('query').filterBy('isDirty', true).get 'length'
  relationshipsDirty: Ember.computed 'headersDirty', 'queryDirty', ->
    @get('headersDirty') or @get('queryDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

  reload: ->
    @get('proxy_endpoint').reload()
  rollback: ->
    @get('headers')?.forEach (record) -> record.rollback()
    @get('query')?.forEach (record) -> record.rollback()
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
  executeTest: ->
    adapter = @container.lookup 'adapter:proxy-endpoint-test'
    adapter.executeTest @

# Declare available methods and their human-readable names
methods = 'get post put delete'.split(' ').map (method) ->
  name: t "http-methods.#{method}"
  slug: method
  value: method.toUpperCase()

# Declare available default content types
contentTypes = 'application/json application/xml application/x-www-form-urlencoded'.split(' ').map (type) ->
  name: type
  slug: type
  value: type

ProxyEndpointTest.reopenClass
  methods: methods
  contentTypes: contentTypes

`export default ProxyEndpointTest`
