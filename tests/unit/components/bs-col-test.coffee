`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-col', 'BsColComponent', {
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

test 'it has expected default classes', ->
  expect 208
  component = @subject()
  sizes = component.get 'sizes'
  widths = [0..12]
  for size in sizes
    for width in widths
      ok !@$().attr('class').split(' ').contains("col-#{size}-#{width}")
      ok !@$().attr('class').split(' ').contains("col-#{size}-offset-#{width}")
      ok !@$().attr('class').split(' ').contains("col-#{size}-push-#{width}")
      ok !@$().attr('class').split(' ').contains("col-#{size}-pull-#{width}")

test 'it has expected size classes', ->
  expect 4
  component = @subject()
  Ember.run ->
    component.setProperties
      xs: 12
      sm: 9
      md: 6
      lg: 3
  ok @$().attr('class').split(' ').contains('col-xs-12')
  ok @$().attr('class').split(' ').contains('col-sm-9')
  ok @$().attr('class').split(' ').contains('col-md-6')
  ok @$().attr('class').split(' ').contains('col-lg-3')

test 'it has expected offset classes', ->
  expect 4
  component = @subject()
  Ember.run ->
    component.setProperties
      'xs-offset': 12
      'sm-offset': 9
      'md-offset': 6
      'lg-offset': 3
  ok @$().attr('class').split(' ').contains('col-xs-offset-12')
  ok @$().attr('class').split(' ').contains('col-sm-offset-9')
  ok @$().attr('class').split(' ').contains('col-md-offset-6')
  ok @$().attr('class').split(' ').contains('col-lg-offset-3')

test 'it has expected push classes', ->
  expect 4
  component = @subject()
  Ember.run ->
    component.setProperties
      'xs-push': 12
      'sm-push': 9
      'md-push': 6
      'lg-push': 3
  ok @$().attr('class').split(' ').contains('col-xs-push-12')
  ok @$().attr('class').split(' ').contains('col-sm-push-9')
  ok @$().attr('class').split(' ').contains('col-md-push-6')
  ok @$().attr('class').split(' ').contains('col-lg-push-3')

test 'it has expected pull classes', ->
  expect 4
  component = @subject()
  Ember.run ->
    component.setProperties
      'xs-pull': 12
      'sm-pull': 9
      'md-pull': 6
      'lg-pull': 3
  ok @$().attr('class').split(' ').contains('col-xs-pull-12')
  ok @$().attr('class').split(' ').contains('col-sm-pull-9')
  ok @$().attr('class').split(' ').contains('col-md-pull-6')
  ok @$().attr('class').split(' ').contains('col-lg-pull-3')
