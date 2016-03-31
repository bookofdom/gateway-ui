`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

ProxyEndpointModel = Model.extend
  api: belongsTo()
  proxy_endpoint_components: hasMany()

`export default ProxyEndpointModel`
