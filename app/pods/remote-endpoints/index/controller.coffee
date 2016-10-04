`import Ember from 'ember'`
`import RemoteEndpointLike from 'gateway/pods/remote-endpoint-like/model'`
`import t from 'gateway/helpers/i18n'`
`import config from  'gateway/config/environment'`

RemoteEndpointsIndexController = Ember.Controller.extend
  'remote-endpoints': Ember.inject.controller()

  types: Ember.computed ->
    enabledTypes = config.remote_endpoint_types_enabled?.split ','
    types = RemoteEndpointLike.types
    if enabledTypes
      types = types.filter (type) -> type.value in enabledTypes
    types

  labels: Ember.computed 'types', 'remote-endpoints.type', ->
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
    name: 'platformName'
    label: 'fields.type'
    type: 'string'
  ,
    name: 'location'
    label: 'fields.location'
    type: 'string'
  ,
    name: 'statusTypeName'
    label: 'fields.status'
    type: 'status-label'
  ,
    name: 'method'
    label: 'fields.method'
    type: 'string'
  ]

`export default RemoteEndpointsIndexController`
