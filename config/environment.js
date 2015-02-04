/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'gateway',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    'simple-auth': {
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
    
    api: {
      host: process.env.API_HOST || 'http://localhost:4200',
      basePath: 'admin',
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
  }

  if (environment === 'production') {

  }
  
  ENV.api.url = [ENV.api.host, ENV.api.basePath].join('/');
  ENV.api.authentication.url = [ENV.api.host, ENV.api.basePath, ENV.api.authentication.path].join('/');
  ENV['simple-auth'].crossOriginWhitelist = [ENV.api.authentication.url];

  return ENV;
};
