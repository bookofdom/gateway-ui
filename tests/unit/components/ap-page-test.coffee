`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-page', 'ApPageComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['component:bs-container', 'component:bs-row', 'component:bs-col', 'component:bs-h1']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

# TODO
