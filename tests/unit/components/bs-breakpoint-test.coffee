`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-breakpoint', 'BsBreakpointComponent', {
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
  expect 25
  component = @subject()
  ok @$().attr('class').split(' ').contains('clearfix')
  ok !@$().attr('class').split(' ').contains('visible-xs-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'xs', true
  ok @$().attr('class').split(' ').contains('clearfix')
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'sm', true
  ok @$().attr('class').split(' ').contains('clearfix')
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'md', true
  ok @$().attr('class').split(' ').contains('clearfix')
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok @$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'lg', true
  ok @$().attr('class').split(' ').contains('clearfix')
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok @$().attr('class').split(' ').contains('visible-md-block')
  ok @$().attr('class').split(' ').contains('visible-lg-block')
