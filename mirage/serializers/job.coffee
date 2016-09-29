`import ApplicationSerializer from 'gateway/mirage/serializers/application'`

JobSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = ApplicationSerializer.prototype.serialize.apply @, arguments
    components = model.job_components.map (ed) ->
      ed.attrs.job_component_reference_id = ed.attrs.id
      ed.attrs
    serialized.components = components if !serialized.components
    serialized

`export default JobSerializer`
