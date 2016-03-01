`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

SharedComponent = Model.extend
  # Related model names
  callModelName: 'shared-component-call'
  transformationModelName: 'shared-component-transformation'

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

  # Setup relationships
  # New components may need calls and transformations added
  #populateRelationshipsOnReady: Ember.on 'ready', -> @populateRelationships()
  populateRelationships: ->
    @addNewCall() if @get('single') and !@get('calls.length') and !@get('isNew')
    @addNewBefore() if !@get('js') and !@get('before.length') and !@get('isNew')
    @addNewAfter() if !@get('js') and !@get('after.length') and !@get('isNew')
  # New multi proxy components should not have calls though.  Type can change.
  ###
  removeCallsFromNewMulti: Ember.observer 'type', ->
    if @get('multi') and @get('isNew')
      calls = @get 'calls'
      calls.clear()
  ###
  addNewCall: ->
    calls = @get 'calls'
    modelName = @get 'callModelName'
    calls.pushObject @store.createRecord modelName
  addNewBefore: ->
    modelName = @get 'transformationModelName'
    record = @store.createRecord modelName
    @get('before').pushObject record
  addNewAfter: ->
    modelName = @get 'transformationModelName'
    record = @store.createRecord modelName
    @get('after').pushObject record


# Declare available types and their human-readable names
types = 'single multi js'.split(' ').map (type) ->
  name: t "proxy-endpoint-component-types.#{type}"
  slug: type
  value: type

SharedComponent.reopenClass
  types: types

`export default SharedComponent`
