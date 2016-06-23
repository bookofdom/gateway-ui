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

  areValueAndJsonNodeModelEquivalent: Ember.computed(->
    value = @get 'value'
    jsonNodeModel = @get 'jsonNodeModel'
    try parsedJson = JSON.parse value
    jsonNodeModelJson = jsonNodeModel?.serialize()
    deepEquals parsedJson, jsonNodeModelJson
  ).volatile() # don't cache the result

  modeChangeEnabled: Ember.computed 'value', ->
    !@get('disabled') and @get 'isJsonValid'
  modeChangeDisabled: Ember.computed 'modeChangeEnabled', ->
    !@get 'modeChangeEnabled'

  updateModelOnValueChange: Ember.observer 'value', 'isDesignView', ->
    if @get('isDesignView') and !@get('areValueAndJsonNodeModelEquivalent')
      @setupJsonNodeModel()

  setupJsonNodeModel: ->
    value = @get 'value'
    jsonNodeModel = @get 'jsonNodeModel'
    @get('store')
      .query 'json-node', value
      .then (records) =>
        record = records.get 'firstObject'
        @set 'jsonNodeModel', record
  setupValue: ->
    jsonNodeModel = @get 'jsonNodeModel'
    try
      jsonString = vkbeautify.json JSON.stringify jsonNodeModel.serialize()
    @set 'value', jsonString

  actions:
    selectViewMode: (mode) ->
      @set 'viewMode', mode if @get 'modeChangeEnabled'
      if @get('isCodeView') and !@get('areValueAndJsonNodeModelEquivalent')
        @setupValue()
    select: (model) ->
      @set 'selectedNode', model

`export default ApJsonEditorComponent`
