`import Ember from 'ember'`

slugify = (value) ->
  value.toString().toLowerCase()
    .replace /\s+/g, '-'           # Replace spaces with -
    .replace /[^\w\-]+/g, ''       # Remove all non-word chars
    .replace /\-\-+/g, '-'         # Replace multiple - with single -
    .replace /^-+/, ''             # Trim - from start of text
    .replace /-+$/, ''            # Trim - from end of text

SlugifyHelper = Ember.Handlebars.makeBoundHelper slugify

`export { slugify }`

`export default SlugifyHelper`
