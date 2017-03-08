`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`


ApAceEditorComponent = Ember.Component.extend
  classNames: ['ap-ace-editor']
  classNameBindings: ['sizeClass']
  value: null
  # Libraries are name/value pairs, where the values are code documents
  # that Tern should include in autocomplete.
  libraries: null
  editor: null
  server: null
  size: null
  language: 'javascript'
  theme: 'slate'
  readOnly: false
  options: Ember.computed 'readOnly', ->
    enableTern:
      # http://ternjs.net/doc/manual.html#option_defs
      defs: ['browser', 'ecma5']
      # http://ternjs.net/doc/manual.html#plugins
      plugins:
        doc_comment:
          fullDocs: true
    enableSnippets: true
    enableBasicAutocompletion: true
    #enableLiveAutocompletion: true
    readOnly: @get 'readOnly'
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
    editor = window.ace.edit @$('.form-control').get(0)
    @$().get(0).aceEditor = editor
    editor.getSession().setMode @get('aceMode')
    editor.setTheme @get('aceTheme')
    editor.getSession().setTabSize 2
    editor.setOptions options
    editor.$blockScrolling = Infinity # prevents ace from logging warnings
    editor.on 'change', =>
      value = @get('editor')?.getSession().getValue()
      @trigger 'editorChange', value
    @set 'editor', editor
    editor = null
  initializeTern: ->
    @restartTern()
    @addTernLibraries()
  restartTern: ->
    @get('editor.ternServer').restart()
  addTernLibraries: ->
    mode = @get 'aceMode'
    libraries = @get 'libraries'
    libraries?.forEach (library) =>
      name = t library.get 'name'
      value = library.get 'value'
      EditSession = window.ace.require('ace/edit_session').EditSession
      doc = new EditSession value, mode
      @get('editor.ternServer').addDoc name, doc
      EditSession = null
      doc = null
  onEditorChange: Ember.on 'editorChange', (value) ->
    @set 'value', value
  onValueChange: Ember.observer 'value', ->
    editor = @get 'editor'
    value = @get('value') or ''
    editorValue = editor.getSession().getValue()
    if editorValue != value
      editor.getSession().setValue value
    editor = null
  # TODO this is just awful.  tern doesn't clean up after itself
  willDestroy: ->
    editor = @get 'editor'
    @$()?.get(0)?.aceEditor = null
    editor.destroy()
    editor.container = null
    editor.session = null
    editor.ternServer.server.terminate()
    editor.ternServer.server = null
    for name, doc of editor.ternServer.docs
      doc.doc.destroy()
    editor.ternServer.docs = null
    editor.ternServer = null
    editor = null
    @set 'editor', null
    @_super arguments...
  actions:
    fullscreen: ->
      editor = @get 'editor'
      editor.container.requestFullscreen?()
      editor.container.msRequestFullscreen?()
      editor.container.mozRequestFullScreen?()
      editor.container.webkitRequestFullscreen?()
      editor = null

`export default ApAceEditorComponent`
