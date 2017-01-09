`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.export = null # reset export so as not to save it more than once
    hash.links =
      proxy_endpoints: 'proxy_endpoints'
      jobs: 'jobs'
      custom_functions: 'custom_functions'
      environments: 'environments'
      endpoint_groups: 'endpoint_groups'
      remote_endpoints: 'remote_endpoints'
      hosts: 'hosts'
      libraries: 'libraries'
      shared_components: 'shared_components'
    @_super arguments...

`export default ApiSerializer`
