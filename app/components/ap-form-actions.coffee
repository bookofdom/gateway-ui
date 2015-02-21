`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApFormActionsComponent = BsBaseComponent.extend
  classNames: ['ap-form-actions']
  classNameBindings: ['extraClassNames']
  inline: false
  horizontal: true
  offset: true
  'show-save': true
  'show-cancel': false
  'show-delete': false
  'save-text': 'actions.save'
  'cancel-text': 'actions.cancel'
  'delete-text': 'actions.delete'
  'cancel-action': 'cancel'
  'delete-action': 'delete'
  extraClassNames: Ember.computed 'inline', ->
    # add form-group class for proper inlining
    'form-group' if @get 'inline'
  actions:
    cancel: -> @sendAction 'cancel-action'
    delete: -> @sendAction 'delete-action'

`export default ApFormActionsComponent`
