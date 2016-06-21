`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

JsonNode = Model.extend
  type: DS.attr 'string', defaultValue: 'string'
  # parent is object
  name: DS.attr 'string'
  # type is non-object and non-array
  value: DS.attr 'string'

  # Relationships
  parent: DS.belongsTo 'json-node',
    inverse: 'children'
    async: false
  children: DS.hasMany 'json-node',
    inverse: 'parent'
    async: false
    stains: true
    embedded: true

  # Computed
  isRoot: Ember.computed 'parent', -> !@get 'parent'
  isNeitherObjectNorArray: Ember.computed 'type', ->
    type = @get 'type'
    (type != 'object') and (type != 'array')
  parentIsObject: Ember.computed 'parent.type', ->
    @get('parent.type') is 'object'
  canHaveChildren: Ember.computed 'type', ->
    type = @get 'type'
    (type is 'object') or (type is 'array')
  canHaveName: Ember.computed.alias 'parentIsObject'
  canHaveValue: Ember.computed.alias 'isNeitherObjectNorArray'
  nodeType: Ember.computed 'type', ->
    type = @get 'type'
    JsonNode.types.findBy 'value', type
  displayName: Ember.computed 'title', 'name', 'pattern', 'type', ->
    @get('value') or @get('nodeType.name')

types = 'object array null boolean number string'.split(' ').map (typeName) ->
  name: t("types.json-type.#{typeName}").toLowerCase()
  slug: typeName
  value: typeName

JsonNode.reopenClass
  types: types

`export default JsonNode`
