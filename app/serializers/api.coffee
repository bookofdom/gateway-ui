`import ApplicationSerializer from './application'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      environments: "/apis/#{hash.id}/environments"
      endpoint_groups: "/apis/#{hash.id}/endpoint_groups"
      remote_endpoints: "/apis/#{hash.id}/remote_endpoints"
      proxy_endpoints: "/apis/#{hash.id}/proxy_endpoints"
    @_super.apply @, arguments

`export default ApiSerializer`
