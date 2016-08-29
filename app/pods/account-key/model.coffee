`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

AccountKey = Model.extend
  # Fields
  name: DS.attr 'string'
  key: DS.attr 'string'

  # Relationships
  account: DS.belongsTo 'account', async: true

`export default AccountKey`
