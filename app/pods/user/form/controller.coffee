`import FormController from 'gateway/controllers/form'`

UserFormController = FormController.extend
  modelType: 'user'
  fields: Ember.computed ->
    [
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
  actions:
    afterDelete: ->
      @send 'deleted'

`export default UserFormController`
