`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`
`import config from 'gateway/config/environment'`

BaseFormComponent = Ember.Component.extend
  notify: Ember.inject.service()
  store: Ember.inject.service()

  tagName: 'form'
  classNames: ['ap-model-form']
  classNameBindings: ['inline:form-inline', 'horizontal:form-horizontal']

  savedAction: 'saved'
  canceledAction: 'canceled'
  deletedAction: 'deleted'

  inline: false
  horizontal: true
  'show-placeholders': false

  modelType: null
  model: null

  newForm: false
  newFields: null
  editFields: null
  defaultFields: []
  fields: Ember.computed 'model.isNew', ->
    fields = if @get 'model.isNew' then @get 'newFields' else @get 'editFields'
    fields ?= []
    fields = Ember.copy(fields).pushObjects @get('defaultFields')
    fields

  'option-groups': null

  dirty: Ember.computed.alias 'model.hasDirtyAttributes'
  'show-save': Ember.computed.alias 'dirty'
  'show-cancel': Ember.computed 'dirty', 'model.isNew', ->
    @get('dirty') and !@get('model.isNew')
  'show-delete': true
  'deletable': Ember.computed 'show-delete', 'model.isNew', ->
    @get('show-delete') and !@get('model.isNew')

  onInit: Ember.on 'init', ->
    if !@get 'model'
      @set 'newForm', true
      @createNewModel()
    model = @get 'model'
    isNew = model?.get 'isNew'
    if model? and isNew
      @assignModelClientId()
  newFormObserver: Ember.observer 'model.isNew', 'newForm', ->
    if @get('newForm') and @get('model') and !@get('model.isNew')
      @createNewModel()

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store')?.createRecord modelType
    @set 'model', newModel
    newModel
  assignModelClientId: ->
    model = @get 'model'
    clientId = Math.round(Math.random() * 1000000000)
    model.set 'clientId', clientId
  notifySaveSuccess: ->
    @get('notify').success "#{t('successes.saved-successfully')}."
  submit: ->
    @get('model').save().then((=>
      @notifySaveSuccess()
      @sendAction 'savedAction'
    ), (->))
    false
  keyDown: (e) ->
    if (e.metaKey or e.ctrlKey) and (e.keyCode is 83)
      e.preventDefault()
      # a hacky way to programmatically submit the form, since
      # all direct methods fail to trigger proper validation
      @$().submit()
  confirm: (text) ->
    if config.confirmDelete
      confirm text
    else
      true

  delete: ->
    record = @get 'model'
    record.destroyRecord().catch =>
      @notifyErrorsForRecord record
      @cancelDelete record
  cancelDelete: (record) ->
    record.transitionTo 'loaded.saved' # clear deleted state
    record.cancel().then =>
      @sendAction 'refresh-action'
  notifyErrorsForRecord: (record) ->
    errors = []
    record.get('errors').forEach (error) =>
      @get('notify').alert error.message

  actions:
    cancel: ->
      @get('model').cancel().then =>
        #@sendAction 'canceledAction'
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if @confirm confirmText
        @delete()
        @sendAction 'deletedAction'

`export default BaseFormComponent`
