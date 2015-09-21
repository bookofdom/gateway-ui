`import Ember from 'ember'`

literalTag = (params) ->
  "&lt;#{params[0]}&gt;".htmlSafe()

LiteralTagHelper = Ember.Helper.helper literalTag

`export { literalTag }`

`export default LiteralTagHelper`
