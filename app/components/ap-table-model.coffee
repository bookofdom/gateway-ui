`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableModelComponent = BsBaseComponent.extend
  classNames: ['ap-table-model']
  models: null # array of model instances
  'delete-action': 'delete'
  'auto-delete': true
  'edit-path': null
  'partial-path': null
  'custom-primary-action': null
  'custom-primary-icon': null
  'custom-primary-t': null
  delete: (record) ->
    # TODO:  confirm delete
    record.destroyRecord()
  actions:
    'custom-primary': (record) ->
      @sendAction 'custom-primary-action', record
    delete: (record) ->
      if @get 'auto-delete'
        @delete record
      else
        @sendAction 'delete-action', record

`export default ApTableModelComponent`
