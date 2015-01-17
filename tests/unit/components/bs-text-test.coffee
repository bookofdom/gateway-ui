`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent 'bs-text', 'BsTextComponent', {
  # specify the other units that are required for this test
  # needs: ['component:foo', 'helper:bar']
  needs: ['component:ap-icon']
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
  Ember.run -> component.set 't', 'anything'
  equal @$().find('span').length, 1
  Ember.run -> component.set 'icon', 'anything'
  equal @$().find('span').length, 2

test 'it respects show-text option', ->
  expect 1
  component = @subject()
  Ember.run ->
    component.set 'show-text', false
    component.set 't', 'anything'
  equal @$().find('.sr-only').length, 1

# TODO
# see tests/helpers/i18n-test.coffee
