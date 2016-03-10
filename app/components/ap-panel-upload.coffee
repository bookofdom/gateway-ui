`import Ember from 'ember'`
`import BsPanelComponent from 'gateway/components/bs-panel'`
`import t from 'gateway/helpers/i18n'`

ApPanelUploadComponent = BsPanelComponent.extend
  tagName: 'label'
  classNames: ['ap-panel-upload text-center']
  classNameBindings: ['isSet:active']
  value: null
  style: 'drop'
  t: 'actions.drop-or-click-to-upload'
  text: Ember.computed 't', 'isSet', ->
    translationKey = @get 't'
    if translationKey
      rendered = t translationKey
      rendered = "#{rendered}&hellip;" if !@get 'isSet'
      rendered.htmlSafe()
  isSet: Ember.computed 'value', -> !!@get('value')?.match /^data/
  'icon-after': true
  icon: Ember.computed 'isSet', ->
    'the-essentials-102' if @get 'isSet'
  readFiles: (files) ->
    if files.length
      file = files[0]
      @get('fileReaderService').readToDataURI(file).then (dataURI) =>
        @set 'value', dataURI if dataURI
  change: (e) ->
    @readFiles e.target.files
  dragOver: (e) ->
    false
  dragEnd: ->
    false
  drop: (e) ->
    e.preventDefault()
    @readFiles e.dataTransfer.files
    false

`export default ApPanelUploadComponent`
