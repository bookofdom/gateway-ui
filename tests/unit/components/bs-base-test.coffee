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

test 'it has expected active class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains('active')
  Ember.run -> component.set 'active', true
  ok @$().attr('class').split(' ').contains('active')

test 'it has expected disabled class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains('disabled')
  Ember.run -> component.set 'disabled', true
  ok @$().attr('class').split(' ').contains('disabled')

test 'it has expected clearfix class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains('clearfix')
  Ember.run -> component.set 'clearfix', true
  ok @$().attr('class').split(' ').contains('clearfix')

test 'it has expected float class', ->
  expect 6
  component = @subject()
  ok !@$().attr('class').split(' ').contains('pull-left')
  ok !@$().attr('class').split(' ').contains('pull-right')
  Ember.run -> component.set 'left', true
  ok @$().attr('class').split(' ').contains('pull-left')
  ok !@$().attr('class').split(' ').contains('pull-right')
  Ember.run ->
    component.set 'left', false
    component.set 'right', true
  ok !@$().attr('class').split(' ').contains('pull-left')
  ok @$().attr('class').split(' ').contains('pull-right')

test 'it has expected text alignment class', ->
  expect 12
  component = @subject()
  ok !@$().attr('class').split(' ').contains('text-left')
  ok !@$().attr('class').split(' ').contains('text-right')
  ok !@$().attr('class').split(' ').contains('text-center')
  Ember.run -> component.set 'text-left', true
  ok @$().attr('class').split(' ').contains('text-left')
  ok !@$().attr('class').split(' ').contains('text-right')
  ok !@$().attr('class').split(' ').contains('text-center')
  Ember.run ->
    component.set 'text-left', false
    component.set 'text-right', true
  ok !@$().attr('class').split(' ').contains('text-left')
  ok @$().attr('class').split(' ').contains('text-right')
  ok !@$().attr('class').split(' ').contains('text-center')
  Ember.run ->
    component.set 'text-right', false
    component.set 'text-center', true
  ok !@$().attr('class').split(' ').contains('text-left')
  ok !@$().attr('class').split(' ').contains('text-right')
  ok @$().attr('class').split(' ').contains('text-center')

test 'it has expected text transform class', ->
  expect 12
  component = @subject()
  ok !@$().attr('class').split(' ').contains('text-uppercase')
  ok !@$().attr('class').split(' ').contains('text-lowercase')
  ok !@$().attr('class').split(' ').contains('text-capitalize')
  Ember.run -> component.set 'uppercase', true
  ok @$().attr('class').split(' ').contains('text-uppercase')
  ok !@$().attr('class').split(' ').contains('text-lowercase')
  ok !@$().attr('class').split(' ').contains('text-capitalize')
  Ember.run ->
    component.set 'uppercase', false
    component.set 'lowercase', true
  ok !@$().attr('class').split(' ').contains('text-uppercase')
  ok @$().attr('class').split(' ').contains('text-lowercase')
  ok !@$().attr('class').split(' ').contains('text-capitalize')
  Ember.run ->
    component.set 'lowercase', false
    component.set 'capitalize', true
  ok !@$().attr('class').split(' ').contains('text-uppercase')
  ok !@$().attr('class').split(' ').contains('text-lowercase')
  ok @$().attr('class').split(' ').contains('text-capitalize')

test 'it has expected text context style class', ->
  expect 12
  component = @subject()
  ok !@$().attr('class').split(' ').contains('text-muted')
  Ember.run -> component.set 'text-muted', true
  ok @$().attr('class').split(' ').contains('text-muted')
  Ember.run ->
    component.set 'text-muted', false
    component.set 'text-primary', true
  ok !@$().attr('class').split(' ').contains('text-muted')
  ok @$().attr('class').split(' ').contains('text-primary')
  Ember.run ->
    component.set 'text-primary', false
    component.set 'text-success', true
  ok !@$().attr('class').split(' ').contains('text-primary')
  ok @$().attr('class').split(' ').contains('text-success')
  Ember.run ->
    component.set 'text-success', false
    component.set 'text-info', true
  ok !@$().attr('class').split(' ').contains('text-success')
  ok @$().attr('class').split(' ').contains('text-info')
  Ember.run ->
    component.set 'text-info', false
    component.set 'text-warning', true
  ok !@$().attr('class').split(' ').contains('text-info')
  ok @$().attr('class').split(' ').contains('text-warning')
  Ember.run ->
    component.set 'text-warning', false
    component.set 'text-danger', true
  ok !@$().attr('class').split(' ').contains('text-warning')
  ok @$().attr('class').split(' ').contains('text-danger')

test 'it has expected bg context style class', ->
  expect 10
  component = @subject()
  ok !@$().attr('class').split(' ').contains('bg-primary')
  Ember.run -> component.set 'bg-primary', true
  ok @$().attr('class').split(' ').contains('bg-primary')
  Ember.run ->
    component.set 'bg-primary', false
    component.set 'bg-success', true
  ok !@$().attr('class').split(' ').contains('bg-primary')
  ok @$().attr('class').split(' ').contains('bg-success')
  Ember.run ->
    component.set 'bg-success', false
    component.set 'bg-info', true
  ok !@$().attr('class').split(' ').contains('bg-success')
  ok @$().attr('class').split(' ').contains('bg-info')
  Ember.run ->
    component.set 'bg-info', false
    component.set 'bg-warning', true
  ok !@$().attr('class').split(' ').contains('bg-info')
  ok @$().attr('class').split(' ').contains('bg-warning')
  Ember.run ->
    component.set 'bg-warning', false
    component.set 'bg-danger', true
  ok !@$().attr('class').split(' ').contains('bg-warning')
  ok @$().attr('class').split(' ').contains('bg-danger')

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
