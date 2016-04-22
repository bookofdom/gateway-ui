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
  pattern: DS.attr 'boolean', defaultValue: false # is name a regex pattern?
  required: DS.attr 'boolean', defaultValue: false
  # object
  maxProperties: DS.attr 'number'
  minProperties: DS.attr 'number'
  # array
  maxItems: DS.attr 'number'
  minItems: DS.attr 'number'
  uniqueItems: DS.attr 'boolean', defaultValue: false
  # number, integer
  multipleOf: DS.attr 'number'
  minimum: DS.attr 'number'
  maximum: DS.attr 'number'
  exclusiveMinimum: DS.attr 'boolean', defaultValue: false
  exclusiveMaximum: DS.attr 'boolean', defaultValue: false
  # string
  maxLength: DS.attr 'number'
  minLength: DS.attr 'number'
  pattern: DS.attr 'string'

  # Relationships
  parent: DS.belongsTo 'json-schema-node', inverse: 'children'
  children: DS.hasMany 'json-schema-node', inverse: 'parent'

  # Computed
  nodeType: Ember.computed 'type', ->
    type = @get 'type'
    JsonSchemaNode.types.findBy 'value', type

types = 'object array null boolean integer number string'.split(' ').map (typeName) ->
  name: t "types.json-schema.#{typeName}"
  slug: typeName
  value: typeName

JsonSchemaNode.reopenClass
  types: types

`export default JsonSchemaNode`
