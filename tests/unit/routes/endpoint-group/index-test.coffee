`import { test, moduleFor } from 'ember-qunit'`

moduleFor 'route:endpoint-group/index', 'EndpointGroupIndexRoute', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', ->
  route = @subject()
  ok route
