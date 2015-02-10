`import DS from 'ember-data'`

ProxyEndpointComponentSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    call:
      embedded: 'always'

`export default ProxyEndpointComponentSerializer`
