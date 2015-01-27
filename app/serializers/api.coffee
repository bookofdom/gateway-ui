`import ApplicationSerializer from './application'`

ApiSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      environments: "/apis/#{hash.id}/environments"
      endpoint_groups: "/apis/#{hash.id}/endpoint_groups"
    @_super.apply @, arguments

`export default ApiSerializer`
