`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

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
  actions:
    'custom-primary': ->
      @sendAction 'custom-primary-action-name', @get('model')
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if confirm confirmText
        @sendAction 'delete-action', @get('model')

`export default ApTableModelRowComponent`
