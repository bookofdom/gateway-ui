`import Ember from 'ember'`
`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

RemoteEndpointEnvironmentDatumScratchPadFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'remote-endpoint-environment-datum-scratch-pad'

  fields: [
    name: 'name'
    required: true
  ,
    name: 'code'
    type: 'javascript'
  ]

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store')?.createRecord modelType
    @set 'model', newModel
    scratch_pads = @get 'indexModel'
    scratch_pads.pushObject newModel
    newModel

`export default RemoteEndpointEnvironmentDatumScratchPadFormComponent`
