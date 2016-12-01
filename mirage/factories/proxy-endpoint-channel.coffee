`import { Factory, faker } from 'ember-cli-mirage'`

ProxyEndpointChannelFactory = Factory.extend
  remote_endpoint_id: -> (faker.random.number() % 3) + 1
  name: (i) -> "proxy-endpoint-channel-#{i}"

`export default ProxyEndpointChannelFactory`
