`import DS from 'ember-data'`
`import config from  '../config/environment'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.url
  pathForType: (type) ->
    path = Ember.Inflector.inflector.pluralize type
    path = Ember.String.underscore path
    path
  ajax: (url, method, hash={}) ->
    hash.crossDomain = true
    hash.xhrFields ?= {}
    hash.xhrFields.withCredentials = true
    @_super url, method, hash
  ajaxError: (xhr, responseText) ->
    error = @_super.apply @, arguments
    if (xhr?.status == 422) or (xhr?.status == 400)
      response = Ember.$.parseJSON responseText
      new DS.InvalidError response
    else
      error

`export default ApplicationAdapter`
