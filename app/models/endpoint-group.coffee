`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

EndpointGroup = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: true

`export default EndpointGroup`
