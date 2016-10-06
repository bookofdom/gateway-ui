`import { Factory, faker } from 'ember-cli-mirage'`

types = [
  name: 'response-time'
  timestamp: (i) ->
    intervalBase = 10000 # 10s base interval
    intervalUncertainty = 5000 # +/- 5s interval randomness
    sign = Math.round(Math.random()) * 2 - 1 # -1 or 1
    noise = intervalUncertainty * Math.random() * sign
    new Date((i * intervalBase) + noise)
,
  name: 'average-speed'
  timestamp: (i) ->
    intervalBase = 1000 * 60 * 1 # 1m base interval
    intervalUncertainty = 5000 # +/- 5s interval randomness
    sign = Math.round(Math.random()) * 2 - 1 # -1 or 1
    noise = intervalUncertainty * Math.random() * sign
    new Date((i * intervalBase) + noise)
]

typeCycle = faker.list.cycle types...

StatFactory = Factory.extend
  values: ->
    'response.time': faker.random.number()
    'average.speed': faker.random.number(2) + 1
  type: (i) ->
    type = typeCycle i
    type.name

`export default StatFactory`
