`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from 'gateway/pods/remote-endpoint-like/serializer'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    remote_endpoint:
      serialize: false
    scratch_pads:
      serialize: false

`export default RemoteEndpointEnvironmentDatumSerializer`
