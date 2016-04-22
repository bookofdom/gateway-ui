`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

RemoteEndpointModel = Model.extend
  api: belongsTo()
  remote_endpoint_environment_data: hasMany 'remote_endpoint_environment_datum'

`export default RemoteEndpointModel`
