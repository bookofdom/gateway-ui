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
      name: 'password'
      type: 'password'
    ,
      name: 'password_confirmation'
      type: 'password'
    ]

`export default UserFormController`
