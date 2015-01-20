`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexComponent = BsBaseComponent.extend
  classNames: ['ap-table-index']
  models: null # array of model instances
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  fieldsList: Ember.computed 'fields.[]', ->
    field.trim().split(':') for field in @get('fields').split(',')
  fieldNames: Ember.computed 'fieldsList.[]', ->
    (field[0] or '') for field in @get 'fieldsList'
  fieldLabels: Ember.computed 'fieldsList.[]', ->
    (field[1] or "fields.#{field[0]}") for field in @get 'fieldsList'
  headings: Ember.computed 'fieldLabels.[]', -> @get('fieldLabels').join(',')

`export default ApTableIndexComponent`
