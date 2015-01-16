`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'ap-list-link', 'ApListLinkComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/bs-list-link', 'template:components/bs-text']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it renders a circle class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'circle', true
  ok @$().is '.ap-list-link-circle'

test 'it renders a reversed class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'reversed', true
  ok @$().is '.ap-list-link-reversed'

test 'it renders a secondary-hover class', ->
  expect 1
  component = @subject()
  Ember.run -> component.set 'secondary-hover', true
  ok @$().is '.ap-list-link-secondary-hover'
