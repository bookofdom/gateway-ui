`import BaseFormComponent from 'gateway/components/forms/base-form'`

BaseNameValueFormComponent = BaseFormComponent.extend
  fields: [
    name: 'name'
    required: true
  ,
    name: 'value'
    required: true
  ]

`export default BaseNameValueFormComponent`
