`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'bs-button', 'Integration | Component | bs button', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 9

  @render hbs """{{bs-button}}"""
  assert.equal @$().find('[target]').length, 0, 'has target only if url is set'

  @render hbs """{{bs-button url='http://www.example.net'}}"""
  assert.equal @$().find('.btn[href="http://www.example.net"]').length, 1
  assert.equal @$().find('[target]').length, 1, 'has target only if url is set'

  @render hbs """{{bs-button xs=true}}"""
  assert.equal @$().find('.btn-xs').length, 1
  @render hbs """{{bs-button sm=true}}"""
  assert.equal @$().find('.btn-sm').length, 1
  @render hbs """{{bs-button lg=true}}"""
  assert.equal @$().find('.btn-lg').length, 1

  @render hbs """{{bs-button block=true}}"""
  assert.equal @$().find('.btn-block').length, 1

  @render hbs """{{bs-button}}"""
  assert.equal @$().find('.btn-primary').length, 1
  @render hbs """{{bs-button style='info'}}"""
  assert.equal @$().find('.btn-info').length, 1
