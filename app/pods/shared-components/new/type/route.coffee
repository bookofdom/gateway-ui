`import Ember from 'ember'`

SharedComponentsNewTypeRoute = Ember.Route.extend
  components: Ember.computed -> @modelFor 'shared-components'
  model: (params) ->
    # first, remove any lingering new unsaved components
    @removeNewComponents()
    # create the new component
    components = @get 'components'
    type = params.shared_component_type
    model = @store.createRecord 'shared-component',
      type: type
    # populate relationships (if necessary)
    @populateRelationships model
    # add to the index model
    components.pushObject model
    model
  removeNewComponents: ->
    @get('components').filterBy('isNew', true).forEach (component) ->
      component.deleteRecord()
  populateRelationships: (model) ->
    if !model.get 'shared'
      @addNewCall model
      @addNewBefore model
      @addNewAfter model
  addNewCall: (model) ->
    if model.get 'single'
      calls = model.get 'calls'
      calls.pushObject @store.createRecord 'shared-component-call'
  addNewBefore: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'shared-component-transformation'
      model.get('before').pushObject record
  addNewAfter: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'shared-component-transformation'
      model.get('after').pushObject record
  actions:
    willTransition: ->
      @removeNewComponents()
      true
    saved: ->
      model = @get 'components.lastObject'
      @transitionTo 'shared-component.edit', model

`export default SharedComponentsNewTypeRoute`
