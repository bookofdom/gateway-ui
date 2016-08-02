`import Ember from 'ember'`
`import config from  'gateway/config/environment'`

supportUrl = (params) ->
  config.supportUrl

SupportUrlHelper = Ember.Helper.helper supportUrl

`export { supportUrl }`

`export default SupportUrlHelper`
