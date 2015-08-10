`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointRoute = Model.extend
  path: DS.attr 'string', defaultValue: '/'
  get_method: DS.attr 'boolean', defaultValue: true
  post_method: DS.attr 'boolean', defaultValue: false
  put_method: DS.attr 'boolean', defaultValue: false
  delete_method: DS.attr 'boolean', defaultValue: false

  # Computed
  name: Ember.computed 'path', -> @get 'path'
  methodsArray: Ember.computed 'get_method', 'post_method', 'put_method', 'delete_method', ->
    methods = for method in ['get', 'post', 'put', 'delete']
      method.toUpperCase() if @get "#{method}_method"
    methods.compact()

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'

`export default ProxyEndpointRoute`
