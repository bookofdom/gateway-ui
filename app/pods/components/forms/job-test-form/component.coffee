`import { timezones } from 'gateway/helpers/timezones'`
`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

TimerFormComponent = BaseFormComponent.extend
  savedAction: null
  indexModel: null
  modelType: 'job-test'

  newFields: [
      name: 'name'
      required: true
  ]

  editFields: [
    name: 'name'
    required: true
  ,
    name: 'parameters'
    type: 'json'
    required: true
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      jobTests = @get 'indexModel'
      jobTests.pushObject model
    @_super arguments...

`export default TimerFormComponent`
