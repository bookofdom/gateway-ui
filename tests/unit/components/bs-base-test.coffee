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
  ok !@$().is('.active')
  Ember.run -> component.set 'active', true
  ok @$().is('.active')

test 'it has expected disabled class', ->
  expect 2
  component = @subject()
  ok !@$().is('.disabled')
  Ember.run -> component.set 'disabled', true
  ok @$().is('.disabled')

test 'it has expected clearfix class', ->
  expect 2
  component = @subject()
  ok !@$().is('.clearfix')
  Ember.run -> component.set 'clearfix', true
  ok @$().is('.clearfix')

test 'it has expected float class', ->
  expect 6
  component = @subject()
  ok !@$().is('.pull-left')
  ok !@$().is('.pull-right')
  Ember.run -> component.set 'left', true
  ok @$().is('.pull-left')
  ok !@$().is('.pull-right')
  Ember.run ->
    component.set 'left', false
    component.set 'right', true
  ok !@$().is('.pull-left')
  ok @$().is('.pull-right')

test 'it has expected text alignment class', ->
  expect 12
  component = @subject()
  ok !@$().is('.text-left')
  ok !@$().is('.text-right')
  ok !@$().is('.text-center')
  Ember.run -> component.set 'text-left', true
  ok @$().is('.text-left')
  ok !@$().is('.text-right')
  ok !@$().is('.text-center')
  Ember.run ->
    component.set 'text-left', false
    component.set 'text-right', true
  ok !@$().is('.text-left')
  ok @$().is('.text-right')
  ok !@$().is('.text-center')
  Ember.run ->
    component.set 'text-right', false
    component.set 'text-center', true
  ok !@$().is('.text-left')
  ok !@$().is('.text-right')
  ok @$().is('.text-center')

test 'it has expected text transform class', ->
  expect 12
  component = @subject()
  ok !@$().is('.text-uppercase')
  ok !@$().is('.text-lowercase')
  ok !@$().is('.text-capitalize')
  Ember.run -> component.set 'uppercase', true
  ok @$().is('.text-uppercase')
  ok !@$().is('.text-lowercase')
  ok !@$().is('.text-capitalize')
  Ember.run ->
    component.set 'uppercase', false
    component.set 'lowercase', true
  ok !@$().is('.text-uppercase')
  ok @$().is('.text-lowercase')
  ok !@$().is('.text-capitalize')
  Ember.run ->
    component.set 'lowercase', false
    component.set 'capitalize', true
  ok !@$().is('.text-uppercase')
  ok !@$().is('.text-lowercase')
  ok @$().is('.text-capitalize')

test 'it has expected text context style class', ->
  expect 12
  component = @subject()
  ok !@$().is('.text-muted')
  Ember.run -> component.set 'text-muted', true
  ok @$().is('.text-muted')
  Ember.run ->
    component.set 'text-muted', false
    component.set 'text-primary', true
  ok !@$().is('.text-muted')
  ok @$().is('.text-primary')
  Ember.run ->
    component.set 'text-primary', false
    component.set 'text-success', true
  ok !@$().is('.text-primary')
  ok @$().is('.text-success')
  Ember.run ->
    component.set 'text-success', false
    component.set 'text-info', true
  ok !@$().is('.text-success')
  ok @$().is('.text-info')
  Ember.run ->
    component.set 'text-info', false
    component.set 'text-warning', true
  ok !@$().is('.text-info')
  ok @$().is('.text-warning')
  Ember.run ->
    component.set 'text-warning', false
    component.set 'text-danger', true
  ok !@$().is('.text-warning')
  ok @$().is('.text-danger')

test 'it has expected bg context style class', ->
  expect 10
  component = @subject()
  ok !@$().is('.bg-primary')
  Ember.run -> component.set 'bg-primary', true
  ok @$().is('.bg-primary')
  Ember.run ->
    component.set 'bg-primary', false
    component.set 'bg-success', true
  ok !@$().is('.bg-primary')
  ok @$().is('.bg-success')
  Ember.run ->
    component.set 'bg-success', false
    component.set 'bg-info', true
  ok !@$().is('.bg-success')
  ok @$().is('.bg-info')
  Ember.run ->
    component.set 'bg-info', false
    component.set 'bg-warning', true
  ok !@$().is('.bg-info')
  ok @$().is('.bg-warning')
  Ember.run ->
    component.set 'bg-warning', false
    component.set 'bg-danger', true
  ok !@$().is('.bg-warning')
  ok @$().is('.bg-danger')

