`import BaseFormComponent from './base-form'`

EnvironmentVariableFormComponent = BaseFormComponent.extend
  fields: Ember.computed ->
    [
      name: 'name'
      required: true
    ,
      name: 'value'
      required: true
    ]

`export default EnvironmentVariableFormComponent`
