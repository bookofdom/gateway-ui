`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

brandName = (params) ->
  brandNames = config.brandNames
  name = params[0]
  brandNames[name] or ''

BrandNameHelper = Ember.Helper.helper brandName

`export { brandName }`

`export default BrandNameHelper`
