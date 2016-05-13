`import Ember from 'ember'`

PrimaryView = Ember.View.extend
  layoutName: 'layouts/primary'
  classNameBindings: ['solid:ap-app-primary-leaf'],
  leaf: true

`export default PrimaryView`
