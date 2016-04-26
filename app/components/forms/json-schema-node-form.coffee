`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import JsonSchemaNode from 'gateway/pods/json-schema-node/model'`
`import t from 'gateway/helpers/i18n'`

JsonSchemaNodeFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'environment'
  'option-groups':
    type: JsonSchemaNode.types

  savedAction: null

  defaultFields: Ember.computed 'model.parentIsObject', 'model.isRoot', ->
    fields = [
      name: 'type'
      type: 'select'
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
        name: 'patternName'
        type: 'boolean'
      ,
        name: 'required'
        type: 'boolean'
      ]
    fields

  nodeTypeFields:
    object: [
      name: 'minProperties'
      type: 'integer'
    ,
      name: 'maxProperties'
      type: 'integer'
    ]
    array: [
      name: 'uniqueItems'
      type: 'boolean'
    ,
      name: 'minItems'
      type: 'integer'
    ,
      name: 'maxItems'
      type: 'integer'
    ]
    null: null
    boolean: null
    integer: [
      name: 'multipleOf'
      type: 'integer'
    ,
      name: 'minimum'
      type: 'integer'
    ,
      name: 'maximum'
      type: 'integer'
    ,
      name: 'exclusiveMinimum'
      type: 'boolean'
    ,
      name: 'exclusiveMaximum'
      type: 'boolean'
    ]
    number: [
      name: 'multipleOf'
      type: 'number'
    ,
      name: 'minimum'
      type: 'number'
    ,
      name: 'maximum'
      type: 'number'
    ,
      name: 'exclusiveMinimum'
      type: 'boolean'
    ,
      name: 'exclusiveMaximum'
      type: 'boolean'
    ]
    string: [
      name: 'pattern'
    ,
      name: 'minLength'
      type: 'integer'
    ,
      name: 'maxLength'
      type: 'integer'
    ]

  fields: Ember.computed 'model.type', 'model.parentIsObject', 'model.isRoot', ->
    fields = @_super arguments...
    type = @get 'model.type'
    nodeTypeFields = @get "nodeTypeFields.#{type}" if type
    fields = Ember.copy(fields).pushObjects nodeTypeFields
    fields

`export default JsonSchemaNodeFormComponent`
