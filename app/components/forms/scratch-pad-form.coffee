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

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      pads = @get 'indexModel'
      pads.pushObject model
    @_super.apply @, arguments

`export default ScratchPadFormComponent`
