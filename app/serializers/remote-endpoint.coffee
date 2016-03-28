`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway/serializers/remote-endpoint-like'`

RemoteEndpointSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    api:
      serialize: false
    environment_data:
      embedded: 'always'

`export default RemoteEndpointSerializer`
