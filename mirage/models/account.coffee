`import { Model, belongsTo } from 'ember-cli-mirage'`

AccountModel = Model.extend
  subscription_plan: belongsTo()

`export default AccountModel`
