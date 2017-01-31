`import Ember from 'ember'`

JobComponentsNewTypeRoute = Ember.Route.extend
  model: (params) ->
    # first, remove any lingering new unsaved components
    @removeNewComponents()
    # create the new component
    components = @modelFor('job').get 'components'
    type = params.job_component_type
    model = @store.createRecord 'job-component',
      type: type
    # populate relationships (if necessary)
    @populateRelationships model
    # add to the proxy endpoint
    components.pushObject model
    model
  removeNewComponents: ->
    @modelFor('job').get('components').filterBy('isNew', true).forEach (component) ->
      component.deleteRecord()
  populateRelationships: (model) ->
    if !model.get('shared') and !model.get('advanced')
      @addNewCall model
      @addNewBefore model
      @addNewAfter model
  addNewCall: (model) ->
    if model.get 'single'
      calls = model.get 'calls'
      calls.pushObject @store.createRecord 'job-component-call'
  addNewBefore: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'job-component-transformation'
      model.get('before').pushObject record
  addNewAfter: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'job-component-transformation'
      model.get('after').pushObject record
  actions:
    willTransition: ->
      @removeNewComponents()
      true
    saved: ->
      model = @modelFor('job').get 'components.lastObject'
      @transitionTo 'job-component.edit', model

`export default JobComponentsNewTypeRoute`
