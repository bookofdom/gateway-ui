`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from 'gateway-ui/config/environment'`

ApTableModelRowComponent = BsBaseComponent.extend
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
  confirm: (text) ->
    if config.confirmDelete
      confirm text
    else
      true
  actions:
    'custom-primary': ->
      @sendAction 'custom-primary-action-name', @get('model')
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if @confirm confirmText
        @sendAction 'delete-action', @get('model')

`export default ApTableModelRowComponent`
