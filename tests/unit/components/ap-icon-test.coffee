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

test 'it renders size classes', ->
  expect 11
  component = @subject()
  ok !@$().is '.ap-icon-xs'
  ok !@$().is '.ap-icon-sm'
  ok !@$().is '.ap-icon-lg'
  ok !@$().is '.ap-icon-xl'
  Ember.run -> component.set 'xs', true
  ok @$().is '.ap-icon-xs'
  Ember.run ->
    component.set 'xs', false
    component.set 'sm', true
  ok !@$().is '.ap-icon-xs'
  ok @$().is '.ap-icon-sm'
  Ember.run ->
    component.set 'sm', false
    component.set 'lg', true
  ok !@$().is '.ap-icon-sm'
  ok @$().is '.ap-icon-lg'
  Ember.run ->
    component.set 'lg', false
    component.set 'xl', true
  ok !@$().is '.ap-icon-lg'
  ok @$().is '.ap-icon-xl'
