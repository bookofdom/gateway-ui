`import Ember from 'ember'`

ApJsonEditorComponent = Ember.Component.extend
  classNames: ['ap-json-editor']
  value: null

  viewMode: 'code'
  isCodeView: Ember.computed 'viewMode', -> @get('viewMode') is 'code'
  isDesignView: Ember.computed 'viewMode', -> @get('viewMode') is 'design'

  actions:
    selectViewMode: (mode='code') -> @set 'viewMode', mode

`export default ApJsonEditorComponent`
