`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import t from 'gateway-ui/helpers/i18n'`

CustomFunction = Model.extend
  name: DS.attr 'string'
  language: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'
  memory: DS.attr 'number', defaultValue: 4
  cpu_shares: DS.attr 'number', defaultValue: 2

  # Relationships
  api: DS.belongsTo 'api', async: true
  files: DS.hasMany 'custom-function-file', async: true
  tests: DS.hasMany 'custom-function-test', async: true

languages = 'java node csharp python php'.split(' ').map (language) ->
  name: t "types.language.#{language}"
  slug: language
  value: language

CustomFunction.reopenClass
  languages: languages

`export default CustomFunction`
