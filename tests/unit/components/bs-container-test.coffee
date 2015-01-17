`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-container', 'BsContainerComponent', {
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

test 'it has expected classes', ->
  expect 4
  component = @subject()
  ok !@$().is('.container')
  ok @$().is('.container-fluid')
  Ember.run -> component.set 'fluid', false
  ok @$().is('.container')
  ok !@$().is('.container-fluid')
