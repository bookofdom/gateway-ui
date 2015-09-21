`import DS from 'ember-data'`
`import config from  '../config/environment'`
`import t from 'gateway/helpers/i18n'`

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
    hash.dataFilter = (data, type) ->
      data = data or '{}'
      data
    @_super url, method, hash
  ajaxError: (xhr) ->
    error = @_super.apply @, arguments
    response = null
    if (xhr?.status >= 400) and !(xhr?.status == 404)
      response = Ember.$.parseJSON xhr.responseText if xhr?.responseText
      if response?.error and typeof response.error == 'string'
        response =
          errors:
            base: [response.error]
      if !xhr?.responseText
        response =
          errors:
            base: ["#{t('errors.unknown').capitalize()}."]
      new DS.InvalidError response.errors
    else
      error

`export default ApplicationAdapter`
