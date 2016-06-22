`import Ember from 'ember'`
`import deepEquals from 'gateway/helpers/deep-equals'`

ApJsonEditorComponent = Ember.Component.extend
  store: Ember.inject.service()

  classNames: ['ap-json-editor']

  value: null
  name: null
  idName: null
  required: false
  disabled: false

  model: null

  viewMode: 'code'
  isCodeView: Ember.computed 'viewMode', -> @get('viewMode') is 'code'
  isDesignView: Ember.computed 'viewMode', -> @get('viewMode') is 'design'

  isJsonValid: Ember.computed 'value', ->
    value = @get 'value'
    try JSON.parse value

  isValueAndModelEquivalent: Ember.computed 'value', 'model', ->
    value = @get 'value'
    model = @get 'model'
    try parsedJson = JSON.parse value
    modelJson = model?.serialize()
    deepEquals parsedJson, modelJson

  modeChangeEnabled: Ember.computed 'value', ->
    !@get('disabled') and @get 'isJsonValid'
  modeChangeDisabled: Ember.computed 'modeChangeEnabled', ->
    !@get 'modeChangeEnabled'

  setupModelForDesignView: ->
    value = @get 'value'
    @get('store')
      .query 'json-node', value
      .then (records) =>
        record = records.get 'firstObject'
        @set 'model', record

  actions:
    selectViewMode: (mode) ->
      @set 'viewMode', mode if @get 'modeChangeEnabled'
      @setupModelForDesignView() if @get 'isDesignView'

`export default ApJsonEditorComponent`
