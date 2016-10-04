`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

UserFormComponent = BaseFormComponent.extend
  modelType: 'user'

  savedAction: null

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

`export default UserFormComponent`
