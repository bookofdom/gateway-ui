`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexRowComponent = BsBaseComponent.extend
  tagName: 'tr'
  classNames: ['ap-table-index-row']
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  fieldsList: Ember.computed 'fields.[]', ->
    field.trim().split(':') for field in @get('fields').split(',')
  fieldNames: Ember.computed 'fieldsList.[]', ->
    (field[0] or '') for field in @get 'fieldsList'
  values: Ember.computed 'fieldNames.[]', 'model', ->
    @get("model.#{fieldName}") for fieldName in @get 'fieldNames'

`export default ApTableIndexRowComponent`
