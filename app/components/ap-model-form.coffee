`import Ember from 'ember'`
`import BsFormComponent from 'gateway/components/bs-form'`
`import t from 'gateway/helpers/i18n'`
`import config from '../config/environment'`

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
  'show-placeholders': false
  'auto-save': true
  'auto-cancel': true
  'auto-delete': true
  'option-groups': null
  dirty: Ember.computed 'model.hasDirtyAttributes', -> @get 'model.hasDirtyAttributes'
  'show-save': Ember.computed 'dirty', -> @get 'dirty'
  'show-cancel': Ember.computed 'dirty', 'model.isNew', ->
    @get('dirty') and !@get('model.isNew')
  'show-delete': true
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
      ), (->))
    false
  keyDown: (e) ->
    if (e.metaKey or e.ctrlKey) and (e.keyCode is 83)
      e.preventDefault()
      # a hacky way to programmatically submit the form, since
      # all direct methods fail to trigger proper validation
      @$('[type=submit]').click()
  confirm: (text) ->
    if config.confirmDelete
      confirm text
    else
      true
  actions:
    cancel: ->
      if @get 'auto-cancel'
        @get('model').cancel()
      else
        @sendAction 'cancel-action', @get('model')
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if @get('auto-delete') and @confirm(confirmText)
        @get('model').destroyRecord().then =>
          @sendAction 'after-delete-action'

`export default ApModelFormComponent`
