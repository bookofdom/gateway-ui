`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

JobFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'job'

  savedAction: null

  defaultFields: [
    name: 'name'
    required: true
  ,
    name: 'description'
    type: 'textarea'
  ,
    name: 'environment'
    label: 'resources.environment'
    type: 'select-model-name'
    required: true
    prompt: false
    'new-resource-route': 'environments.new'
  ,
    name: 'endpoint_group'
    label: 'resources.endpoint-group'
    type: 'select-model-name'
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      jobs = @get 'indexModel'
      jobs.pushObject model
    @_super arguments...

`export default JobFormComponent`
