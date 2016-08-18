`import Ember from 'ember'`
`import config from  'gateway/config/environment'`

docsUrl = (params) ->
  docsBaseUrl = config.docsBaseUrl
  path = params[0]
  if path
    "#{docsBaseUrl}/#{path}"
  else
    docsBaseUrl

DocsUrlHelper = Ember.Helper.helper docsUrl

`export { docsUrl }`

`export default DocsUrlHelper`
