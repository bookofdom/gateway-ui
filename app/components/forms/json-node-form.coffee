`import BaseFormComponent from 'gateway/components/forms/base-form'`
`import JsonNode from 'gateway/pods/json-node/model'`
`import t from 'gateway/helpers/i18n'`

JsonNodeFormComponent = BaseFormComponent.extend
  indexModel: null
  'option-groups':
    type: JsonNode.types

  savedAction: null

  defaultFields: Ember.computed 'model.type', 'model.mustHaveName', 'model.canHaveValue', 'model.isRoot', ->
    fields = [
      name: 'type'
      type: 'select'
      disabled: @get 'model.isRoot'
    ]
    if @get 'model.mustHaveName'
      fields.pushObject
        name: 'name'
        required: true
    if @get 'model.canHaveValue'
      fields.pushObject
        name: 'value'
    fields

`export default JsonNodeFormComponent`
