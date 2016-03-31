`import { Model, belongsTo } from 'ember-cli-mirage'`

ProxyEndpointModel = Model.extend
  api: belongsTo()

`export default ProxyEndpointModel`
