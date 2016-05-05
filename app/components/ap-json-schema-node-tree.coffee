`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApJsonSchemaNodeTreeComponent = BsBaseComponent.extend
  tagName: 'ul'
  classNames: ['ap-json-schema-node-tree']

  selectAction: 'select'
  selectedNode: null

  model: null # should be root instance of json-schema-node

  defaultSelected: Ember.on 'init', ->
    @send 'select', @get('model')

  actions:
    select: (model) ->
      @set 'selectedNode', model
      @sendAction 'selectAction', model

`export default ApJsonSchemaNodeTreeComponent`
