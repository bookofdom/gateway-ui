`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-button', 'BsButtonComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['template:components/bs-text']
}

test 'it renders', ->
  expect 2

  # creates the component instance
  component = @subject()
  equal component._state, 'preRender'

  # appends the component to the page
  @append()
  equal component._state, 'inDOM'

test 'it renders an a tag', ->
  expect 1
  component = @subject()
  equal @$().prop('tagName').toLowerCase(), 'a'

test 'it has a style class', ->
  expect 2
  component = @subject()
  ok @$().attr('class').split(' ').contains 'btn-primary'
  Ember.run -> component.set 'style', 'default'
  ok @$().attr('class').split(' ').contains 'btn-default'

test 'it may have a size class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains 'btn-sm'
  Ember.run -> component.set 'sm', true
  ok @$().attr('class').split(' ').contains 'btn-sm'

test 'it may have an active class', ->
  expect 2
  component = @subject()
  ok !@$().attr('class').split(' ').contains 'active'
  Ember.run -> component.set 'active', true
  ok @$().attr('class').split(' ').contains 'active'

test 'it triggers an action on click', ->
  expect 1
  component = @subject()
  targetObject =
    externalAction: ->
      ok true, 'external action was called'
  Ember.run ->
    component.set 'action', 'externalAction'
    component.set 'targetObject', targetObject
  @$().click()

test 'it does not triggers an action on click if none is specified', ->
  expect 0
  component = @subject()
  targetObject =
    externalAction: ->
      ok true, 'external action was called'
  Ember.run ->
    component.set 'targetObject', targetObject
  @$().click()

test 'it does not trigger an action on click if disabled', ->
  expect 0
  component = @subject()
  targetObject =
    externalAction: ->
      ok true, 'external action was called'
  Ember.run ->
    component.set 'action', 'externalAction'
    component.set 'targetObject', targetObject
    component.set 'disabled', true
  @$().click()
