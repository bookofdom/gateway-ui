`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

JobComponent = Model.extend
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
  job: DS.belongsTo 'job', async: false
  calls: DS.hasMany 'job-component-call',
    async: false
    stains: true
    embeddedModel: true
  before: DS.hasMany 'job-component-transformation',
    async: false
    stains: true
    embeddedModel: true
  after: DS.hasMany 'job-component-transformation',
    async: false
    stains: true
    embeddedModel: true

  # computed
  typeKind: Ember.computed 'type', 'shared_component.typeKind', ->
    sharedTypeKind = @get 'shared_component.typeKind'
    type = @get 'type'
    sharedTypeKind or JobComponent.types.findBy('value', type)
  typeName: Ember.computed 'typeKind.name', ->
    @get 'typeKind.name'
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
  nameKey: Ember.computed 'type', 'shared', ->
    type = @get 'type'
    type = 'shared' if @get 'shared'
    "types.proxy-endpoint-component.#{type}"
  name: Ember.computed 'nameKey', ->
    t @get('nameKey')


# Declare available types and their human-readable names
types = 'single multi js'.split(' ').map (type) ->
  name: t "types.proxy-endpoint-component.#{type}"
  nameKey: "types.proxy-endpoint-component.#{type}"
  slug: type
  value: type

JobComponent.reopenClass
  types: types

`export default JobComponent`
