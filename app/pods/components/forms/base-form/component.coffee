`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from 'gateway-ui/config/environment'`

BaseFormComponent = Ember.Component.extend
  notify: Ember.inject.service()
  store: Ember.inject.service()

  tagName: 'form'
  classNames: ['ap-model-form']
  classNameBindings: ['inline:form-inline', 'horizontal:form-horizontal']

  savedAction: 'saved'
  canceledAction: 'canceled'
  deletedAction: 'deleted'

  embedded: false # embedded in another form
  inline: false # inline layout
  horizontal: true
  'show-placeholders': false

  modelType: null
  model: null

  newForm: false
  newFields: null
  editFields: null
  defaultFields: []
  fields: Ember.computed 'defaultFields', 'newFields', 'editFields', 'model.isNew', ->
    fields = if (@get('model.isNew') or @get('newForm')) then @get 'newFields' else @get 'editFields'
    fields ?= []
    fields = Ember.copy(fields).pushObjects @get('defaultFields')
    fields

  'option-groups': null

  tagNameOnInit: Ember.on 'init', ->
    if @get 'embedded'
      @set 'tagName', 'div'
    else
      @set 'tagName', 'form'

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
      Ember.run.later =>
        if @get('newForm') and @get('model') and !@get('model.isNew') and !@get 'isDestroyed'
          @createNewModel()

  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @get('store')?.peekAll(modelType)?.filterBy('isNew', true)?.get 'firstObject'
    newModel = @get('store')?.createRecord(modelType) if !newModel
    @setupNewModelBelongsToDefaults newModel
    @set 'model', newModel
    newModel
  # Automatically assigns defaults for select-model-name fields when
  # prompt == false.  No prompt means the first value implicitly becomes
  # default, but emberx-select doesn't hanlde the assignment gracefully.
  # Thus we must initialize the model with a default before render.
  setupNewModelBelongsToDefaults: (newModel) ->
    fields = @get 'fields'
      .filterBy 'type', 'select-model-name'
      .filterBy 'prompt', false
      .forEach (field) =>
        name = field.name
        defaultInstance = @get "option-groups.#{name}.firstObject"
        newModel.set name, defaultInstance if defaultInstance
  assignModelClientId: ->
    model = @get 'model'
    clientId = Math.round(Math.random() * 1000000000)
    model.set 'clientId', clientId
  notifySaveSuccess: ->
    @get('notify').success "#{t('successes.saved-successfully')}."
  submit: ->
    if !@get 'embedded'
      model = @get 'model'
      model.save().then((=>
        @notifySaveSuccess()
        @sendAction 'savedAction', model
      ), (->))
    false
  cancel: ->
    @get('model').cancel().then =>
      #@sendAction 'canceledAction'
  keyDown: (e) ->
    if !@get('embedded') and (e.metaKey or e.ctrlKey) and (e.keyCode is 83)
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
    new Ember.RSVP.Promise (resolve, reject) =>
      record.destroyRecord()
        .then resolve
        .catch =>
          @notifyErrorsForRecord record
          @cancelDelete record
          reject()
  cancelDelete: (record) ->
    record.transitionTo 'loaded.updated.uncommitted.invalid' # clear deleted state
    record.cancel().then =>
      @sendAction 'refresh-action'
  notifyErrorsForRecord: (record) ->
    errors = []
    record.get('errors').forEach (error) =>
      @get('notify').alert error.message

  actions:
    cancel: ->
      @cancel()
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if @confirm confirmText
        @delete().then => @sendAction 'deletedAction'

`export default BaseFormComponent`
