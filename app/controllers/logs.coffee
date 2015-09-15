`import Ember from 'ember'`

LogsController = Ember.Controller.extend
  breadCrumb: 'resources.log_plural'
  queryParams: ['query', 'start', 'end', 'limit']

`export default LogsController`
