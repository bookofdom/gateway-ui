`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway/serializers/remote-endpoint-like'`
`import ApiRelatedSerializer from 'gateway/serializers/api-related'`

RemoteEndpointSerializer = RemoteEndpointLikeSerializer.extend ApiRelatedSerializer,
  attrs:
    api:
      serialize: false
    environment_data:
      embedded: 'always'

`export default RemoteEndpointSerializer`
