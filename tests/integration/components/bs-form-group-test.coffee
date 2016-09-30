`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'bs-form-group', 'Integration | Component | bs form group', {
  integration: true
}

test 'it renders', (assert) ->
  #assert.expect 1

  @render hbs """{{#bs-form-group}}{{/bs-form-group}}"""
  assert.equal @$().find('.form-group').length, 1
  assert.equal @$().find('.form-group.has-error').length, 0

  @render hbs """{{#bs-form-group error=true}}{{/bs-form-group}}"""
  assert.equal @$().find('.form-group').length, 1
  assert.equal @$().find('.form-group.has-error').length, 1
