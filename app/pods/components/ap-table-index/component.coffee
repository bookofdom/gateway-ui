`import Ember from 'ember'`
`import ApTableModelComponent from 'gateway-ui/pods/components/ap-table-model/component'`

ApTableIndexComponent = ApTableModelComponent.extend
  classNames: ['ap-table-index']
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:cellTemplateName' or 'fieldName,fieldName'
  path: null # 'resource.index', 'resource.edit', etc
  'show-delete': true
  fieldsList: Ember.computed 'fields', ->
    fields = @get('fields')?.split(',') or []
    field.trim()?.split(':') for field in fields
  fieldNames: Ember.computed 'fieldsList.[]', ->
    (field[0] or '') for field in @get 'fieldsList'
  fieldLabels: Ember.computed 'fieldsList.[]', ->
    (field[1] or "fields.#{field[0]}") for field in @get 'fieldsList'
  headings: Ember.computed 'fieldLabels.[]', ->
    headings = @get('fieldLabels').join(',')
    "#{headings}," # add extra empty heading cell for controls column

`export default ApTableIndexComponent`
