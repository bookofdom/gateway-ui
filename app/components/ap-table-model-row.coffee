`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`
`import t from 'gateway/helpers/i18n'`

ApTableModelRowComponent = BsBaseComponent.extend
  tagName: 'tr'
  classNames: ['ap-table-model-row']
  model: null
  'delete-action': 'delete'
  'edit-path': null
  actions:
    delete: ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if confirm confirmText
        @sendAction 'delete-action', @get('model')

`export default ApTableModelRowComponent`
