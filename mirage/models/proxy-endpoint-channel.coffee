`import { Model, belongsTo } from 'ember-cli-mirage'`

ProxyEndpointChannelModel = Model.extend
  proxy_endpoint: belongsTo()
  #remote_endpoint: belongsTo()

`export default ProxyEndpointChannelModel`
