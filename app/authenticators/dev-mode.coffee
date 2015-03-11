`import BaseAuthenticator from 'simple-auth/authenticators/base'`

DevModeAuthenticator = BaseAuthenticator.extend
  restore: (properties) ->
    new Ember.RSVP.Promise (resolve, reject) ->
      if properties?
        resolve properties
      else
        reject()
  authenticate: (credentials) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      resolve email: 'developer'

`export default DevModeAuthenticator`
