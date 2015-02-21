`import DS from 'ember-data'`
`import Model from './model'`

Environment = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  api: DS.belongsTo 'api', async: true
  variables: DS.hasMany 'environment-variable'
  # manually manage relationship dirty
  variablesDirty: Ember.computed 'variables.@each.isDirty', ->
    @get('variables').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'variablesDirty', -> @get('variablesDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

`export default Environment`
