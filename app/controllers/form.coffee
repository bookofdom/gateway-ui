`import Ember from 'ember'`

FormController = Ember.ObjectController.extend
  modelType: null
  model: null
  newForm: false
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

`export default FormController`