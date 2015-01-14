`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-dropdown', 'BsDropdownComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/bs-typography']
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
  expect 3
  component = @subject()
  ok @$().is '.dropdown'
  equal @$().find('button.dropdown-toggle').length, 1
  equal @$().find('.dropdown-menu').length, 1
