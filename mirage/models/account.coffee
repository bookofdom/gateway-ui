`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

AccountModel = Model.extend
  plan: belongsTo()
  key: hasMany()

`export default AccountModel`
