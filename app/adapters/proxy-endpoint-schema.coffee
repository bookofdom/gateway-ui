`import ProxyEndpointRelatedAdapter from 'gateway/adapters/proxy-endpoint-related'`
`import config from  'gateway/config/environment'`
`import t from 'gateway/helpers/i18n'`

ProxyEndpointSchemaAdapter = ProxyEndpointRelatedAdapter.extend
  # Raises a JSON error if invalid json passed.  We do it here in the adapter,
  # since Ember doesn't have a decent hook elsewhere.
  ajax: (url, type, options) ->
    data = options?.data?.proxy_endpoint_schema
    {request_schema, response_schema} = data if data
    try
      JSON.parse request_schema if request_schema
    catch e
      errorField = 'request_schema'
    try
      JSON.parse response_schema if response_schema
    catch e
      errorField = 'response_schema'
    if errorField
      Ember.RSVP.reject new DS.InvalidError [
        detail: t 'errors.invalid-json'
        source:
          pointer: '/data'
      ]
    else
      @_super arguments...

`export default ProxyEndpointSchemaAdapter`
