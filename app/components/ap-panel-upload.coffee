`import Ember from 'ember'`
`import BsPanelComponent from 'gateway/components/bs-panel'`
`import t from 'gateway/helpers/i18n'`

ApPanelUploadComponent = BsPanelComponent.extend
  classNames: ['ap-panel-upload']
  style: 'drop'
  'text-center': true
  t: 'actions.drop-or-click-to-upload'
  text: Ember.computed 't', ->
    translationKey = @get 't'
    if translationKey
      rendered = t translationKey
      "#{rendered}&hellip;".htmlSafe()

`export default ApPanelUploadComponent`
