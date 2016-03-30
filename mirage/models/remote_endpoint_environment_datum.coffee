`import { Model, belongsTo } from 'ember-cli-mirage'`

RemoteEndpointEnvironmentDatumModel = Model.extend
  remote_endpoint: belongsTo()

`export default RemoteEndpointEnvironmentDatumModel`
