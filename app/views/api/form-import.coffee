`import Ember from 'ember'`

ApiFormImportView = Ember.View.extend
  didInsertElement: ->
    @$('form').fileupload
      xhrFields:
        withCredentials: true
      success: (e, data) =>
        @get('controller').send 'upload-success'
      error: (xhr) =>
        json = JSON.parse xhr.responseText if xhr.responseText
        errors = (xhr.responseJSON || json)?.errors
        @get('controller').send 'upload-error', errors
  click: (e) ->
    @$('[type=file]').click() if !Ember.$(e.target).is '[type=file]'
    

`export default ApiFormImportView`
