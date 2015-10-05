`import Ember from 'ember'`

ace = window.ace

ApAceEditorComponent = Ember.Component.extend
  classNames: ['ap-ace-editor']
  classNameBindings: ['sizeClass']
  value: null
  editor: null
  server: null
  size: null
  language: 'javascript'
  theme: 'slate'
  options:
    enableTern:
      # http://ternjs.net/doc/manual.html#option_defs
      defs: ['browser', 'ecma5']
      # http://ternjs.net/doc/manual.html#plugins
      plugins:
        doc_comment:
          fullDocs: true
    enableSnippets: true
    enableBasicAutocompletion: true
  sizeClass: Ember.computed 'size', ->
    size = @get 'size'
    "ap-ace-editor-#{size}" if size
  aceMode: Ember.computed 'language', ->
    "ace/mode/#{@get 'language'}"
  aceTheme: Ember.computed 'theme', ->
    "ace/theme/#{@get 'theme'}"
  didInsertElement: ->
    Ember.run =>
      @initializeEditor()
      @initializeTern()
  initializeEditor: ->
    options = @get 'options'
    el = @$('.form-control').get 0
    editor = ace.edit el
    editor.getSession().setMode @get('aceMode')
    editor.setTheme @get('aceTheme')
    editor.getSession().setTabSize 2
    editor.setOptions options
    editor.$blockScrolling = Infinity # prevents ace from logging warnings
    editor.on 'change', =>
      value = editor.getSession().getValue()
      @trigger 'editorChange', value
    @set 'editor', editor
  initializeTern: ->
    @restartTern()
  restartTern: ->
    server = @get 'editor.ternServer'
    server.restart()
  onEditorChange: Ember.on 'editorChange', (value) ->
    @set 'value', value
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
