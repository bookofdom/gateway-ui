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
        response =
          errors:
            base: [(xhr.responseJSON || json)?.error]
        @get('controller').send 'upload-error', response
  click: (e) ->
    @$('[type=file]').click() if !Ember.$(e.target).is '[type=file]'


`export default ApiFormImportView`
