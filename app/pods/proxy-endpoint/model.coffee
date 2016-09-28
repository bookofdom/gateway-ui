`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Action from 'gateway/pods/action/model'`

ProxyEndpoint = Action.extend
  active: DS.attr 'boolean'
  cors_enabled: DS.attr 'boolean', defaultValue: true

  # Relationships
  routes: DS.hasMany 'proxy-endpoint-route',
    async: false
    stains: true
    embeddedModel: true
  components: DS.hasMany 'proxy-endpoint-component',
    async: false
    embeddedModel: true
  tests: DS.hasMany 'proxy-endpoint-test',
    async: false
    embeddedModel: true
  schemas: DS.hasMany 'proxy-endpoint-schema', async: true

`export default ProxyEndpoint`
