`import ApplicationSerializer from './application'`

ProxyEndpointSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      environment:
        "/apis/#{hash.api_id}/environments/#{hash.environment_id}" if hash.environment_id
      endpoint_group:
        "/apis/#{hash.api_id}/endpoint_groups/#{hash.endpoint_group_id}" if hash.endpoint_group_id
    @_super.apply @, arguments

`export default ProxyEndpointSerializer`
