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
    url = @_super arguments...
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

  # Overrides handleResponse:
  # InvalidError needs a normalized errors array, not the raw payload errors.
  # InvalidError does not properly extract errors as suggested in the comments.
  handleResponse: (status, headers, payload, requestData) ->
    if @isSuccess status, headers, payload
      payload
    else if @isServerError status, headers, payload
      errors = @normalizeServerErrorResponse status, headers, payload
      new DS.InvalidError errors
    else
      errors = @normalizeErrorResponse status, headers, payload
      new DS.InvalidError errors

  isServerError: (status, headers, payload) ->
    status >= 500

  # Returns a formatted errors array containing a single, anonymous error.
  # Useful when a server error occured, or when the cause or type of error
  # is unknown.
  normalizeServerErrorResponse: (status, headers, payload) ->
    [
      status: status
      detail: "#{t('errors.unknown').capitalize()}."
      source:
        pointer: '/data'
    ]

  # Transforms older errors object (errors: {fieldName: "message"})
  # into JSON API style errors object (errors: [{source: "", detail: ""}, {...}])
  # http://jsonapi.org/examples/
  # https://github.com/emberjs/data/blob/v2.3.0/addon/adapters/rest.js#L20
  normalizeErrorResponse: (status, headers, payload) ->
    formattedErrors = []
    for fieldName, message of payload.errors
      if fieldName is 'base'
        formattedErrors.push
          status: status
          detail: message
          source:
            pointer: '/data'
      else
        formattedErrors.push
          status: status
          detail: message
          source:
            pointer: "/data/attributes/#{fieldName}"
    formattedErrors

`export default ApplicationAdapter`
