`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

CustomFunctionFile = Model.extend
  name: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  custom_function: DS.belongsTo 'custom-function', async: true

  language: Ember.computed 'name', ->
    name = @get('name') || ''
    parts = name.split('.')
    extension = if parts.length > 1 then parts[1] else parts[0]
    CustomFunctionFile.extensions[extension] || 'text'

extensions =
  cs: 'csharp'
  Dockerfile: 'dockerfile'
  java: 'java'
  js: 'javascript'
  json: 'json'
  php: 'php'
  py: 'python'

CustomFunctionFile.reopenClass
  extensions: extensions

`export default CustomFunctionFile`
