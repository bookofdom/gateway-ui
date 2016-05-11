`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

JsonSchemaNode = Model.extend
  type: DS.attr 'string', defaultValue: 'string'
  title: DS.attr 'string'
  description: DS.attr 'string'
  # parent is object
  name: DS.attr 'string'
  pattern_name: DS.attr 'boolean', defaultValue: false # is name a regex pattern?
  required: DS.attr 'boolean', defaultValue: false
  # object
  additional_properties: DS.attr 'boolean', defaultValue: true
  min_properties: DS.attr 'number'
  max_properties: DS.attr 'number'
  # array
  min_items: DS.attr 'number'
  max_items: DS.attr 'number'
  unique_items: DS.attr 'boolean', defaultValue: false
  # number, integer
  multiple_of: DS.attr 'number'
  minimum: DS.attr 'number'
  maximum: DS.attr 'number'
  exclusive_minimum: DS.attr 'boolean', defaultValue: false
  exclusive_maximum: DS.attr 'boolean', defaultValue: false
  # string
  pattern: DS.attr 'string'
  min_length: DS.attr 'number'
  max_length: DS.attr 'number'

  # Relationships
  proxy_endpoint_schema_request_parent: DS.belongsTo 'proxy-endpoint-schema'
  proxy_endpoint_schema_response_parent: DS.belongsTo 'proxy-endpoint-schema'
  parent: DS.belongsTo 'json-schema-node',
    inverse: 'children'
    async: false
  children: DS.hasMany 'json-schema-node',
    inverse: 'parent'
    async: false
    stains: true
    embedded: true

  # Computed
  isRoot: Ember.computed 'parent', -> !@get 'parent'
  parentIsObject: Ember.computed 'parent.type', ->
    @get('parent.type') is 'object'
  canHaveChildren: Ember.computed 'type', ->
    (@get('type') is 'object') or (@get('type') is 'array')
  displayName: Ember.computed 'title', 'name', 'pattern', 'type', ->
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
