`import EnvironmentVariableFormComponent from 'gateway/components/forms/environment-variable-form'`

EnvironmentVariableInlineFormComponent = EnvironmentVariableFormComponent.extend
  inline: true
  horizontal: false
  'show-save': false
  'show-cancel': false
  'show-placeholders': true

`export default EnvironmentVariableInlineFormComponent`
