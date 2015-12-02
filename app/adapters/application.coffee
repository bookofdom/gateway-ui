`import DS from 'ember-data'`
`import config from  '../config/environment'`
`import t from 'gateway/helpers/i18n'`

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.api.url
  pathForType: (type) ->
    path = type
    path = Ember.Inflector.inflector.pluralize type if type != 'swagger'
    path = Ember.String.underscore path
    path
  cleanURL: (url) ->
    leadingProtocol = /^(http|ws)s?\:\/{2}/
    doubleSlashes = /\/{2}/g
    # if this is a relative path (because no host was specified),
    # then add an initial slash to make the path absolute
    url = "/#{url}" if !url.match leadingProtocol
    # if protocol is included,
    hasProtocol = url.match leadingProtocol
    if hasProtocol
      protocol = hasProtocol[0]
      remaining = url.replace(protocol, '').replace doubleSlashes, '/'
    else
      protocol = ''
      remaining = url.replace doubleSlashes, '/'
    url = "#{protocol}#{remaining}"
    url
  buildURL: (type, id, snapshot) ->
    url = @_super.apply @, arguments
    url = @cleanURL url
    url
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
    status = xhr?.status
    response = null
    if (status >= 400) and !(status == 404)
      response = Ember.$.parseJSON xhr.responseText if xhr?.responseText
      if response?.error and typeof response.error == 'string'
        response =
          errors:
            base: [response.error]
      # 500 server errors and anonymous errors get an "unknown error" message
      if (status >= 500) or !xhr?.responseText
        response =
          errors:
            base: ["#{t('errors.unknown').capitalize()}."]
      new DS.InvalidError response.errors
    else
      error

`export default ApplicationAdapter`
