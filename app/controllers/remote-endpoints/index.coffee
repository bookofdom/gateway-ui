`import Ember from 'ember'`
`import RemoteEndpoint from '../../models/remote-endpoint'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointsIndexController = Ember.Controller.extend
  'remote-endpoints': Ember.inject.controller()

  types: Ember.computed -> RemoteEndpoint.types

  labels: Ember.computed 'types', 'remote-endpoints.type', ->
    type = @get 'remote-endpoints.type'
    typeDef = RemoteEndpoint.types.findBy 'value', type
    type: typeDef?.name or t('prompts.choose-x', x: 'fields.type')

  filtered: Ember.computed 'model', 'remote-endpoints.type', ->
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
    name: 'method'
    label: 'fields.method'
    type: 'string'
  ]

`export default RemoteEndpointsIndexController`
