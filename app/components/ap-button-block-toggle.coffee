`import Ember from 'ember'`
`import ApButtonBlockComponent from 'gateway/components/ap-button-block'`
`import t from 'gateway/helpers/i18n'`

ApButtonBlockToggleComponent = ApButtonBlockComponent.extend
  classNames: ['ap-button-block-toggle']
  icon: 'arrows-047'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t 'actions.toggle-x', x: translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApButtonBlockToggleComponent`
