`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from 'gateway-ui/config/environment'`

ApTableAutoIndexComponent = Ember.Component.extend
  notify: Ember.inject.service()
  classNames: ['ap-table-auto-index']

  classNameBindings: ['edit-route:table-edit', 'show-delete:table-delete', 'sortDirection']

  # Array of model instances.
  model: null

  # Array of field configurations.
  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ]

  # Route name for links.
  route: null

  'edit-route': null
  'show-delete': false

  # Filter fields
  filterGroups: Ember.computed 'model.[]', ->
    models = @get 'model'
    fields = @get 'fields'
    fields.map (field) ->
      Ember.Object.create
        field: field
        translate: (field.type == 't') or (field.type == 'status-label')
        isDatetime: field.type == 'datetime'
        values: models.uniqBy(field.name).mapBy(field.name)
        selection: null
        hasSelection: false
  filtered: Ember.computed 'model.[]', 'filterGroups.@each.selection', ->
    filterSelections = @get 'filterSelections'
    model = @get 'model'
    filterGroups = @get('filterGroups').filterBy('hasSelection')
    for group in filterGroups
      model = model.filterBy group.get('field.name'), group.get('selection')
    model

  # Sorted model instances.
  # Ideally one would use computed sort:
  # http://emberjs.com/api/classes/Ember.computed.html#method_sort
  # But it doesn't respond to additions or removals from
  # the underlaying list.
  sortDirection: 'asc'
  sortField: ''
  sorted: Ember.computed 'filtered.[]', 'sortField', 'sortDirection', ->
    models = @get 'filtered'
    sortField = @get 'sortField'
    sortDirection = @get 'sortDirection'
    sorted = models.filter (record) -> !record.get('isNew')
    if sortField
      sorted = sorted.sortBy sortField
      sorted = sorted.reverse() if sortDirection == 'desc'
    sorted

  delete: (model) ->
    model.destroyRecord().catch =>
      # notify user of errors
      model.get('errors').forEach (error) ->
        @get('notify').alert error.message
      # clear deleted state
      model.cancel()
      model.transitionTo 'loaded.saved'

  confirm: (text) ->
    if config.confirmDelete
      confirm text
    else
      true

  actions:
    delete: (model) ->
      confirmText = t('prompts.confirm-delete').capitalize()
      if @confirm confirmText
        @delete model

    toggleBoolean: (model, fieldName, autoSave) ->
      model.reload().then ->
        value = model.get fieldName
        model.set fieldName, !value
        model.save() if autoSave

    selectFilter: (field, value) ->
      @get 'filterGroups'
        .findBy 'field.name', field.name
        .setProperties
          selection: value
          hasSelection: true

    clearFilter: (field) ->
      @get 'filterGroups'
        .findBy 'field.name', field.name
        .setProperties
          selection: null
          hasSelection: false

    changeSort: (field) ->
      sortField = @get 'sortField'
      sortDirection = @get 'sortDirection'
      if field.name != sortField
        @setProperties
          sortDirection: 'asc'
          sortField: field.name
      else if sortDirection == 'desc'
        @set 'sortField', ''
      else
        @set 'sortDirection', 'desc'

`export default ApTableAutoIndexComponent`
