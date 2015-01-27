`import DS from 'ember-data'`
`import config from  '../config/environment'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.url
  ajax: (url, method, hash={}) ->
    hash.crossDomain = true
    hash.xhrFields ?= {}
    hash.xhrFields.withCredentials = true
    @_super url, method, hash
  ajaxError: (xhr, responseText) ->
    error = @_super.apply @, arguments
    if xhr?.status == 422
      response = Ember.$.parseJSON responseText
      new DS.InvalidError response
    else
      error

`export default ApplicationAdapter`
