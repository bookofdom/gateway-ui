`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'api', 'Unit | Model | api', {
  # Specify the other units that are required for this test.
  needs: [
    'model:custom-function'
    'model:endpoint-group'
    'model:environment'
    'model:host'
    'model:library'
    'model:proxy-endpoint'
    'model:job'
    'model:remote-endpoint'
    'model:shared-component'
  ]
}

test 'it exists', (assert) ->
  model = @subject()
  # store = @store()
  assert.ok !!model
