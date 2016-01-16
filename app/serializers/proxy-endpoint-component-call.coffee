`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentCallSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    before:
      embedded: 'always'
    after:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.before = [] if !hash.before
    hash.after = [] if !hash.after
    @_super.apply @, arguments

`export default ProxyEndpointComponentCallSerializer`
