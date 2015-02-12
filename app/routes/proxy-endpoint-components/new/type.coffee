`import Ember from 'ember'`

# TODO:  before navigating away from this route, remove new unsaved components
# so that these are not accidentally saved through a proxy endpoint save op

ProxyEndpointComponentsNewTypeRoute = Ember.Route.extend
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
    'stuff'
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

`export default ProxyEndpointComponentsNewTypeRoute`
