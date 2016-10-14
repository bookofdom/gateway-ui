`import BaseFormComponent from 'gateway/pods/components/forms/base-form/component'`

BaseNameValueFormComponent = BaseFormComponent.extend
  fields: [
    name: 'name'
    required: true
  ,
    name: 'value'
    required: true
  ]

`export default BaseNameValueFormComponent`
