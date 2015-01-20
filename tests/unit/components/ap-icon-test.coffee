`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-icon', 'ApIconComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it renders expected markup', ->
  expect 2
  component = @subject()
  ok @$().is '.ap-icon'
  equal @$().find('i').length, 1

# TODO
