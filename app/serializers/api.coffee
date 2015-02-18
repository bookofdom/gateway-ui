`import ApplicationSerializer from './application'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      environments: "environments"
      endpoint_groups: "endpoint_groups"
      remote_endpoints: "remote_endpoints"
      proxy_endpoints: "proxy_endpoints"
    @_super.apply @, arguments

`export default ApiSerializer`
