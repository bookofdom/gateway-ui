`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

SharedComponent = Model.extend
  # Fields
  name: DS.attr 'string'
  description: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'single'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean'
  body: DS.attr 'string', defaultValue: ''

  # Relationships
  api: DS.belongsTo 'api', async: false
  calls: DS.hasMany 'shared-component-call',
    async: false
    stains: true
    embedded: true
  before: DS.hasMany 'shared-component-transformation',
    async: false
    stains: true
    embedded: true
  after: DS.hasMany 'shared-component-transformation',
    async: false
    stains: true
    embedded: true

  # computed
  typeKind: Ember.computed 'type', ->
    type = @get 'type'
    SharedComponent.types.findBy 'value', type
  typeName: Ember.computed 'typeKind.name', ->
    @get 'typeKind.name'
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

# Declare available types and their human-readable names
types = 'single multi js'.split(' ').map (type) ->
  name: t "types.proxy-endpoint-component.#{type}"
  slug: type
  value: type

SharedComponent.reopenClass
  types: types

`export default SharedComponent`