test 'it has expected visibile-*-block classes', ->
  expect 20
  component = @subject()
  ok !@$().is('.visible-xs-block')
  ok !@$().is('.visible-sm-block')
  ok !@$().is('.visible-md-block')
  ok !@$().is('.visible-lg-block')
  Ember.run -> component.set 'visible-xs-block', true
  ok @$().is('.visible-xs-block')
  ok !@$().is('.visible-sm-block')
  ok !@$().is('.visible-md-block')
  ok !@$().is('.visible-lg-block')
  Ember.run -> component.set 'visible-sm-block', true
  ok @$().is('.visible-xs-block')
  ok @$().is('.visible-sm-block')
  ok !@$().is('.visible-md-block')
  ok !@$().is('.visible-lg-block')
  Ember.run -> component.set 'visible-md-block', true
  ok @$().is('.visible-xs-block')
  ok @$().is('.visible-sm-block')
  ok @$().is('.visible-md-block')
  ok !@$().is('.visible-lg-block')
  Ember.run -> component.set 'visible-lg-block', true
  ok @$().is('.visible-xs-block')
  ok @$().is('.visible-sm-block')
  ok @$().is('.visible-md-block')
  ok @$().is('.visible-lg-block')

test 'it has expected visibile-*-inline classes', ->
  expect 20
  component = @subject()
  ok !@$().is('.visible-xs-inline')
  ok !@$().is('.visible-sm-inline')
  ok !@$().is('.visible-md-inline')
  ok !@$().is('.visible-lg-inline')
  Ember.run -> component.set 'visible-xs-inline', true
  ok @$().is('.visible-xs-inline')
  ok !@$().is('.visible-sm-inline')
  ok !@$().is('.visible-md-inline')
  ok !@$().is('.visible-lg-inline')
  Ember.run -> component.set 'visible-sm-inline', true
  ok @$().is('.visible-xs-inline')
  ok @$().is('.visible-sm-inline')
  ok !@$().is('.visible-md-inline')
  ok !@$().is('.visible-lg-inline')
  Ember.run -> component.set 'visible-md-inline', true
  ok @$().is('.visible-xs-inline')
  ok @$().is('.visible-sm-inline')
  ok @$().is('.visible-md-inline')
  ok !@$().is('.visible-lg-inline')
  Ember.run -> component.set 'visible-lg-inline', true
  ok @$().is('.visible-xs-inline')
  ok @$().is('.visible-sm-inline')
  ok @$().is('.visible-md-inline')
  ok @$().is('.visible-lg-inline')

test 'it has expected visibile-*-inline-block classes', ->
  expect 20
  component = @subject()
  ok !@$().is('.visible-xs-inline-block')
  ok !@$().is('.visible-sm-inline-block')
  ok !@$().is('.visible-md-inline-block')
  ok !@$().is('.visible-lg-inline-block')
  Ember.run -> component.set 'visible-xs-inline-block', true
  ok @$().is('.visible-xs-inline-block')
  ok !@$().is('.visible-sm-inline-block')
  ok !@$().is('.visible-md-inline-block')
  ok !@$().is('.visible-lg-inline-block')
  Ember.run -> component.set 'visible-sm-inline-block', true
  ok @$().is('.visible-xs-inline-block')
  ok @$().is('.visible-sm-inline-block')
  ok !@$().is('.visible-md-inline-block')
  ok !@$().is('.visible-lg-inline-block')
  Ember.run -> component.set 'visible-md-inline-block', true
  ok @$().is('.visible-xs-inline-block')
  ok @$().is('.visible-sm-inline-block')
  ok @$().is('.visible-md-inline-block')
  ok !@$().is('.visible-lg-inline-block')
  Ember.run -> component.set 'visible-lg-inline-block', true
  ok @$().is('.visible-xs-inline-block')
  ok @$().is('.visible-sm-inline-block')
  ok @$().is('.visible-md-inline-block')
  ok @$().is('.visible-lg-inline-block')

test 'it has expected hidden classes', ->
  expect 20
  component = @subject()
  ok !@$().is('.hidden-xs')
  ok !@$().is('.hidden-sm')
  ok !@$().is('.hidden-md')
  ok !@$().is('.hidden-lg')
  Ember.run -> component.set 'hidden-xs', true
  ok @$().is('.hidden-xs')
  ok !@$().is('.hidden-sm')
  ok !@$().is('.hidden-md')
  ok !@$().is('.hidden-lg')
  Ember.run -> component.set 'hidden-sm', true
  ok @$().is('.hidden-xs')
  ok @$().is('.hidden-sm')
  ok !@$().is('.hidden-md')
  ok !@$().is('.hidden-lg')
  Ember.run -> component.set 'hidden-md', true
  ok @$().is('.hidden-xs')
  ok @$().is('.hidden-sm')
  ok @$().is('.hidden-md')
  ok !@$().is('.hidden-lg')
  Ember.run -> component.set 'hidden-lg', true
  ok @$().is('.hidden-xs')
  ok @$().is('.hidden-sm')
  ok @$().is('.hidden-md')
  ok @$().is('.hidden-lg')
