`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/components/bs-base'`

ApJsonSchemaEditorComponent = BsBaseComponent.extend
  classNames: ['ap-json-schema-node-edit-panel']
  selectedNode: null
  model: null # should be root instance of json-schema-node
  defaultSelected: Ember.on 'init', ->
    @trigger 'select', @get('model')
  actions:
    select: (model) ->
      @set 'selectedNode', model

`export default ApJsonSchemaEditorComponent`
