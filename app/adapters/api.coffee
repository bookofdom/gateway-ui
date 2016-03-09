`import ApplicationAdapter from './application'`
`import config from  '../config/environment'`

ApiAdapter = ApplicationAdapter.extend
  apRequestJavaScriptPath: 'ap-request.js'
  buildApRequestJavaScriptURL: Ember.computed ->
    apRequestJavaScriptPath = @get 'apRequestJavaScriptPath'
    @buildURL(apRequestJavaScriptPath).replace 'ap_request', 'ap-request'
  # Libraries should have a special entry for ap-request.js.  In order to
  # accomplish this, we hijack the request to load libraries and load both,
  # stuffing ap-request.js into the libraries payload
  findHasMany: (store, snapshot, url, relationship) ->
    if relationship.key is 'libraries'
      apRequestJavaScriptURL = @get 'buildApRequestJavaScriptURL'
      Ember.RSVP.hash
        apRequest: Ember.$.get apRequestJavaScriptURL
        libraries: @_super arguments...
      .then (results) =>
        results.libraries.libraries.push
          id: 'ap-request'
          name: 'Internal JavaScript'
          description: 'Internal JavaScript'
          data: results.apRequest
          internal: true
        results.libraries
    else
      @_super arguments...

`export default ApiAdapter`
