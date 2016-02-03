`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend
  attrs:
    remote_endpoint:
      serialize: false
    environment:
      serialize: 'id'

`export default RemoteEndpointEnvironmentDatumSerializer`
