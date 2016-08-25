`import BaseAuthenticator from 'ember-simple-auth/authenticators/base'`

DevModeAuthenticator = BaseAuthenticator.extend
  restore: (properties) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      if properties?
        resolve properties
      else
        reject()
  authenticate: (identification, password) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      resolve email: 'developer@example.net'

`export default DevModeAuthenticator`
