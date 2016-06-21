`import Ember from 'ember'`

ApJsonEditorComponent = Ember.Component.extend
  classNames: ['ap-json-editor']

  value: null
  name: null
  idName: null
  required: false
  disabled: false

  viewMode: 'code'
  isCodeView: Ember.computed 'viewMode', -> @get('viewMode') is 'code'
  isDesignView: Ember.computed 'viewMode', -> @get('viewMode') is 'design'

  actions:
    selectViewMode: (mode) ->
      if !@get 'disabled'
        @set 'viewMode', mode

`export default ApJsonEditorComponent`
