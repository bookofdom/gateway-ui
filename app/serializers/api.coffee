`import DS from 'ember-data'`

ApiSerializer = DS.RESTSerializer.extend
  normalize: (type, hash, property) ->
    hash.url = "/apis/#{hash.id}"
    hash.links =
      environments: "#{hash.url}/environments"
    @_super.apply @, arguments

`export default ApiSerializer`
