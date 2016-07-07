/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'gateway',
    podModulePrefix: 'gateway/pods',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    'simple-auth': {
      authenticationRoute: 'login',
      routeAfterAuthentication: 'index',
    },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
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
    notifications: false,

    api: {
      host: process.env.API_HOST || '',
      basePath: 'admin',
      swaggerViewerPath: null,
      swaggerJsonPath: null,
      logs: {
        host: ''
      },
      authentication: {
        path: 'sessions'
      }
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
    //ENV.notifications = true;

    // uncomment for stand-alone gateway API
    //ENV.api.host = 'http://localhost:5000';
    //ENV['ember-cli-mirage'] = {enabled: false};
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';

    ENV.confirmDelete = false;
    ENV.notifications = false;
  }

  if (environment === 'production') {
    // Interpolated configuration variables are filled by the server.  The
    // server replaces UPPERCASE_VARS with a value if one exists.  In some
    // cases, variables with no value are left in-place.  Others are replaced
    // with the empty string.  Each interpolated config variable with a value is
    // copied to an ENV property, where config.key is the key and config.value
    // is the value.
    // For example, in {name: 'version', value: 'VERSION'} where the server
    // replaces VERSION with 1.2, an ENV property is created:
    // ENV.version = '1.2'.
    var interpolatedConfig = [
      {
        key: 'registration_enabled',
        value: 'REGISTRATION_ENABLED'
      },
      {
        key: 'version',
        value: 'VERSION'
      },
      {
        key: 'dev_mode',
        value: 'DEV_MODE'
      },
      {
        key: 'go_os',
        value: 'GO_OS'
      },
      {
        key: 'remote_endpoint_types_enabled',
        value: 'REMOTE_ENDPOINT_TYPES_ENABLED'
      },
      {
        key: 'api_base_path_placeholder',
        value: 'API_BASE_PATH_PLACEHOLDER'
      },
      {
        key: 'broker_placeholder',
        value: 'BROKER_PLACEHOLDER'
      },
      {
        key: 'google_analytics_tracking_id',
        value: 'GOOGLE_ANALYTICS_TRACKING_ID'
      }
    ];

    interpolatedConfig.forEach(function (config) {
      var uppercaseKey = config.key.toUpperCase();
      if (uppercaseKey !== config.value) {
        ENV[config.key] = config.value;
      }
    });

    ENV.baseURL = null;
    ENV.locationType = 'hash';
    if (ENV.api_base_path_placeholder) ENV.api.basePath = ENV.api_base_path_placeholder;
    if (ENV.broker_placeholder) ENV.api.logs.host = ENV.broker_placeholder;
    ENV.notifications = true;
    if (ENV.google_analytics_tracking_id) {
      ENV.googleAnalytics = {
        webPropertyId: ENV.google_analytics_tracking_id
      };
    }
  }

  ENV.api.url = [ENV.api.host, ENV.api.basePath].join('/');
  ENV.api.authentication.url = [ENV.api.host, ENV.api.basePath, ENV.api.authentication.path].join('/');
  ENV['simple-auth'].crossOriginWhitelist = [ENV.api.authentication.url];

  return ENV;
};
