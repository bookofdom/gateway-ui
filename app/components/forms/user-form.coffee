`import BaseFormComponent from './base-form'`

UserFormComponent = BaseFormComponent.extend
  indexModel: null
  modelType: 'user'
  
  fields: [
    name: 'name'
    required: true
  ,
    name: 'email'
    required: true
  ,
    name: 'admin'
  ,
    name: 'confirmed'
  ,
    name: 'password'
    type: 'password'
  ,
    name: 'password_confirmation'
    type: 'password'
  ]

  submit: ->
    model = @get 'model'
    if model.get 'isNew'
      indexModel = @get 'indexModel'
      indexModel.pushObject model
    @_super.apply @, arguments

`export default UserFormComponent`
