`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

PushDeviceModel = Model.extend
  push_messages: hasMany 'push_message'
  push_channel: belongsTo()

`export default PushDeviceModel`
