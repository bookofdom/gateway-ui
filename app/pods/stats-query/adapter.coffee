`import Ember from 'ember'`
`import DS from 'ember-data'`
`import FixtureAdapter from 'ember-data-fixture-adapter'`
`import config from  'gateway/config/environment'`

StatsQueryAdapter = FixtureAdapter.extend DS.BuildURLMixin,
  host: config.api.url
  pathForType: -> 'stats'
  buildURL: (type, id, snapshot) ->
    url = @_super arguments...
    applicationAdapter = Ember.getOwner(@).lookup 'adapter:application'
    applicationAdapter.cleanURL url
  queryParamsForSnapshot: (snapshot) ->
    attrs = snapshot.attributes()
    query =
      start: attrs.start
      end: attrs.end
    Ember.merge query, attrs.default_query
  executeQuery: (snapshot) ->
    url = @buildURL 'stats-query', snapshot.id, snapshot
    query = snapshot.record.get 'queryParams'
    new Ember.RSVP.Promise (resolve, reject) ->
      Ember.$.ajax
        url: url
        method: 'GET'
        dataType: 'text'
        data: query
      .then (response) ->
        resolve response
      , (xhr, status, error) ->
        reject xhr.responseJSON

`export default StatsQueryAdapter`
