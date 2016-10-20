`import { Factory, faker } from 'ember-cli-mirage'`

TimerFactory = Factory.extend
  name: (i) -> "timer-#{i}"
  next: -> Date.now() / 1000 + faker.random.number()
  api_id: -> (faker.random.number() % 3) + 1
  job_id: -> (faker.random.number() % 3) + 1

`export default TimerFactory`
