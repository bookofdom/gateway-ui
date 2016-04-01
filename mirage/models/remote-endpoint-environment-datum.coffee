`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

RemoteEndpointEnvironmentDatumModel = Model.extend
  remote_endpoint: belongsTo()
  scratch_pads: hasMany()

`export default RemoteEndpointEnvironmentDatumModel`
