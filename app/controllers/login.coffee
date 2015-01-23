`import Ember from 'ember'`
`import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin'`
`import config from  '../config/environment'`

LoginController = Ember.Controller.extend LoginControllerMixin,
  authenticator: config['simple-auth'].authenticator

`export default LoginController`
