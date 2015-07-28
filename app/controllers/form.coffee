`import Ember from 'ember'`
`import Notify from 'ember-notify'`
`import t from 'gateway/helpers/i18n'`

FormController = Ember.ObjectController.extend
  modelType: null
  model: null
  newForm: false
  newFields: null
  editFields: null
  defaultFields: []
  fields: Ember.computed 'isNew', ->
    fields = if @get 'isNew' then @get 'newFields' else @get 'editFields'
    fields ?= []
    fields = Ember.copy(fields).pushObjects @get('defaultFields')
    fields
  onInit: Ember.on 'init', ->
    if !@get 'model'
      @set 'newForm', true
      @createNewModel()
  newFormObserver: Ember.observer 'model.isNew', 'newForm', ->
    if @get('newForm') and @get('model') and !@get('model.isNew')
      @createNewModel()
  createNewModel: ->
    modelType = @get 'modelType'
    newModel = @store?.createRecord modelType
    @set 'model', newModel
    newModel
  notifySaveSuccess: ->
    Notify.success "#{t('successes.saved-successfully')}."
  actions:
    beforeSave: ->
      # no op:  override in subclass
    afterSave: ->
      @notifySaveSuccess()
    afterDelete: ->
      # no op:  override in subclass

`export default FormController`
