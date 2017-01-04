`import Ember from 'ember'`
`import BsBaseComponent from 'gateway-ui/pods/components/bs-base/component'`

ApJsonSchemaNodeTreeComponent = BsBaseComponent.extend
  tagName: 'ul'
  classNames: ['ap-json-schema-node-tree']

  selectAction: 'select'
  selectedNode: null

  model: null # should be root instance of json-schema-node

  defaultSelected: Ember.on 'init', ->
    @send 'select', @get('model')
  onModelChange: Ember.observer 'model', ->
    @send 'select', @get('model')

  actions:
    select: (model) ->
      @set 'selectedNode', model
      @sendAction 'selectAction', model
    delete: (model) ->
      selectedModel = @get 'selectedModel'
      @send 'select', null if model is selectedModel
      model.deleteRecord()
    new: (model) ->
      newChild = model.get('children').createRecord()
      @send 'select', newChild

`export default ApJsonSchemaNodeTreeComponent`
