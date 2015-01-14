`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-base', 'BsBaseComponent', {
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

test 'it has expected clearfix class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains('clearfix')
  Ember.run -> component.set 'clearfix', true
  ok @$().attr('class').split(' ').contains('clearfix')

test 'it has expected visibile-*-block classes', ->
  expect 20
  component = @subject()
  ok !@$().attr('class').split(' ').contains('visible-xs-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'visible-xs-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'visible-sm-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok !@$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'visible-md-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok @$().attr('class').split(' ').contains('visible-md-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-block')
  Ember.run -> component.set 'visible-lg-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-block')
  ok @$().attr('class').split(' ').contains('visible-sm-block')
  ok @$().attr('class').split(' ').contains('visible-md-block')
  ok @$().attr('class').split(' ').contains('visible-lg-block')

test 'it has expected visibile-*-inline classes', ->
  expect 20
  component = @subject()
  ok !@$().attr('class').split(' ').contains('visible-xs-inline')
  ok !@$().attr('class').split(' ').contains('visible-sm-inline')
  ok !@$().attr('class').split(' ').contains('visible-md-inline')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline')
  Ember.run -> component.set 'visible-xs-inline', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline')
  ok !@$().attr('class').split(' ').contains('visible-sm-inline')
  ok !@$().attr('class').split(' ').contains('visible-md-inline')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline')
  Ember.run -> component.set 'visible-sm-inline', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline')
  ok @$().attr('class').split(' ').contains('visible-sm-inline')
  ok !@$().attr('class').split(' ').contains('visible-md-inline')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline')
  Ember.run -> component.set 'visible-md-inline', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline')
  ok @$().attr('class').split(' ').contains('visible-sm-inline')
  ok @$().attr('class').split(' ').contains('visible-md-inline')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline')
  Ember.run -> component.set 'visible-lg-inline', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline')
  ok @$().attr('class').split(' ').contains('visible-sm-inline')
  ok @$().attr('class').split(' ').contains('visible-md-inline')
  ok @$().attr('class').split(' ').contains('visible-lg-inline')

test 'it has expected visibile-*-inline-block classes', ->
  expect 20
  component = @subject()
  ok !@$().attr('class').split(' ').contains('visible-xs-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-md-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline-block')
  Ember.run -> component.set 'visible-xs-inline-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-sm-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-md-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline-block')
  Ember.run -> component.set 'visible-sm-inline-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline-block')
  ok @$().attr('class').split(' ').contains('visible-sm-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-md-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline-block')
  Ember.run -> component.set 'visible-md-inline-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline-block')
  ok @$().attr('class').split(' ').contains('visible-sm-inline-block')
  ok @$().attr('class').split(' ').contains('visible-md-inline-block')
  ok !@$().attr('class').split(' ').contains('visible-lg-inline-block')
  Ember.run -> component.set 'visible-lg-inline-block', true
  ok @$().attr('class').split(' ').contains('visible-xs-inline-block')
  ok @$().attr('class').split(' ').contains('visible-sm-inline-block')
  ok @$().attr('class').split(' ').contains('visible-md-inline-block')
  ok @$().attr('class').split(' ').contains('visible-lg-inline-block')

test 'it has expected hidden classes', ->
  expect 20
  component = @subject()
  ok !@$().attr('class').split(' ').contains('hidden-xs')
  ok !@$().attr('class').split(' ').contains('hidden-sm')
  ok !@$().attr('class').split(' ').contains('hidden-md')
  ok !@$().attr('class').split(' ').contains('hidden-lg')
  Ember.run -> component.set 'hidden-xs', true
  ok @$().attr('class').split(' ').contains('hidden-xs')
  ok !@$().attr('class').split(' ').contains('hidden-sm')
  ok !@$().attr('class').split(' ').contains('hidden-md')
  ok !@$().attr('class').split(' ').contains('hidden-lg')
  Ember.run -> component.set 'hidden-sm', true
  ok @$().attr('class').split(' ').contains('hidden-xs')
  ok @$().attr('class').split(' ').contains('hidden-sm')
  ok !@$().attr('class').split(' ').contains('hidden-md')
  ok !@$().attr('class').split(' ').contains('hidden-lg')
  Ember.run -> component.set 'hidden-md', true
  ok @$().attr('class').split(' ').contains('hidden-xs')
  ok @$().attr('class').split(' ').contains('hidden-sm')
  ok @$().attr('class').split(' ').contains('hidden-md')
  ok !@$().attr('class').split(' ').contains('hidden-lg')
  Ember.run -> component.set 'hidden-lg', true
  ok @$().attr('class').split(' ').contains('hidden-xs')
  ok @$().attr('class').split(' ').contains('hidden-sm')
  ok @$().attr('class').split(' ').contains('hidden-md')
  ok @$().attr('class').split(' ').contains('hidden-lg')
