NotificationInitializer =
  name: 'notification-service'
  initialize: (app) ->
    app.inject 'route', 'notificationService', 'service:notification'

`export default NotificationInitializer`
