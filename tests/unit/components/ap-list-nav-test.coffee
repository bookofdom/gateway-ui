`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-list-nav', 'ApListNavComponent', {
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

test 'it renders an inline class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'inline', true
  ok @$().is '.list-inline'

test 'it renders a circle class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'circle', true
  ok @$().is '.ap-list-nav-circle'

test 'it renders a secondary-hover class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'secondary-hover', true
  ok @$().is '.ap-list-nav-secondary-hover'

test 'it renders a secondary-hover class', ->
  expect 2
  component = @subject()
  ok !@$().is '.ap-list-nav-hide-text'
  Ember.run -> component.set 'show-text', false
  ok @$().is '.ap-list-nav-hide-text'
