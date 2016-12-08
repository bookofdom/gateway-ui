`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`
`import config from  'gateway/config/environment'`

Info = Model.extend
  # app
  version: DS.attr 'string'

  # Computed properties
  isApp: Ember.computed 'id', -> @get('id') is 'app'
  isSameAppVersion: Ember.computed.equal 'version', config.version
  isDifferentAppVersion: Ember.computed.not 'isSameAppVersion'

`export default Info`
