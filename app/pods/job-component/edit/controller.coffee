`import EditController from 'gateway/controllers/edit'`
`import t from 'gateway/helpers/i18n'`

JobComponentEditController = EditController.extend
  'api': Ember.inject.controller()

  callsIndexModel: Ember.computed.alias 'model.calls'
  'calls-option-groups': Ember.computed 'api.libraries', 'api.remote_endpoints.@each.isNew', ->
    conditional: @get 'api.libraries'
    remote_endpoint: @get('api.remote_endpoints').filterBy 'isNew', false
  'transformation-option-groups': Ember.computed 'api.libraries', ->
    body: @get 'api.libraries'
    type: [
      name: t('languages.javascript').capitalize()
      value: 'js'
    ]
  'option-groups': Ember.computed 'api.libraries', ->
    conditional: @get 'api.libraries'
    body: @get 'api.libraries'
    shared_component: @get 'api.shared_components'

`export default JobComponentEditController`
