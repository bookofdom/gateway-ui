`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentsNewTypeRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    # first, remove any lingering new unsaved components
    @removeNewComponents()
    # create the new component
    components = @modelFor('proxy-endpoint').get 'components'
    model = @store.createRecord 'proxy-endpoint-component',
      type: params.proxy_endpoint_component_type
    # populate relationships (if necessary)
    @populateRelationships model
    # add to the proxy endpoint
    components.pushObject model
    model
  removeNewComponents: ->
    @modelFor('proxy-endpoint').get('components').filterBy('isNew', true).forEach (component) ->
      component.deleteRecord()
  populateRelationships: (model) ->
    @addNewCall model
    @addNewBefore model
    @addNewAfter model
  addNewCall: (model) ->
    if model.get 'single'
      model.set 'call', @store.createRecord 'proxy-endpoint-component-call'
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

`export default ProxyEndpointComponentsNewTypeRoute`
