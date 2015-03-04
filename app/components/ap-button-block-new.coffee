`import Ember from 'ember'`
`import ApButtonBlockComponent from 'gateway/components/ap-button-block'`
`import t from 'gateway/helpers/i18n'`

ApButtonBlockNewComponent = ApButtonBlockComponent.extend
  classNames: ['ap-button-block-new']
  icon: 'the-essentials-010'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t 'actions.new-x', x: translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApButtonBlockNewComponent`
