`import DS from 'ember-data'`
`import config from  'gateway/config/environment'`
`import t from 'gateway/helpers/i18n'`

ApplicationAdapter = DS.RESTAdapter.extend
  session: Ember.inject.service()

  host: config.api.url

  # errorMappings is an object whose keys represent the field names _from_
  # and whose values represent the field names _to_ which to map errors.
  # For instance, if the server responds with `{errors: {data: "error"}}` and
  # the mapping is `{data: 'body'}`, the `data` errors are copied into the
  # `body` attribute such that a response `{errors: {body: "error"}}`
  # is equivalent.
  errorMappings: null

  pathForType: (type) ->
    path = type
    path = Ember.Inflector.inflector.pluralize type if type != 'swagger'
    path = Ember.String.underscore path
    path
  cleanURL: (url) ->
    leadingProtocol = /^(http|ws)s?\:\/{2}/
    multiSlashes = /\/{2,}/g
    # if this is a relative path (because no host was specified),
    # then add an initial slash to make the path absolute
    url = "/#{url}" if !url.match leadingProtocol
    # if protocol is included,
    hasProtocol = url.match leadingProtocol
    if hasProtocol
      protocol = hasProtocol[0]
      remaining = url.replace(protocol, '').replace multiSlashes, '/'
    else
      protocol = ''
      remaining = url.replace multiSlashes, '/'
    url = "#{protocol}#{remaining}"
    url
  generateURL: (snapshot, parent, path) ->
    if snapshot
      parent = snapshot.belongsTo parent
      modelName = parent.modelName
      adapter = Ember.getOwner(@).lookup "adapter:#{modelName}"
      url = adapter.buildURL modelName, parent.id, parent
      if snapshot.id
        url = "#{url}/#{path}/#{snapshot.id}"
      else
        url = "#{url}/#{path}"
      @cleanURL url
  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    url = @cleanURL url
    url

  # TODO: remove ajax method override when ds-improved-ajax becomes available.
  ajax: (url, method, hash={}) ->
    hash = @_buildJQueryAjaxHash hash
    @_super url, method, hash

  # TODO: change method signature to `_requestToJQueryAjaxHash` when
  # ds-improved-ajax becomes available.
  _buildJQueryAjaxHash: (hash) ->
    hash.cache = false
    hash.crossDomain = true
    hash.xhrFields ?= {}
    hash.xhrFields.withCredentials = true
    hash.dataFilter = (data, type) ->
      data = data or '{}'
      data
    hash

  # Overrides handleResponse:
  # InvalidError needs a normalized errors array, not the raw payload errors.
  # InvalidError does not properly extract errors as suggested in the comments.
  handleResponse: (status, headers, payload, requestData) ->
    if @isAuthenticationError status
      @get('session').invalidate()
    else if @isSuccess status, headers, payload
      payload
    else if @isServerError status, headers, payload
      errors = @normalizeServerErrorResponse status, headers, payload
      new DS.InvalidError errors
    else
      errors = @normalizeErrorResponse status, headers, payload
      new DS.InvalidError errors

  isAuthenticationError: (status) ->
    (status is 401) or (status is 403)

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
    errorMappings = @get('errorMappings') or {}
    for key, value of errorMappings
      if payload.errors[key]
        payload.errors[value] = payload.errors[key]
    formattedErrors = []
    for fieldName, message of payload.errors
      message = message.join ' ' if Ember.isArray message
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
