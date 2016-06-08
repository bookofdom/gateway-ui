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
  name: 'placeholder-1'
  timestamp: (i) ->
    intervalBase = 1000 * 60 * 1 # 1m base interval
    intervalUncertainty = 1000 * 60 * 1 # +/- 1m interval randomness
    sign = Math.round(Math.random()) * 2 - 1 # -1 or 1
    noise = intervalUncertainty * Math.random() * sign
    new Date((i * intervalBase) + noise)
,
  name: 'placeholder-2'
  timestamp: (i) ->
    intervalBase = 1000 * 60 * 60 * 24 # 1d base interval
    intervalUncertainty = 1000 * 60 * 60 * 2 # +/- 2h interval randomness
    sign = Math.round(Math.random()) * 2 - 1 # -1 or 1
    noise = intervalUncertainty * Math.random() * sign
    new Date((i * intervalBase) + noise)
]

typeCycle = faker.list.cycle types...

StatFactory = Factory.extend
  values: ->
    'response.time': faker.random.number()
    'api.id': faker.random.number(4) + 1
    'proxy.id': faker.random.number(4) + 1
  type: (i) ->
    type = typeCycle i
    @time = type.timestamp i
    type.name

`export default StatFactory`
