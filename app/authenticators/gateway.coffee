`import BaseAuthenticator from 'ember-simple-auth/authenticators/base'`
`import config from 'gateway/config/environment'`

GatewayAuthenticator = BaseAuthenticator.extend
  url: Ember.computed -> config.api.authentication.url
  restore: (properties) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      if properties?
        resolve properties
      else
        reject()
  authenticate: (identification, password) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      data =
        email: identification
        password: password
      success = (response) ->
        #Ember.run -> resolve response.user
        resolve response.user or email: data.email
      failure = (xhr, status, error) ->
        #Ember.run -> reject xhr.responseJSON || xhr.responseText
        json = JSON.parse xhr.responseText if xhr.responseText
        reject (xhr.responseJSON || json)?.error
      @makeRequest(data).then success, failure
  invalidate: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @makeRequest({}, 'DELETE').then resolve, reject
  makeRequest: (data, method='POST') ->
    Ember.$.ajax
      url: @get 'url'
      type: method
      contentType: 'application/json'
      data: JSON.stringify data
      crossDomain: true
      xhrFields:
        withCredentials: true

`export default GatewayAuthenticator`
