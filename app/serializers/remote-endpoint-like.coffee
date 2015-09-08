`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointLikeSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    environment_data:
      embedded: 'always'
    hosts:
      embedded: 'always'

`export default RemoteEndpointLikeSerializer`
