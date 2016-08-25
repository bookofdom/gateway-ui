`import BaseFormComponent from 'gateway/components/forms/base-form'`

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
  ,
    name: 'endpoint_group'
    label: 'resources.endpoint-group'
    type: 'select-model-name'
  ]

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store').createRecord modelType
    @set 'model', newModel
    newModel

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      jobs = @get 'indexModel'
      jobs.pushObject model
    @_super arguments...

`export default JobFormComponent`
