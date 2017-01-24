`import Ember from 'ember'`
`import deepEquals from 'ember-cli-deep-equals/helpers/deep-equals'`

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
  allowJsonNodeUpdate: true # may jsonNodeModel change now?

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

  updateModelOnValueChange: Ember.observer 'value', ->
    isDesignView = @get 'isDesignView'
    @setupJsonNodeModel() if isDesignView

  keyUp: ->
    isDesignView = @get 'isDesignView'
    @set 'allowJsonNodeUpdate', false
    @setupValue() if isDesignView
    Ember.run => @set 'allowJsonNodeUpdate', true

  setupJsonNodeModel: ->
    allowJsonNodeUpdate = @get 'allowJsonNodeUpdate'
    equivalent = @get 'areValueAndJsonNodeModelEquivalent'
    value = @get 'value'
    if allowJsonNodeUpdate and !equivalent
      @get('store')
        .query 'json-node', value
        .then (records) =>
          record = records.get 'firstObject'
          @set 'jsonNodeModel', record
  setupValue: ->
    equivalent = @get 'areValueAndJsonNodeModelEquivalent'
    if !equivalent
      jsonNodeModel = @get 'jsonNodeModel'
      try
        jsonString = vkbeautify.json JSON.stringify jsonNodeModel.serialize()
      @set 'value', jsonString

  actions:
    selectViewMode: (mode) ->
      if @get 'modeChangeEnabled'
        @set 'viewMode', mode
        if @get 'isDesignView'
          @setupJsonNodeModel()
        if @get 'isCodeView'
          @setupValue()
    select: (model) ->
      @set 'selectedNode', model
    delete: ->
      @setupValue()

`export default ApJsonEditorComponent`
