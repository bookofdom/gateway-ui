`import FixtureAdapter from 'ember-data-fixture-adapter'`
`import config from  'gateway/config/environment'`

AnalyticsQueryAdapter = FixtureAdapter.extend DS.BuildURLMixin,
  host: config.api.url
  pathForType: -> 'stats'
  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    applicationAdapter = @container.lookup 'adapter:application'
    applicationAdapter.cleanURL url
  executeQuery: (snapshot) ->
    url = @buildURL 'analytics-query', snapshot.id, snapshot
    query = snapshot.record.get 'queryParams'
    Ember.$.ajax
      url: url
      method: 'GET'
      dataType: 'text'
      data: query

`export default AnalyticsQueryAdapter`
