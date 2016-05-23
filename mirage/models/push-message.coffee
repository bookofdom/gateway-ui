`import { Model, belongsTo } from 'ember-cli-mirage'`

PushMessageModel = Model.extend
  push_device: belongsTo 'push_device'

`export default PushMessageModel`
