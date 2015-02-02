`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApTableModelRowComponent = BsBaseComponent.extend
  tagName: 'tr'
  classNames: ['ap-table-model-row']
  model: null
  'delete-action': 'delete'
  'edit-path': null
  actions:
    delete: -> @sendAction 'delete-action', @get('model')

`export default ApTableModelRowComponent`
