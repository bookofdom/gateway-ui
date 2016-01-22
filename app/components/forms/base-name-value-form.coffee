`import BaseFormComponent from './base-form'`

BaseNameValueFormComponent = BaseFormComponent.extend
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'value'
      required: true
    ]

`export default BaseNameValueFormComponent`
