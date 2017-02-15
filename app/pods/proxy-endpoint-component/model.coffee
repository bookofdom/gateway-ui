`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

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
  shared_component: DS.belongsTo 'shared-component',
    async: false
    stains: true
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  calls: DS.hasMany 'proxy-endpoint-component-call',
    async: false
    stains: true
    embeddedModel: true
  before: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embeddedModel: true
  after: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embeddedModel: true

  # computed
  typeKind: Ember.computed 'type', 'shared_component.typeKind', ->
    sharedTypeKind = @get 'shared_component.typeKind'
    type = @get 'type'
    sharedTypeKind or ProxyEndpointComponent.types.findBy('value', type)
  shared: Ember.computed 'shared_component', ->
    (!!@get 'shared_component') or (@get('type') == 'shared')
  single: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'single'
    set: (key, value) ->
      @set 'type', 'single' if value?
      @get 'single'
  multi: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'multi'
    set: (key, value) ->
      @set 'type', 'multi' if value?
      @get 'multi'
  js: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'js'
    set: (key, value) ->
      @set 'type', 'js' if value?
      @get 'js'
  advanced: Ember.computed 'typeKind.slug',
    get: -> @get('typeKind.slug') == 'advanced'
    set: (key, value) ->
      @set 'type', 'advanced' if value?
      @get 'advanced'
  nameKey: Ember.computed 'type', 'shared', ->
    type = @get 'type'
    type = 'shared' if @get 'shared'
    "types.proxy-endpoint-component.#{type}"


# Declare available types and their human-readable names
types = 'single multi js advanced'.split(' ').map (type) ->
  nameKey: "types.proxy-endpoint-component.#{type}"
  slug: type
  value: type

ProxyEndpointComponent.reopenClass
  types: types

`export default ProxyEndpointComponent`
