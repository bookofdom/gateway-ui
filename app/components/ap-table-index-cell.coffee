`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexCellComponent = BsBaseComponent.extend
  tagName: 'td'
  classNames: ['ap-table-index-cell']
  model: null
  field: null # 'fieldName:i18nLabel'
  fieldName: Ember.computed 'field', -> @get('field').split(':')[0]
  value: Ember.computed 'fieldName', 'model', ->
    fieldName = @get 'fieldName'
    @get "model.#{fieldName}"

`export default ApTableIndexCellComponent`
