`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-list-link', 'BsListLinkComponent', {
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

test 'it renders expected markup', ->
  expect 2
  component = @subject()
  equal @$().prop('tagName').toLowerCase(), 'li'
  equal @$().find('a').length, 1

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

test 'it does not trigger an action on click if none is specified', ->
  expect 0
  component = @subject()
  targetObject =
    externalAction: ->
      ok true, 'external action was called'
  Ember.run ->
    component.set 'targetObject', targetObject
  @$().click()

