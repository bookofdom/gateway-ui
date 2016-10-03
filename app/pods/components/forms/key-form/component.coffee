`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

KeyFormComponent = BaseFormComponent.extend
  modelType: 'key'

  savedAction: null

  newFields: [
    name: 'name'
    required: true
  ,
    name: 'key'
    type: 'file'
  ]

`export default KeyFormComponent`
