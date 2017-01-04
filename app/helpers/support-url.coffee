`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

supportUrl = (params) ->
  config.supportUrl

SupportUrlHelper = Ember.Helper.helper supportUrl

`export { supportUrl }`

`export default SupportUrlHelper`
