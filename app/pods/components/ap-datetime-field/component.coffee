`import Ember from 'ember'`

ApDatetimeFieldComponent = Ember.Component.extend
  classNames: ['ap-datetime']

  name: null
  idName: null
  placeholder: null
  required: false

  value: null

  setup: Ember.on 'didInsertElement', ->
    @$('input').datetimepicker
      keepOpen: true
      format: 'YYYY-MM-DDTHH:mm:ss\\Z'
      #locale: i18n.lng()
      icons:
        time: 'gateway-icon gateway-the-essentials-006',
        date: 'gateway-icon gateway-the-essentials-145',
        up: 'gateway-icon gateway-arrows-008',
        down: 'gateway-icon gateway-arrows-007',
        previous: 'gateway-icon gateway-arrows-005',
        next: 'gateway-icon gateway-arrows-006',
        today: 'gateway-icon gateway-the-essentials-145',
        clear: 'gateway-icon gateway-the-essentials-011',
        close: 'gateway-icon gateway-the-essentials-024'

`export default ApDatetimeFieldComponent`
