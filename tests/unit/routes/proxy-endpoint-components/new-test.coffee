`import { test, moduleFor } from 'ember-qunit'`

moduleFor 'route:proxy-endpoint-components/new', 'ProxyEndpointComponentsNewRoute', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', ->
  route = @subject()
  ok route
