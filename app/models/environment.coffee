`import DS from 'ember-data'`
`import Model from './model'`

Environment = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  session_name: DS.attr 'string'
  session_auth_key: DS.attr 'string'
  session_encryption_key: DS.attr 'string'
  session_auth_key_rotate: DS.attr 'string'
  session_encryption_key_rotate: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: true
  variables: DS.hasMany 'environment-variable', async: false

  # manually manage relationship dirty
  variablesDirty: Ember.computed 'variables.@each.hasDirtyAttributes', ->
    @get('variables').filterBy('hasDirtyAttributes', true).get('length')
  relationshipsDirty: Ember.computed 'variablesDirty', -> @get('variablesDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

`export default Environment`
