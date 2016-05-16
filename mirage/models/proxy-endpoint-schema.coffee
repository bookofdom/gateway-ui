`import { Model, belongsTo } from 'ember-cli-mirage'`

ProxyEndpointSchemaModel = Model.extend
  proxy_endpoint: belongsTo()

`export default ProxyEndpointSchemaModel`
