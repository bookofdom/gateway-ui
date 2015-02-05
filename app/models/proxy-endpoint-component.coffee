`import DS from 'ember-data'`

ProxyEndpointComponent = DS.Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string'
  conditional_positive: DS.attr 'boolean', defaultValue: true
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  #before: DS.hasMany 'proxy-endpoint-component-before'
  #after: DS.hasMany 'proxy-endpoint-component-after'
  #call: DS.hasOne 'proxy-endpoint-component-call'
  # computed
  single: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'single' if value? and (value != previousValue)
    @get('type') == 'single'
  multi: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'multi' if value? and (value != previousValue)
    @get('type') == 'multi'
  js: Ember.computed 'type', (key, value, previousValue) ->
    @set 'type', 'js' if value? and (value != previousValue)
    @get('type') == 'js'

`export default ProxyEndpointComponent`
