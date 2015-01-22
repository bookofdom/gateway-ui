`import Ember from 'ember'`
`import BsFormComponent from 'gateway/components/bs-form'`

ApModelFormComponent = BsFormComponent.extend
  classNames: ['ap-model-form']
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type' or 'fieldName,fieldName'
  horizontal: true
  fieldsList: Ember.computed 'fields', -> @get('fields').split ','
  hasChanges: Ember.computed 'model.isDirty', -> @get 'model.isDirty'
  actions:
    cancel: -> @get('model').rollback()

`export default ApModelFormComponent`
