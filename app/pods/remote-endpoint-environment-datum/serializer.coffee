`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway-ui/pods/remote-endpoint-like/serializer'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    remote_endpoint:
      serialize: false
    scratch_pads:
      serialize: false
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    hosts:
      embedded: 'always'
    push_platforms:
      embedded: 'always'
    arguments:
      serialize: false
      deserialize: 'records'
    environment_variables:
      serialize: false
      deserialize: 'records'

`export default RemoteEndpointEnvironmentDatumSerializer`
