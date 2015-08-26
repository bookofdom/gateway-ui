`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string'
  method: DS.attr 'string', defaultValue: 'GET'
  route: DS.attr 'string'
  content_type: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  headers: DS.hasMany 'proxy-endpoint-test-header', async: false
  query: DS.hasMany 'proxy-endpoint-test-query-parameter', async: false

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
