`import Ember from 'ember'`
`import BsPanelComponent from 'gateway/pods/components/bs-panel/component'`
`import t from 'gateway/helpers/i18n'`

ApPanelNewComponent = BsPanelComponent.extend
  classNames: ['ap-panel-new']
  collapse: true
  style: 'success'
  icon: 'the-essentials-010'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t 'actions.new-x', x: translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApPanelNewComponent`
