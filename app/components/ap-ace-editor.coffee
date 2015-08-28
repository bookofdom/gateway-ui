`import Ember from 'ember'`

ApAceEditorComponent = Ember.Component.extend
  classNameBindings: ['size']
  value: null
  editor: null
  size: null
  language: 'javascript'
  options:
    enableBasicAutocompletion: true
    enableLiveAutocompletion: true
  didInsertElement: ->
    el = @get 'element'
    editor = window.ace.edit el
    language = @get 'language'
    editor.getSession().setTabSize 2
    #editor.getSession().setMode "ace/mode/#{language}"
    editor.setOptions @get('options')
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

`export default ApAceEditorComponent`
