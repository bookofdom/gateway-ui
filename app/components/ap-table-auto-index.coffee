`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`
`import config from '../config/environment'`

ApTableAutoIndexComponent = Ember.Component.extend
  notify: Ember.inject.service()
  classNames: ['ap-table-auto-index', 'table-responsive']

  # Array of model instances.
  model: null

  # Array of field configurations.
  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]

  # Route name for links.
  route: null

  delete: (model) ->
    model.destroyRecord().catch =>
      # notify user of errors
      model.get('errors').forEach (error) ->
        @get('notify').alert error.message
      # clear deleted state
      model.cancel()
      model.transitionTo 'loaded.saved'

  actions:
    delete: (model) ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if config.confirmDelete and confirm(confirmText)
        @delete model

    toggleBoolean: (model, fieldName, autoSave) ->
      value = model.get fieldName
      model.set fieldName, !value
      model.save() if autoSave

`export default ApTableAutoIndexComponent`
