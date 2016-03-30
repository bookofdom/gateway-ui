`import { Model, belongsTo } from 'ember-cli-mirage'`

ScratchPadModel = Model.extend
  environment_datum: belongsTo 'remote_endpoint_environment_datum'

`export default ScratchPadModel`
