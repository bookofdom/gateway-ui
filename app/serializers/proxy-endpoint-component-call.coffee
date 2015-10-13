`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentCallSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    before:
      embedded: 'always'
    after:
      embedded: 'always'

`export default ProxyEndpointComponentCallSerializer`
