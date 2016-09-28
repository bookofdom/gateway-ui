`import Ember from 'ember'`

ActionComponentsNewTypeRoute = Ember.Route.extend
  model: (params) ->
    # first, remove any lingering new unsaved components
    @removeNewComponents()
    # create the new component
    components = @get 'parentRoute.parentRoute.parentModel.components'
    type = params.action_component_type
    prefix = @get 'parentRoute.parentRoute.parentRouteName'
    model = @store.createRecord "#{prefix}-component",
      type: type
    # populate relationships (if necessary)
    @populateRelationships model
    # add to the proxy endpoint
    components.pushObject model
    model
  removeNewComponents: ->
    @get('parentRoute.parentRoute.parentModel.components').filterBy('isNew', true).forEach (component) ->
      component.deleteRecord()
  populateRelationships: (model) ->
    if !model.get 'shared'
      @addNewCall model
      @addNewBefore model
      @addNewAfter model
  addNewCall: (model) ->
    if model.get 'single'
      calls = model.get 'calls'
      prefix = @get 'parentRoute.parentRoute.parentRouteName'
      calls.pushObject @store.createRecord "#{prefix}-component-call"
  addNewBefore: (model) ->
    if !model.get 'js'
      prefix = @get 'parentRoute.parentRoute.parentRouteName'
      record = @store.createRecord "#{prefix}-component-transformation"
      model.get('before').pushObject record
  addNewAfter: (model) ->
    if !model.get 'js'
      prefix = @get 'parentRoute.parentRoute.parentRouteName'
      record = @store.createRecord "#{prefix}-component-transformation"
      model.get('after').pushObject record
  actions:
    willTransition: ->
      @removeNewComponents()
      true
    saved: ->
      model = @get 'parentRoute.parentRoute.parentModel.components.lastObject'
      prefix = @get 'parentRoute.parentRoute.parentRouteName'
      @transitionTo "#{prefix}-component.edit", model

`export default ActionComponentsNewTypeRoute`
