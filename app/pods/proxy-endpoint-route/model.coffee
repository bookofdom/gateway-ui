`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

ProxyEndpointRoute = Model.extend
  path: DS.attr 'string', defaultValue: '/'
  get_method: DS.attr 'boolean', defaultValue: true
  post_method: DS.attr 'boolean', defaultValue: false
  put_method: DS.attr 'boolean', defaultValue: false
  delete_method: DS.attr 'boolean', defaultValue: false

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false

  # Computed
  name: Ember.computed 'path', -> @get 'path'

`export default ProxyEndpointRoute`
