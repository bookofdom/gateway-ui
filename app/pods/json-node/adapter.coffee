`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`
`import config from  'gateway-ui/config/environment'`

JsonNodeAdapter = ApplicationAdapter.extend
  # Query is called with the JSON to be parsed directly,
  # thus this method always resolves with the query data as the response.
  # Query may be stringified JSON or an object.
  query: (store, type, query) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      parsedJson = query
      if typeof query is 'string'
        try parsedJson = JSON.parse query
      if parsedJson
        Ember.run null, resolve, parsedJson
      else
        Ember.run null, reject

`export default JsonNodeAdapter`
