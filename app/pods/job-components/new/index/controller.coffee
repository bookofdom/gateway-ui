`import Ember from 'ember'`

JobComponentsNewIndexController = Ember.Controller.extend
  'job-components': Ember.inject.controller()
  components: Ember.computed 'job-components.model.[]', ->
    @get 'job-components.model'

`export default JobComponentsNewIndexController`
