/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'gateway',
    podModulePrefix: 'gateway/pods',
    environment: environment,
    rootURL: '/',
    locationType: 'auto',
    'simple-auth': {
      authenticationRoute: 'login',
      routeAfterAuthentication: 'index',
    },
    EmberENV: {
      FEATURES: {}
    },

    APP: {
      notifications: false,
      mockNotifications: false,
      mockNotificationInterval: 20 * 1000, // 20 seconds
      mockLogs: false,
      mockLogInterval: 5 * 1000, // 5 seconds
      logHeartbeatInterval: 60 // (in seconds)
    },

    contentSecurityPolicy: {
      'default-src': "'self'",
      'script-src': "'self'",
      'font-src': "'self' *",
      'connect-src': "'self' localhost:5000",
      'img-src': "'self' *",
      'style-src': "'self' 'unsafe-inline'"
    },

    confirmDelete: true,
    registration_enabled: true, // expose the user registration UI?

    version: null,
    dev_mode: false,
    go_os: null,
    remote_endpoint_types_enabled: null,

    docsBaseUrl: 'http://devhub.nanoscale.io/docs',
    supportUrl: 'http://support.nanoscale.io',
    termsUrl: 'http://www.nanoscale.io/terms/',
    brandNames: {
      primary: 'nanoscale.io'
    },

    api: {
      host: '',
      basePath: 'admin',
      swaggerViewerPath: null,
      swaggerJsonPath: null,
      logs: {
        host: ''
      },
      authentication: {
        path: 'sessions'
      }
    },

    enablePlanSubscriptions: true,
    stripe: {
      publishableKey: 'pk_test_6pRNASCoBOKtIshFeQd4XMUh'
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.api.swaggerViewerPath = '/swagger';
    ENV.api.swaggerJsonPath = '/swagger';

    ENV.go_os = 'darwin';
    ENV.APP.notifications = true;
    ENV.APP.mockNotifications = true;
    ENV.APP.mockLogs = true;

    // uncomment for stand-alone gateway API
    //ENV.api.host = 'http://localhost:5000';
    //ENV['ember-cli-mirage'] = {enabled: false};
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.rootURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';

    ENV.confirmDelete = false;
  }

  if (environment === 'production') {
    // interpolated config
    ENV.api.host = 'ADMIN_API_HOST';
    ENV.registration_enabled = 'REGISTRATION_ENABLED';
    ENV.version = 'VERSION';
    ENV.dev_mode = 'DEV_MODE';
    ENV.go_os = 'GO_OS';
    ENV.remote_endpoint_types_enabled = 'REMOTE_ENDPOINT_TYPES_ENABLED';
    ENV.api_base_path_placeholder = 'API_BASE_PATH_PLACEHOLDER';
    ENV.broker_placeholder = 'BROKER_PLACEHOLDER';
    ENV.logHeartbeatInterval = 'WS_HEARTBEAT_INTERVAL';
    ENV.google_analytics_tracking_id = 'GOOGLE_ANALYTICS_TRACKING_ID';

    ENV.rootURL = null;
    ENV.locationType = 'hash';
    ENV.api.basePath = ENV.api_base_path_placeholder;
    ENV.api.logs.host = ENV.broker_placeholder;
    ENV.APP.notifications = true;
    ENV.googleAnalytics = {
      webPropertyId: ENV.google_analytics_tracking_id
    };
    ENV.enablePlanSubscriptions = 'ENABLE_PLAN_SUBSCRIPTIONS';
    ENV.stripe = {
      publishableKey: 'STRIPE_PUBLISHABLE_KEY'
    };
  }

  ENV.api.url = [ENV.api.host, ENV.api.basePath].join('/');
  ENV.api.authentication.url = [ENV.api.host, ENV.api.basePath, ENV.api.authentication.path].join('/');
  ENV['simple-auth'].crossOriginWhitelist = [ENV.api.authentication.url];

  return ENV;
};
