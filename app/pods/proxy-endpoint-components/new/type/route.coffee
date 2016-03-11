`import Ember from 'ember'`


ProxyEndpointComponentsNewTypeRoute = Ember.Route.extend 
  model: (params) ->
    # first, remove any lingering new unsaved components
    @removeNewComponents()
    # create the new component
    components = @modelFor('proxy-endpoint').get 'components'
    type = params.proxy_endpoint_component_type
    model = @store.createRecord 'proxy-endpoint-component',
      type: type
    # populate relationships (if necessary)
    @populateRelationships model
    # add to the proxy endpoint
    components.pushObject model
    model
  removeNewComponents: ->
    @modelFor('proxy-endpoint').get('components').filterBy('isNew', true).forEach (component) ->
      component.deleteRecord()
  populateRelationships: (model) ->
    if !model.get 'shared'
      @addNewCall model
      @addNewBefore model
      @addNewAfter model
  addNewCall: (model) ->
    if model.get 'single'
      calls = model.get 'calls'
      calls.pushObject @store.createRecord 'proxy-endpoint-component-call'
  addNewBefore: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'proxy-endpoint-component-transformation'
      model.get('before').pushObject record
  addNewAfter: (model) ->
    if !model.get 'js'
      record = @store.createRecord 'proxy-endpoint-component-transformation'
      model.get('after').pushObject record
  actions:
    willTransition: ->
      @removeNewComponents()
      true
    saved: ->
      model = @modelFor('proxy-endpoint').get 'components.lastObject'
      @transitionTo 'proxy-endpoint-component.edit', model

`export default ProxyEndpointComponentsNewTypeRoute`
