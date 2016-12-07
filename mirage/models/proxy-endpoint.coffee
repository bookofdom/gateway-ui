`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

ProxyEndpointModel = Model.extend
  api: belongsTo()
  proxy_endpoint_components: hasMany()
  proxy_endpoint_schemas: hasMany()
  proxy_endpoint_channels: hasMany()

`export default ProxyEndpointModel`
