`import { Factory, faker } from 'ember-cli-mirage'`

StatFactory = Factory.extend
  timestamp: (i) ->
    intervalBase = 10000 # 10s base interval
    intervalUncertainty = 5000 # +/- 5s interval randomness
    sign = Math.round(Math.random()) * 2 - 1 # -1 or 1
    noise = intervalUncertainty * Math.random() * sign
    JSON.stringify new Date((i * intervalBase) + noise)
  values: ->
    'response.time': faker.random.number()

`export default StatFactory`
