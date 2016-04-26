`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

JsonSchemaNode = DS.Model.extend
  type: DS.attr 'string', defaultValue: 'object'
  description: DS.attr 'string'
  # root, object
  title: DS.attr 'string'
  # parent is object
  name: DS.attr 'string'
  patternName: DS.attr 'boolean', defaultValue: false # is name a regex pattern?
  required: DS.attr 'boolean', defaultValue: false
  # object
  minProperties: DS.attr 'number'
  maxProperties: DS.attr 'number'
  # array
  minItems: DS.attr 'number'
  maxItems: DS.attr 'number'
  uniqueItems: DS.attr 'boolean', defaultValue: false
  # number, integer
  multipleOf: DS.attr 'number'
  minimum: DS.attr 'number'
  maximum: DS.attr 'number'
  exclusiveMinimum: DS.attr 'boolean', defaultValue: false
  exclusiveMaximum: DS.attr 'boolean', defaultValue: false
  # string
  pattern: DS.attr 'string'
  minLength: DS.attr 'number'
  maxLength: DS.attr 'number'

  # Relationships
  parent: DS.belongsTo 'json-schema-node',
    inverse: 'children'
    async: false
  children: DS.hasMany 'json-schema-node',
    inverse: 'parent'
    async: false

  # Computed
  isRoot: Ember.computed 'parent', -> !@get 'parent'
  parentIsObject: Ember.computed 'parent.type', ->
    @get('parent.type') is 'object'
  displayName: Ember.computed 'title', 'name', 'type', ->
    @get('title') or @get('name') or @get('pattern') or @get('nodeType.name')
  nodeType: Ember.computed 'type', ->
    type = @get 'type'
    JsonSchemaNode.types.findBy 'value', type

types = 'object array null boolean integer number string'.split(' ').map (typeName) ->
  name: t("types.json-schema.#{typeName}").toLowerCase()
  slug: typeName
  value: typeName

JsonSchemaNode.reopenClass
  types: types

`export default JsonSchemaNode`
