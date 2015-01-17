`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-h1', 'BsH1Component', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/bs-text']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it renders an h1 tag', ->
  expect 1
  component = @subject()
  equal @$().prop('tagName').toLowerCase(), 'h1'
