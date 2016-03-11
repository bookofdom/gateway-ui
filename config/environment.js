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
      routeAfterAuthentication: 'apis',
      routeIfAlreadyAuthenticated: 'apis'
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
    registrationEnabled: true, // expose the user registration UI?

    version: null,
    devMode: false,
    goOs: null,
    remoteEndpointTypesEnabled: null,

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

    // uncomment for stand-alone gateway API
    ENV.api.swaggerViewerPath = '/swagger';
    ENV.api.swaggerJsonPath = '/swagger';
    //ENV.api.host = 'http://localhost:5000'
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
  }

  if (environment === 'production') {
    ENV.baseURL = null;
    ENV.locationType = 'hash';
    ENV.registrationEnabled = 'REGISTRATION_ENABLED';
    ENV.version = 'VERSION';
    ENV.devMode = 'DEV_MODE';
    ENV.goOs = 'GO_OS';
    ENV.remoteEndpointTypesEnabled = 'REMOTE_ENDPOINT_TYPES_ENABLED';
    ENV.api.basePath = 'API_BASE_PATH_PLACEHOLDER';
    ENV.api.logs.host = 'BROKER_PLACEHOLDER';
    ENV.googleAnalytics = {
      webPropertyId: 'GOOGLE_ANALYTICS_TRACKING_ID'
    };
  }

  ENV.api.url = [ENV.api.host, ENV.api.basePath].join('/');
  ENV.api.authentication.url = [ENV.api.host, ENV.api.basePath, ENV.api.authentication.path].join('/');
  ENV['simple-auth'].crossOriginWhitelist = [ENV.api.authentication.url];

  return ENV;
};
