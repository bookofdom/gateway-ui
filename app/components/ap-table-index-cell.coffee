`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableIndexCellComponent = BsBaseComponent.extend
  tagName: 'td'
  classNames: ['ap-table-index-cell']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName'
  fieldName: Ember.computed 'field', -> @get('field').split(':')[0]
  value: Ember.computed 'fieldName', 'model', ->
    fieldName = @get 'fieldName'
    @get "model.#{fieldName}"
  cellTemplateName: Ember.computed 'value', 'field', ->
    name = @get('field').split(':')[2]
    valueType = (typeof @get 'value').toLowerCase()
    name = valueType if !name
    "components/ap-table-index-cell/#{name}"

`export default ApTableIndexCellComponent`
