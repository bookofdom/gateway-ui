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

  jsonNodeModel: null
  selectedNode: null

  viewMode: 'code'
  isCodeView: Ember.computed 'viewMode', -> @get('viewMode') is 'code'
  isDesignView: Ember.computed 'viewMode', -> @get('viewMode') is 'design'

  isJsonValid: Ember.computed 'value', ->
    value = @get 'value'
    try JSON.parse value

  areValueAndJsonNodeModelEquivalent: Ember.computed 'value', 'jsonNodeModel', ->
    value = @get 'value'
    jsonNodeModel = @get 'jsonNodeModel'
    try parsedJson = JSON.parse value
    jsonNodeModelJson = jsonNodeModel?.serialize()
    deepEquals parsedJson, jsonNodeModelJson

  modeChangeEnabled: Ember.computed 'value', ->
    !@get('disabled') and @get 'isJsonValid'
  modeChangeDisabled: Ember.computed 'modeChangeEnabled', ->
    !@get 'modeChangeEnabled'

  updateJsonNodeModelOnValueChange: Ember.observer 'value', ->
    if !@get 'areValueAndJsonNodeModelEquivalent'
      @setupJsonNodeModelForDesignView()

  setupJsonNodeModelForDesignView: ->
    value = @get 'value'
    jsonNodeModel = @get 'jsonNodeModel'
    @get('store')
      .query 'json-node', value
      .then (records) =>
        record = records.get 'firstObject'
        @set 'jsonNodeModel', record

  actions:
    selectViewMode: (mode) ->
      @set 'viewMode', mode if @get 'modeChangeEnabled'
      # If switching to design view and no json-node model exists yet,
      # create it. But only once, because then the observer takes over.
      if @get('isDesignView') and !@get('jsonNodeModel')
        @updateJsonNodeModelOnValueChange()
    select: (model) ->
      @set 'selectedNode', model

`export default ApJsonEditorComponent`
