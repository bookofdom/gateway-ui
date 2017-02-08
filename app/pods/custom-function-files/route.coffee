`import Ember from 'ember'`

CustomFunctionFileRoute = Ember.Route.extend
  model: -> @modelFor('custom-function').get 'files'

`export default CustomFunctionFileRoute`
