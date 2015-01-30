`import Ember from 'ember'`
`import BsPanelComponent from 'gateway/components/bs-panel'`
`import t from 'gateway/helpers/i18n'`

ApPanelNewComponent = BsPanelComponent.extend
  classNames: ['ap-panel-new']
  collapse: false
  open: true
  style: 'success'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t 'actions.new-x', x: translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApPanelNewComponent`
