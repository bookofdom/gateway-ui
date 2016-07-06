`import { Model, belongsTo } from 'ember-cli-mirage'`

PushChannelMessageModel = Model.extend
  push_channel: belongsTo 'push_channel'

`export default PushChannelMessageModel`
