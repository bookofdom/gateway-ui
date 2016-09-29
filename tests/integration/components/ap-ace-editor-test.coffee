`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'ap-ace-editor', 'Integration | Component | ap ace editor', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 1

  # Template block usage:
  @render hbs """
    {{ap-ace-editor
      name='body'
      id='body'
      value='{"foo": "bar"}'
      readOnly=true
      size='lg'
      language='json'}}
  """

  # ACE editor palces this random string into the DOM.  It isn't displayed, but
  # it does indicate that the editor rendered.
  assert.equal @$().find('.ace_editor').length, 1
