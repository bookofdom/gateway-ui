`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApFormActionsComponent = BsBaseComponent.extend
  classNames: ['ap-form-actions']
  horizontal: true
  offset: true
  'show-save': true
  'show-cancel': false
  'save-text': 'actions.save'
  'cancel-text': 'actions.cancel'
  'cancel-action': 'cancel'
  actions:
    cancel: -> @sendAction 'cancel-action'

`export default ApFormActionsComponent`
