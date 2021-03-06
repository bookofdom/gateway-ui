`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

CustomFunction = Model.extend
  name: DS.attr 'string'
  language: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'
  memory: DS.attr 'number', defaultValue: 8
  cpu_shares: DS.attr 'number', defaultValue: 0
  timeout: DS.attr 'number', defaultValue: 60

  # Relationships
  api: DS.belongsTo 'api', async: true
  files: DS.hasMany 'custom-function-file', async: true
  tests: DS.hasMany 'custom-function-test', async: true

languages = 'other java node csharp python php'.split(' ').map (language) ->
  nameKey: "types.language.#{language}"
  slug: language
  value: language

CustomFunction.reopenClass
  languages: languages

`export default CustomFunction`
