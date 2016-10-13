`import Ember from 'ember'`

zones = [
  name: 'UTC−05:00, EST'
  value: -5
,
  name: 'UTC−08:00, PST'
  value: -8
,
  name: 'UTC−06:00, CST'
  value: -6
,
  name: 'UTC−07:00, MST'
  value: -7
,
  name: 'UTC±00:00, UTC'
  value: 0
,
  name: 'UTC−12:00, BIT'
  value: -12
,
  name: 'UTC−11:00, SST'
  value: -11
,
  name: 'UTC−10:00, HAST'
  value: -10
,
  name: 'UTC−09:00, AKST'
  value: -9
,
  name: 'UTC−04:00, AST'
  value: -4
,
  name: 'UTC−03:00, ART'
  value: -3
,
  name: 'UTC−02:00, GST'
  value: -2
,
  name: 'UTC−01:00, EGT'
  value: -1
,
  name: 'UTC+01:00, CET'
  value: 1
,
  name: 'UTC+02:00, EET'
  value: 2
,
  name: 'UTC+03:00, MSK'
  value: 3
,
  name: 'UTC+04:00, GST'
  value: 4
,
  name: 'UTC+05:00, PKT'
  value: 5
,
  name: 'UTC+06:00, BST'
  value: 6
,
  name: 'UTC+07:00, THA'
  value: 7
,
  name: 'UTC+08:00, HKT'
  value: 8
,
  name: 'UTC+09:00, JST'
  value: 9
,
  name: 'UTC+10:00, AEST'
  value: 10
,
  name: 'UTC+11:00, SBT'
  value: 11
,
  name: 'UTC+12:00, NZST'
  value: 12
]

timezones = ->
  zones

TimezonesHelper = Ember.Helper.helper timezones

`export { timezones }`

`export default TimezonesHelper`
