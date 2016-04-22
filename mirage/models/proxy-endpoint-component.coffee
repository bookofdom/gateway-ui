`import { Model, belongsTo } from 'ember-cli-mirage'`

ProxyEndpointComponentModel = Model.extend
  proxy_endpoint: belongsTo()

`export default ProxyEndpointComponentModel`
