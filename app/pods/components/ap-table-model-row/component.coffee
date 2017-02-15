`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`
`import config from 'gateway-ui/config/environment'`

ApTableModelRowComponent = BsBaseComponent.extend
  confirm: Ember.inject.service()
  tagName: 'tr'
  classNames: ['ap-table-model-row']
  model: null
  'delete-action': 'delete'
  'edit-path': null
  'custom-primary': false
  'custom-primary-action-name': 'custom-primary'
  'custom-primary-action': null
  'custom-primary-icon': null
  'custom-primary-t': null
  confirmDelete: ->
    if config.confirmDelete
      @get('confirm').open 'prompts.confirm-delete'
    else
      true
  actions:
    'custom-primary': ->
      @sendAction 'custom-primary-action-name', @get('model')
    delete: ->
      if @confirmDelete()
        @sendAction 'delete-action', @get('model')

`export default ApTableModelRowComponent`
