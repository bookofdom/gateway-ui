`import Ember from 'ember'`

literalTag = (value, opening) ->
  "&lt;#{value}&gt;".htmlSafe()

LiteralTagHelper = Ember.Handlebars.makeBoundHelper literalTag

`export { literalTag }`

`export default LiteralTagHelper`
