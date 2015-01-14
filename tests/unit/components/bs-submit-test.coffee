`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-submit', 'BsSubmitComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/bs-typography', 'template:components/bs-button']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it renders an button tag of type submit', ->
  expect 2
  component = @subject()
  equal @$().prop('tagName').toLowerCase(), 'button'
  equal @$().attr('type').toLowerCase(), 'submit'
