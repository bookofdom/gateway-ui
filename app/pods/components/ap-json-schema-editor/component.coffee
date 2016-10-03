`import Ember from 'ember'`
`import BsBaseComponent from 'gateway/pods/components/bs-base/component'`

ApJsonSchemaEditorComponent = BsBaseComponent.extend
  classNames: ['ap-json-schema-node-editor']
  selectedNode: null
  model: null # should be root instance of json-schema-node
  actions:
    select: (model) ->
      @set 'selectedNode', model

`export default ApJsonSchemaEditorComponent`
