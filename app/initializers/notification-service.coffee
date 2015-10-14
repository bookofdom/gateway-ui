NotificationInitializer =
  name: 'notification-service'
  initialize: (container, app) ->
    app.inject 'route', 'notificationService', 'service:notification'

`export default NotificationInitializer`
