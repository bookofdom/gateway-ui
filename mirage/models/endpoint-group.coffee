`import { Model, belongsTo } from 'ember-cli-mirage'`

EndpointGroupModel = Model.extend
  api: belongsTo()

`export default EndpointGroupModel`
