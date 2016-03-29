`import { Model, belongsTo } from 'ember-cli-mirage'`

RemoteEndpointModel = Model.extend
  api: belongsTo()

`export default RemoteEndpointModel`
