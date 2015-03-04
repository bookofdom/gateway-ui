`import Ember from 'ember'`
`import BsFormComponent from 'gateway/components/bs-form'`

ApModelFormComponent = BsFormComponent.extend
  classNames: ['ap-model-form']
  action: 'submit'
  'cancel-action': 'cancel'
  'before-save-action': 'beforeSave'
  'after-save-action': 'afterSave'
  'after-delete-action': 'afterDelete'
  model: null
  fields: null # 'fieldName:i18nLabel, fieldName:i18nLabel' or 'fieldName:i18nLabel:help:type' or 'fieldName,fieldName'
  horizontal: true
  'auto-save': true
  'auto-cancel': true
  'auto-delete': true
  'option-groups': null
  fieldsList: Ember.computed 'fields', ->
    for field in @get('fields')?.split ','
      fieldName = field.split(':')[0]
      options: @get('option-groups')?[fieldName]
      field: field
  dirty: Ember.computed 'model.isDirty', -> @get 'model.isDirty'
  'show-save': Ember.computed 'dirty', -> @get 'dirty'
  'show-cancel': Ember.computed 'dirty', 'model.isNew', ->
    @get('dirty') and !@get('model.isNew')
  'show-delete': false
  'deletable': Ember.computed 'show-delete', 'model.isNew', ->
    @get('show-delete') and !@get('model.isNew')
  onInit: Ember.on 'init', ->
    model = @get 'model'
    isNew = model?.get 'isNew'
    @assignModelClientId() if model? and isNew
  assignModelClientId: ->
    model = @get 'model'
    clientId = Math.round(Math.random() * 1000000000)
    model.set 'clientId', clientId
  submit: ->
    autoSave = @get 'auto-save'
    @sendAction 'before-save-action'
    @sendAction() if @get('dirty') and !autoSave
    if autoSave
      @get('model').save().then((=>
        @sendAction 'after-save-action'
      ), (=>))
    false
  actions:
    cancel: ->
      if @get 'auto-cancel'
        @get('model').rollback()
        @get('model').reload().then =>
          @get('model').rollback()
      else
        @sendAction 'cancel-action', @get('model')
    delete: ->
      @get('model').destroyRecord()
      @sendAction 'after-delete-action'

`export default ApModelFormComponent`
