`import Ember from 'ember'`
`import config from '../../config/environment'`

ApiFormImportController = Ember.Controller.extend
  url: Ember.computed ->
    url = []
    url.push config.api.url
    url.push 'apis'
    url.push 'import'
    url = url.join '/'
    host = "#{window.location.protocol}//#{window.location.host}"
    url = "#{host}#{url}" if !config.api.host
    url
  actions:
    'upload-success': ->
      @set 'model.name', null
      @send 'refresh'
    'upload-error': (response) ->
      @get('model.errors').clear()
      for name, errorList of response.errors
        @get('model.errors').add name, errorList[0]

`export default ApiFormImportController`
