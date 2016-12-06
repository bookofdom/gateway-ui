`import Ember from 'ember'`


EnvironmentsRoute = Ember.Route.extend
  model: -> @modelFor('api').get 'environments'

  actions:
    saved: -> # no op

`export default EnvironmentsRoute`
