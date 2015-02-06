`import DS from 'ember-data'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = DS.Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string'
  conditional_positive: DS.attr 'boolean', defaultValue: true
  proxy_endpoint: DS.belongsTo 'proxy-endpoint'
  #before: DS.hasMany 'proxy-endpoint-component-before'
  #after: DS.hasMany 'proxy-endpoint-component-after'
  #call: DS.hasOne 'proxy-endpoint-component-call'
  #calls: DS.hasMany 'proxy-endpoint-component-call'
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
  name: Ember.computed 'type', ->
    t(switch @get 'type'
        when 'single' then 'proxy-endpoint-component-types.single-proxy'
        when 'multi' then 'proxy-endpoint-component-types.multi-proxy'
        when 'js' then 'proxy-endpoint-component-types.javascript-logic').capitalize()

`export default ProxyEndpointComponent`
