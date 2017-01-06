`import BaseFormComponent from 'gateway-ui/pods/components/forms/base-form/component'`

KeyFormComponent = BaseFormComponent.extend
  modelType: 'key'

  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ,
    name: 'key'
    type: 'file'
  ,
    name: 'password'
    type: 'password'
  ]

`export default KeyFormComponent`
