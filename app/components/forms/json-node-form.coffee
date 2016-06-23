`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import JsonNode from 'gateway/pods/json-node/model'`
`import t from 'gateway/helpers/i18n'`

JsonNodeFormComponent = BaseFormComponent.extend
  indexModel: null
  'option-groups':
    type: JsonNode.types

  savedAction: null

  defaultFields: Ember.computed 'model.type', 'model.parentIsObject', 'model.isRoot', ->
    fields = [
      name: 'type'
      type: 'select'
      disabled: @get 'model.isRoot'
    ]
    if @get 'model.canHaveName'
      fields.pushObjects [
        name: 'name'
        requred: true
        disabled: @get 'model.isRoot'
      ]
    if @get 'model.canHaveValue'
      fields.pushObjects [
        name: 'value'
        requred: true
        disabled: @get 'model.isRoot'
      ]
    fields

`export default JsonNodeFormComponent`
