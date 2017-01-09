`import Ember from 'ember'`
`import ApTableModelRowComponent from 'gateway-ui/pods/components/ap-table-model-row/component'`

ApTableIndexRowComponent = ApTableModelRowComponent.extend
  classNames: ['ap-table-index-row']
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  'show-delete': true
  fieldsList: Ember.computed 'fields', -> @get('fields')?.split(',') or []

`export default ApTableIndexRowComponent`
