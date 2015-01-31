`import DS from 'ember-data'`

Route = DS.Model.extend
  path: DS.attr 'string'
  get_method: DS.attr 'boolean', defaultValue: false
  post_method: DS.attr 'boolean', defaultValue: false
  put_method: DS.attr 'boolean', defaultValue: false
  delete_method: DS.attr 'boolean', defaultValue: false
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  methodsArray: Ember.computed 'get_method', 'post_method', 'put_method', 'delete_method', ->
    methods = for method in ['get', 'post', 'put', 'delete']
      method.toUpperCase() if @get "#{method}_method"
    methods.compact()
  toJSON: ->
    path: @get 'path'
    methods: @get 'methodsArray'

`export default Route`
