`import Ember from 'ember'`

InlineFormMixin = Ember.Mixin.create
  embedded: true
  inline: true
  horizontal: false
  'show-save': false
  'show-cancel': false
  'show-placeholders': true

`export default InlineFormMixin`
