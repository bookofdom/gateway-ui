`import Ember from 'ember'`
`import RemoteEndpointLike from 'gateway-ui/pods/remote-endpoint-like/model'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from  'gateway-ui/config/environment'`

RemoteEndpointsIndexController = Ember.Controller.extend
  'remote-endpoints': Ember.inject.controller()

  labels: Ember.computed 'remote-endpoints.type', ->
    type = @get 'remote-endpoints.type'
    typeDef = RemoteEndpointLike.types.findBy 'value', type
    type: typeDef?.name or t('prompts.choose-x', x: 'fields.type')

  filtered: Ember.computed 'model.[]', 'remote-endpoints.type', ->
    type = @get 'remote-endpoints.type'
    filtered = @get 'model'
    filtered = filtered.filterBy 'type', type if type
    filtered

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'platform.nameKey'
    label: 'fields.type'
    type: 't'
  ,
    name: 'location'
    label: 'fields.location'
    type: 'string'
  ,
    name: 'statusType.nameKey'
    label: 'fields.status'
    type: 'status-label'
  ,
    name: 'method'
    label: 'fields.method'
    type: 'string'
  ]

`export default RemoteEndpointsIndexController`
