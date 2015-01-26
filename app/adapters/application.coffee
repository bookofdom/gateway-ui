`import DS from 'ember-data'`
`import config from  '../config/environment'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.url
  #pathForType: (type) -> Ember.String.underscore type
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
  buildURL: (typeKey, id, record) ->
    url = @_super.apply @, arguments
    # if record has its own URL, use it
    if record?.get 'url'
      host = Ember.get @, 'host'
      path = record?.get 'url'
      url = "#{host}#{path}"
    url

`export default ApplicationAdapter`
