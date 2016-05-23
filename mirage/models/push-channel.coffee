`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

PushChannelModel = Model.extend
  push_devices: hasMany 'push_device'

`export default PushChannelModel`
