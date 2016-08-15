`import { Model, belongsTo } from 'ember-cli-mirage'`

AccountModel = Model.extend
  plan: belongsTo()

`export default AccountModel`
