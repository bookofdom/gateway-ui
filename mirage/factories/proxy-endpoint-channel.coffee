`import { Factory, faker } from 'ember-cli-mirage'`

ProxyEndpointChannelFactory = Factory.extend
  # TODO this may need to be changed as remote endpoint types are added
  remote_endpoint_id: -> 13
  name: (i) -> "proxy-endpoint-channel-#{i}"

`export default ProxyEndpointChannelFactory`
