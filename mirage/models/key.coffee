`import { Model, belongsTo } from 'ember-cli-mirage'`

KeyModel = Model.extend
  account: belongsTo()

`export default KeyModel`
