`import ApplicationSerializer from './application'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      proxy_endpoints: "proxy_endpoints"
      environments: "environments"
      endpoint_groups: "endpoint_groups"
      remote_endpoints: "remote_endpoints"
      hosts: "hosts"
    @_super.apply @, arguments

`export default ApiSerializer`
