RouterInjectorInitializer =
  name: 'router-injector'
  initialize: (app) ->
    app.inject 'component', 'router', 'router:main'

`export default RouterInjectorInitializer`
