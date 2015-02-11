`import DS from 'ember-data'`

RemoteEndpointEnvironmentDatum = DS.Model.extend
  url: DS.attr 'string'
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint'
  toJSON: ->
    environment_id: @get 'environment.id'
    data:
      url: @get 'url'

`export default RemoteEndpointEnvironmentDatum`
