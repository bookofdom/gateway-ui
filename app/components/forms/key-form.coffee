`import BaseFormComponent from 'gateway/components/forms/base-form'`

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
