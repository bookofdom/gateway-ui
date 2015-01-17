`import { literalTag } from 'gateway/helpers/literal-tag'`

module 'LiteralTagHelper'

# Replace this with your real tests.
test 'it works', ->
  result = literalTag 42
  ok result

test 'it renders a literal HTML tag', ->
  result = literalTag 'div class="my-class"'
  equal result, '&lt;div class="my-class"&gt;'
  result = literalTag '/div'
  equal result, '&lt;/div&gt;'
