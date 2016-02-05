`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointComponent = Model.extend
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true
  body: DS.attr 'string', defaultValue: ''
  # Maps to proxy_endpoint_component_id, see serializer.
  # Using `proxy_endpoint_component_id` is apparently problematic for
  # no apparent reason.
  pass_through_id: DS.attr 'number'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  shared_component: DS.belongsTo 'shared-component', async: false
  calls: DS.hasMany 'proxy-endpoint-component-call',
    async: false
    stains: true
    embedded: true
  before: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embedded: true
  after: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embedded: true

  # computed
  single: Ember.computed 'type',
    get: -> @get('type') == 'single'
    set: (key, value) ->
      @set 'type', 'single' if value?
      @get 'single'
  multi: Ember.computed 'type',
    get: -> @get('type') == 'multi'
    set: (key, value) ->
      @set 'type', 'multi' if value?
      @get 'multi'
  js: Ember.computed 'type',
    get: -> @get('type') == 'js'
    set: (key, value) ->
      @set 'type', 'js' if value?
      @get 'js'
  name: Ember.computed 'type', ->
    type = @get 'type'
    t("proxy-endpoint-component-types.#{type}").capitalize()

`export default ProxyEndpointComponent`
