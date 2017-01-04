`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

termsUrl = (params) ->
  config.termsUrl

TermsUrlHelper = Ember.Helper.helper termsUrl

`export { termsUrl }`

`export default TermsUrlHelper`
