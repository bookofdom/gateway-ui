`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`
`import JsonNode from 'gateway-ui/pods/json-node/model'`

JsonNodeFormComponent = BaseFormComponent.extend
  indexModel: null
  'option-groups':
    type: JsonNode.types

  savedAction: null

  defaultFields: Ember.computed 'model.type', 'model.mustHaveName', 'model.canHaveValue', 'model.isRoot', ->
    fields = [
      name: 'type'
      type: 'select-name-key'
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
