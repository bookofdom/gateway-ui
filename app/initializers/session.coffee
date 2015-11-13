SessionInitializer =
  name: 'session-service'
  initialize: (container, app) ->
    app.inject 'model', 'session', 'simple-auth-session:main'

`export default SessionInitializer`
