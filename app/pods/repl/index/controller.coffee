`import Ember from 'ember'`

ReplIndexController = Ember.Controller.extend
  apiController: Ember.inject.controller 'api'
  api: Ember.computed.alias 'apiController.model'
  environments: Ember.computed.alias 'api.environments'
  environmentName: Ember.computed.alias 'model.environment.name'
  actions:
    evaluate: (input) ->
      @get('model').evaluate input

`export default ReplIndexController`
