`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

AccountKey = Model.extend
  # Fields
  # TODO

  # Relationships
  account: DS.belongsTo 'account', async: true

`export default AccountKey`
