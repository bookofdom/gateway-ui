`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

JsonNode = Model.extend
  type: DS.attr 'string', defaultValue: 'string'
  # parent is object
  name: DS.attr 'string', defaultValue: ''
  # type is non-object and non-array
  value: DS.attr 'string', defaultValue: ''

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
  parentIsObject: Ember.computed 'parent.type', ->
    @get('parent.type') is 'object'
  canHaveChildren: Ember.computed 'type', ->
    type = @get 'type'
    (type is 'object') or (type is 'array')
  mustHaveName: Ember.computed.alias 'parentIsObject'
  canHaveValue: Ember.computed 'type', ->
    type = @get 'type'
    (type != 'object') and (type != 'array') and (type != 'null')
  nodeType: Ember.computed 'type', ->
    type = @get 'type'
    JsonNode.types.findBy 'value', type
  displayName: Ember.computed 'type', 'name', 'value', ->
    type = @get 'nodeType.name'
    name = @get 'name'
    value = @get 'value'
    nameAndValue = "#{name}: #{value}" if name and value
    nameOnly = "#{name}:" if name
    nameAndValue or nameOnly or value or type

types = 'object array null boolean number string'.split(' ').map (typeName) ->
  name: t("types.json-type.#{typeName}").toLowerCase()
  slug: typeName
  value: typeName

JsonNode.reopenClass
  types: types

`export default JsonNode`
