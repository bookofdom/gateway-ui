`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`

ApTableIndexCellComponent = BsBaseComponent.extend
  tagName: 'td'
  classNames: ['ap-table-index-cell']
  model: null
  field: null # 'fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName'
  fieldName: Ember.computed 'field', -> @get('field')?.split(':')[0]
  valueType: Ember.computed 'value', 'field', ->
    value = @get 'value'
    valueType = @get('field')?.split(':')[2]
    if !valueType
      if value?
        valueType = (typeof value).toLowerCase()
      else
        valueType = 'string'
    valueType
  cellTemplateName: Ember.computed 'value', 'field', ->
    "components/ap-table-index-cell/-#{@get 'valueType'}"
  setupValueAttribute: Ember.on 'init', ->
    computed = Ember.computed 'model', 'fieldName', "model.#{@get 'fieldName'}", ->
      fieldName = @get 'fieldName'
      @get "model.#{fieldName}"
    Ember.defineProperty @, 'value', computed

`export default ApTableIndexCellComponent`
