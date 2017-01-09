`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

ProxyEndpointTest = Model.extend
  name: DS.attr 'string'
  method: DS.attr 'string', defaultValue: 'GET'
  channels: DS.attr 'boolean', defaultValue: false
  route: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  channel: DS.belongsTo 'proxy-endpoint-channel', async: false
  headers: DS.hasMany 'proxy-endpoint-test-header',
    async: false
    stains: true
    embeddedModel: true
  query: DS.hasMany 'proxy-endpoint-test-query-parameter',
    async: false
    stains: true
    embeddedModel: true
  arguments: DS.hasMany 'proxy-endpoint-test-argument',
    async: false
    stains: true
    embeddedModel: true

  # Computed
  methodType: Ember.computed 'method', ->
    method = @get 'method'
    ProxyEndpointTest.methods.findBy 'value', method

  executeTest: ->
    adapter = Ember.getOwner(@).lookup 'adapter:proxy-endpoint-test'
    adapter.executeTest @

# Declare available methods and their human-readable names
methods = 'get post put delete'.split(' ').map (method) ->
  name: t "http-methods.#{method}"
  slug: method
  value: method.toUpperCase()

ProxyEndpointTest.reopenClass
  methods: methods

`export default ProxyEndpointTest`
