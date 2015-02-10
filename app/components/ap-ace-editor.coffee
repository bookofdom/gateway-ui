`import Ember from 'ember'`

ApAceEditorComponent = Ember.Component.extend
  value: null
  editor: null
  language: 'javascript'
  didInsertElement: ->
    el = @get 'element'
    editor = window.ace.edit el
    language = @get 'language'
    editor.getSession().setTabSize 2
    editor.getSession().setMode "ace/mode/#{language}"
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
