`import Ember from 'ember'`

second = 1000
minute = second * 60
hour = minute * 60
day = hour * 24
week = day * 7
month = week * 4
year = month * 12

timeHelper =

  seconds: (seconds) ->
    seconds * second

  minutes: (minutes) ->
    minutes * minute

  hours: (hours) ->
    hours * hour

  days: (days) ->
    days * day

  weeks: (weeks) ->
    weeks * week

  months: (months) ->
    months * month

  years: (years) ->
    years * year

TimeHelper = Ember.Helper.helper timeHelper

`export { timeHelper }`

`export default TimeHelper`
