`import Ember from 'ember'`

I18nInitializer =
  name: 'i18n'
  initialize: (container, app) ->
    app.deferReadiness()
    i18n.init
      getAsync: false
      detectLngQS: 'locale'
      fallbackLng: 'en'
    ,
      ->
        locale = i18n.lng()
        moment.locale locale
        app.advanceReadiness()

`export default I18nInitializer`
