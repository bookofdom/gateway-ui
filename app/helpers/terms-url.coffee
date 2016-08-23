`import Ember from 'ember'`
`import config from  'gateway/config/environment'`

termsUrl = (params) ->
  config.termsUrl

TermsUrlHelper = Ember.Helper.helper termsUrl

`export { termsUrl }`

`export default TermsUrlHelper`
