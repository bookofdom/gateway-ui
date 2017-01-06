`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`
`import config from  'gateway-ui/config/environment'`

Info = Model.extend
  # app
  version: DS.attr 'string'

  # Computed properties
  isApp: Ember.computed 'id', -> @get('id') is 'app'
  isSameAppVersion: Ember.computed.equal 'version', config.version
  isDifferentAppVersion: Ember.computed.not 'isSameAppVersion'

`export default Info`
