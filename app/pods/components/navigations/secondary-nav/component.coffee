`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

NavigationssSecondaryNavComponent = Ember.Component.extend
  showCustomFunctions: Ember.computed ->
    if config.remote_endpoint_types_enabled?
      'custom_function' in config.remote_endpoint_types_enabled.split ','
    else
      true

`export default NavigationssSecondaryNavComponent`
