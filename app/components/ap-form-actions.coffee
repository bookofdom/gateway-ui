`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApFormActionsComponent = BsBaseComponent.extend
  classNames: ['ap-form-actions']
  classNameBindings: ['inline:form-group']

  inline: false
  horizontal: true
  offset: true

  isSaving: false

  'show-save': true
  'show-cancel': false
  'show-delete': false
  'save-text': 'actions.save'
  'cancel-text': 'actions.cancel'
  'delete-text': 'actions.delete'
  'cancel-action': 'cancel'
  'delete-action': 'delete'
  actions:
    cancel: -> @sendAction 'cancel-action'
    delete: -> @sendAction 'delete-action'

`export default ApFormActionsComponent`
