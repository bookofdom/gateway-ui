`import BaseAuthenticator from 'simple-auth/authenticators/base'`
`import config from '../config/environment'`

GatewayAuthenticator = BaseAuthenticator.extend
  url: Ember.computed -> config.api.authentication.url
  restore: (properties) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      if properties?
        resolve properties
      else
        reject()
  authenticate: (credentials) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      data =
        email: credentials.identification
        password: credentials.password
      success = (response) ->
        #Ember.run -> resolve response.user
        resolve response.user or email: data.email
      failure = (xhr, status, error) ->
        #Ember.run -> reject xhr.responseJSON || xhr.responseText
        reject xhr.responseJSON || xhr.responseText
      @makeRequest(data).then success, failure
  makeRequest: (data) ->
    Ember.$.ajax
      url: @get 'url'
      type: 'POST'
      contentType: 'application/json'
      #dataType: 'json'
      data: JSON.stringify data
      #beforeSend: (xhr, settings) ->
      #  xhr.setRequestHeader 'Accept', 'application/json'

`export default GatewayAuthenticator`
