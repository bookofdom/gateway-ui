`import Ember from 'ember'`
`import BsButtonComponent from 'gateway/components/bs-button'`
`import t from 'gateway/helpers/i18n'`

ApButtonNewComponent = BsButtonComponent.extend
  classNames: ['ap-button-new']
  style: 'link'
  icon: 'the-essentials-010'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t 'actions.new-x', x: translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApButtonNewComponent`
