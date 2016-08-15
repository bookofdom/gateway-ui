`import { Factory, faker } from 'ember-cli-mirage'`

PlanFactory = Factory.extend
  name: (i) ->
    if !i
      'Free'
    else
      "Plan #{i}"
  stripe_name: (i) -> "plan-#{i}"
  max_users: -> faker.random.number()
  javascript_timeout: -> faker.random.number()
  price: (i) -> i * 20

`export default PlanFactory`
