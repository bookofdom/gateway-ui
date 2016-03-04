`import Ember from 'ember'`
`import BaseFormComponent from './base-form'`

ScratchPadFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'scratch-pad'

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

`export default ScratchPadFormComponent`
