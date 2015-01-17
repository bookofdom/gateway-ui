`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-table', 'BsTableComponent', {
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

test 'it renders the expected markup', ->
  expect 5
  component = @subject()
  equal @$().prop('tagName').toLowerCase(), 'div'
  ok @$().is('.table-responsive')
  equal @$().find('table.table').length, 1
  equal @$().find('thead').length, 1
  equal @$().find('tbody').length, 1

test 'it renders the specified headings', ->
  expect 2
  component = @subject()
  equal @$().find('thead th').length, 0
  Ember.run -> component.set 'headings', 'test,test,test'
  equal @$().find('thead th').length, 3
