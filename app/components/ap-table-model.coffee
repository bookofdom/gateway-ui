`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableModelComponent = BsBaseComponent.extend
  notify: Ember.inject.service()
  classNames: ['ap-table-model']
  models: null # array of model instances
  'delete-action': 'delete'
  'refresh-action': 'refresh'
  'auto-delete': true
  'edit-path': null
  'partial-path': null
  'component-name': null
  'custom-primary-action': null
  'custom-primary-icon': null
  'custom-primary-t': null
  delete: (record) ->
    record.destroyRecord().catch =>
      @notifyErrorsForRecord record
      @cancelDelete record
  cancelDelete: (record) ->
    record.transitionTo 'loaded.saved' # clear deleted state
    record.cancel().then =>
      @sendAction 'refresh-action'
  notifyErrorsForRecord: (record) ->
    errors = []
    record.get('errors').forEach (error) =>
      @get('notify').alert error.message
  actions:
    'custom-primary': (record) ->
      @sendAction 'custom-primary-action', record
    delete: (record) ->
      if @get 'auto-delete'
        @delete record
      else
        @sendAction 'delete-action', record

`export default ApTableModelComponent`
