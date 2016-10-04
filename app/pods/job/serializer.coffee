`import DS from 'ember-data'`
`import ApiRelatedSerializer from 'gateway/pods/api-related/serializer'`

JobSerializer = ApiRelatedSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    api:
      serialize: false
    components:
      embedded: 'always'
  normalize: (type, hash, property) ->
    hash.components = [] if !hash.components
    @_super arguments...

`export default JobSerializer`
