`import DS from 'ember-data'`
`import Model from './model'`

Environment = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  session_type: DS.attr 'string', defaultValue: 'client'
  session_header: DS.attr 'string', defaultValue: 'X-Session-Id'
  session_name: DS.attr 'string'
  session_auth_key: DS.attr 'string'
  session_encryption_key: DS.attr 'string'
  session_auth_key_rotate: DS.attr 'string'
  session_encryption_key_rotate: DS.attr 'string'
  show_javascript_errors: DS.attr 'boolean'

  # Relationships
  api: DS.belongsTo 'api', async: true
  variables: DS.hasMany 'environment-variable',
    async: false
    stains: true
    embedded: true

`export default Environment`
