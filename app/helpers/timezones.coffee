`import Ember from 'ember'`

zones = [
  name: 'UTC−12:00, Y'
  value: -12
,
  name: 'UTC−11:00, X'
  value: -11
,
  name: 'UTC−10:00, W'
  value: -10
,
  name: 'UTC−09:00, V'
  value: -9
,
  name: 'UTC−08:00, U'
  value: -8
,
  name: 'UTC−07:00, T'
  value: -7
,
  name: 'UTC−06:00, S'
  value: -6
,
  name: 'UTC−05:00, R'
  value: -5
,
  name: 'UTC−04:00, Q'
  value: -4
,
  name: 'UTC−03:00, P'
  value: -3
,
  name: 'UTC−02:00, O'
  value: -2
,
  name: 'UTC−01:00, N'
  value: -1
,
  name: 'UTC±00:00, Z'
  value: 0
,
  name: 'UTC+01:00, A'
  value: 1
,
  name: 'UTC+02:00, B'
  value: 2
,
  name: 'UTC+03:00, C'
  value: 3
,
  name: 'UTC+04:00, D'
  value: 4
,
  name: 'UTC+05:00, E'
  value: 5
,
  name: 'UTC+06:00, F'
  value: 6
,
  name: 'UTC+07:00, G'
  value: 7
,
  name: 'UTC+08:00, H'
  value: 8
,
  name: 'UTC+09:00, I'
  value: 9
,
  name: 'UTC+10:00, K'
  value: 10
,
  name: 'UTC+11:00, L'
  value: 11
,
  name: 'UTC+12:00, M'
  value: 12
]

timezones = ->
  zones

TimezonesHelper = Ember.Helper.helper timezones

`export { timezones }`

`export default TimezonesHelper`
