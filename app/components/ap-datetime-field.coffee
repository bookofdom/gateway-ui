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
      locale: i18n.lng()
      icons:
        time: 'retina-the-essentials-006',
        date: 'retina-the-essentials-145',
        up: 'retina-arrows-008',
        down: 'retina-arrows-007',
        previous: 'retina-arrows-005',
        next: 'retina-arrows-006',
        today: 'retina-the-essentials-145',
        clear: 'retina-the-essentials-011',
        close: 'retina-the-essentials-024'

`export default ApDatetimeFieldComponent`
