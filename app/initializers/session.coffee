SessionInitializer =
  name: 'session-service'
  initialize: (app) ->
    app.inject 'model', 'session', 'simple-auth-session:main'

`export default SessionInitializer`
