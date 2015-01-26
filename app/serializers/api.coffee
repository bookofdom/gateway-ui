`import DS from 'ember-data'`

ApiSerializer = DS.RESTSerializer.extend
  normalize: (type, hash, property) ->
    hash.links =
      environments: "/apis/#{hash.id}/environments"
    @_super.apply @, arguments

`export default ApiSerializer`
