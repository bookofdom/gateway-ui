`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import JsonSchemaNode from 'gateway-ui/pods/json-schema-node/model'`

JsonSchemaNodeFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'environment'
  'option-groups':
    type: JsonSchemaNode.types

  savedAction: null

  defaultFields: Ember.computed 'model.parentIsObject', 'model.isRoot', ->
    fields = [
      name: 'type'
      type: 'select-name-key'
    ,
      name: 'title'
      required: @get 'model.isRoot'
    ,
      name: 'description'
      type: 'textarea'
    ]
    if @get 'model.parentIsObject'
      fields.pushObjects [
        name: 'name'
        requred: true
      ,
        name: 'pattern_name'
        type: 'boolean'
      ,
        name: 'required'
        type: 'boolean'
      ]
    fields

  nodeTypeFields:
    object: [
      name: 'additional_properties'
      type: 'boolean'
    ,
      name: 'min_properties'
      type: 'integer'
    ,
      name: 'max_properties'
      type: 'integer'
    ]
    array: [
      name: 'unique_items'
      type: 'boolean'
    ,
      name: 'min_items'
      type: 'integer'
    ,
      name: 'max_items'
      type: 'integer'
    ]
    null: null
    boolean: null
    integer: [
      name: 'multiple_of'
      type: 'integer'
    ,
      name: 'minimum'
      type: 'integer'
    ,
      name: 'maximum'
      type: 'integer'
    ,
      name: 'exclusive_minimum'
      type: 'boolean'
    ,
      name: 'exclusive_maximum'
      type: 'boolean'
    ]
    number: [
      name: 'multiple_of'
      type: 'number'
    ,
      name: 'minimum'
      type: 'number'
    ,
      name: 'maximum'
      type: 'number'
    ,
      name: 'exclusive_minimum'
      type: 'boolean'
    ,
      name: 'exclusive_maximum'
      type: 'boolean'
    ]
    string: [
      name: 'pattern'
    ,
      name: 'min_length'
      type: 'integer'
    ,
      name: 'max_length'
      type: 'integer'
    ]

  fields: Ember.computed 'model.type', 'model.parentIsObject', 'model.isRoot', ->
    fields = @_super arguments...
    type = @get 'model.type'
    nodeTypeFields = @get "nodeTypeFields.#{type}" if type
    fields = Ember.copy(fields).pushObjects(nodeTypeFields) if nodeTypeFields
    fields

`export default JsonSchemaNodeFormComponent`
