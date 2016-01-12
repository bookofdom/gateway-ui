I18nHelper = (args, options) ->
  value = args[0]
  i18n.t(value, options).capitalize()

`export default I18nHelper`
