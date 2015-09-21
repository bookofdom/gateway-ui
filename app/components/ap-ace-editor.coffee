`import Ember from 'ember'`

ApAceEditorComponent = Ember.Component.extend
  classNames: ['ap-ace-editor']
  classNameBindings: ['sizeClass']
  value: null
  editor: null
  size: null
  language: 'javascript'
  theme: 'slate'
  options:
    enableBasicAutocompletion: true
    enableLiveAutocompletion: true
  sizeClass: Ember.computed 'size', ->
    size = @get 'size'
    "ap-ace-editor-#{size}" if size
  didInsertElement: ->
    language = @get 'language'
    theme = @get 'theme'
    options = @get 'options'
    el = @$('.form-control').get 0
    editor = window.ace.edit el
    editor.getSession().setMode "ace/mode/#{language}"
    editor.setTheme "ace/theme/#{theme}"
    editor.getSession().setTabSize 2
    editor.setOptions options
    editor.on 'change', =>
      value = editor.getSession().getValue()
      @trigger 'editorChange', value
    @set 'editor', editor
  onEditorChange: Ember.on 'editorChange', (value) -> @set 'value', value
  onValueChange: Ember.observer 'value', ->
    editor = @get 'editor'
    value = @get('value') or ''
    editorValue = editor.getSession().getValue()
    if editorValue != value
      editor.getSession().setValue value
  actions:
    fullscreen: ->
      editor = @get 'editor'
      el = editor.container
      el.requestFullscreen?()
      el.msRequestFullscreen?()
      el.mozRequestFullScreen?()
      el.webkitRequestFullscreen?()

`export default ApAceEditorComponent`
