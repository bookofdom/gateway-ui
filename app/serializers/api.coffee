`import ApplicationSerializer from './application'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.export = null # reset export so as not to save it more than once
    hash.links =
      proxy_endpoints: 'proxy_endpoints'
      environments: 'environments'
      endpoint_groups: 'endpoint_groups'
      remote_endpoints: 'remote_endpoints'
      hosts: 'hosts'
      libraries: 'libraries'
      shared_components: 'shared_components'
    @_super.apply @, arguments

`export default ApiSerializer`
