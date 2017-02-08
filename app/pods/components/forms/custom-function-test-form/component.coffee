`import { timezones } from 'gateway-ui/helpers/timezones'`
`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

CustomFunctionTestFormComponent = BaseFormComponent.extend
  savedAction: null
  indexModel: null
  modelType: 'custom-function-test'

  newFields: [
      name: 'name'
      required: true
  ]

  editFields: [
    name: 'name'
    required: true
  ,
    name: 'input'
    type: 'json'
    required: true
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      customFunctionTests = @get 'indexModel'
      customFunctionTests.pushObject model
    @_super arguments...

`export default CustomFunctionTestFormComponent`
