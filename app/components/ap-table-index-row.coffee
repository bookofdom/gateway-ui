`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexRowComponent = BsBaseComponent.extend
  tagName: 'tr'
  classNames: ['ap-table-index-row']
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  'delete-action': 'delete'
  'edit-path': null
  fieldsList: Ember.computed 'fields', -> @get('fields').split(',')
  actions:
    delete: -> @sendAction 'delete-action', @get('model')

`export default ApTableIndexRowComponent`
