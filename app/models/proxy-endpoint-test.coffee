`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string'
  method: DS.attr 'string', defaultValue: 'GET'
  route: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  headers: DS.hasMany 'proxy-endpoint-test-header',
    async: false
    stains: true
    embedded: true
  query: DS.hasMany 'proxy-endpoint-test-query-parameter',
    async: false
    stains: true
    embedded: true
  arguments: DS.hasMany 'proxy-endpoint-test-argument',
    async: false
    stains: true
    embedded: true

  # Computed
  methodType: Ember.computed 'method', ->
    method = @get 'method'
    ProxyEndpointTest.methods.findBy 'value', method

  executeTest: ->
    adapter = @container.lookup 'adapter:proxy-endpoint-test'
    adapter.executeTest @

# Declare available methods and their human-readable names
methods = 'get post put delete'.split(' ').map (method) ->
  name: t "http-methods.#{method}"
  slug: method
  value: method.toUpperCase()

ProxyEndpointTest.reopenClass
  methods: methods

`export default ProxyEndpointTest`
