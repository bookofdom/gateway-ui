`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexRowComponent = BsBaseComponent.extend
  tagName: 'tr'
  classNames: ['ap-table-index-row']
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  fieldsList: Ember.computed 'fields', -> @get('fields').split(',')

`export default ApTableIndexRowComponent`
