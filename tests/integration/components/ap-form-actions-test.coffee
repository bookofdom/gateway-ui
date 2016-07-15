`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-form-actions', 'Integration | Component | ap form actions', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 8

  @render hbs """{{ap-form-actions}}"""
  assert.equal @$().find('button').size(), 1
  assert.equal @$().find('a').size(), 2
  assert.ok @$().find('button').is ':not(.invisible)'
  assert.ok @$().find('a:eq(0)').is '.invisible'
  assert.ok @$().find('a:eq(1)').is '.invisible'

  @render hbs """{{ap-form-actions show-save=false}}"""
  assert.ok @$().find('button').is '.invisible'

  @render hbs """{{ap-form-actions show-cancel=true}}"""
  assert.ok @$().find('a:eq(0)').is ':not(.invisible)'

  @render hbs """{{ap-form-actions show-delete=true}}"""
  assert.ok @$().find('a:eq(1)').is ':not(.invisible)'
