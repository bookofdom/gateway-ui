/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var Funnel = require('broccoli-funnel');
var mergeTrees = require('broccoli-merge-trees');

/*
 * Updated build syntax:
 * https://github.com/ember-cli/ember-cli/blob/master/TRANSITION.md#user-content-brocfile-transition
 */

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    fingerprint: {
      exclude: [
        'locales',
        'snippets',
        'swagger',
        'theme-slate.js',
        'worker-javascript.js',
        'worker-json.js',
        'worker-tern.js'
      ]
    },
    gzip: {
      enabled: false,
      extensions: ['js', 'css', 'svg', 'eot', 'ttf'],
      appendSuffix: false
    },
    sourcemaps: {
      enabled: false
    },
    sassOptions: {
      sourceMap: false,
      includePaths: [
        'bower_components/bootstrap-sass/assets/stylesheets'
      ]
    },
    'asset-cache': {
      exclude: [
        'locales', // fallback cache is more apprpropriate
        'tests', // never cache
        '.DS_Store', // never cache
        'index.html', // fallback cache is more apprpropriate
        'robots.txt', // never cache
        'sw.js', // fallback cache is more apprpropriate
        'sw-registration.js', // fallback cache is more apprpropriate
        'swagger.html', // fallback cache is more apprpropriate
        'swagger.json', // fallback cache is more apprpropriate
        'testem.js', // never cache
        'tests.js', // never cache
        'test-support.css', // never cache
        'test-support.js' // never cache
      ],
      include: [
        'assets/fonts/gateway.woff',
        'snippets/javascript.js',
        'snippets/json.js',
        'snippets/text.js',
        'worker-javascript.js',
        'worker-json.js',
        'worker-tern.js'
      ]
    }
  });

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  // Bootstrap
  app.import('bower_components/bootstrap-sass/assets/javascripts/bootstrap.js');
  // i18next
  app.import('bower_components/i18next/i18next.js');
  // moment
  app.import('bower_components/moment/moment.js');
  app.import('bower_components/moment/locale/es.js');
  app.import('bower_components/moment/locale/hi.js');
  app.import('bower_components/moment/locale/pt-br.js');
  // ACE
  // TODO:  customized for Ember compatibility
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/ace.js');
  // Standard ACE libraries
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/ext-language_tools.js');
  app.import('vendor/ace-tern/ace-builds/src-noconflict/ext-tern.js');
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/mode-javascript.js');
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/mode-json.js');
  app.import('bower_components/ace-tern/ace-builds/src-noconflict/mode-text.js');

  // jQuery UI
  app.import('bower_components/jquery-ui/jquery-ui.js');
  // datetime picker
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js');
  app.import('bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');
  // UUID
  app.import('bower_components/node-uuid/uuid.js');
  // vkBeautify
  app.import('bower_components/vkbeautify/vkbeautify.js');
  // uuid
  app.import('bower_components/node-uuid/uuid.js');
  // jjv
  app.import('bower_components/jjv/lib/jjv.js');
  // deep equals
  app.import('bower_components/deep-equal/index.js');

  // Gateway Icons
  var gatewayIcons = new Funnel('bower_components/gateway-icons/dist/fonts', {
    srcDir: '/',
    destDir: 'assets/fonts'
  });

  // Swagger is included statically instead of compiled into assets.  It's best
  // to treat swagger as a standalone app.  Thought it bills itself as
  // dependency-free, it is actually a mess of third-party libraries and
  // jQuery-based code.
  var swaggerAssets = new Funnel('bower_components/swagger-ui/dist', {
    srcDir: '/',
    destDir: 'swagger'
  });

  // ACE workers are loaded at runtime via AJAX and thus are included seperately
  var aceAssets = new Funnel('bower_components/ace-tern/ace-builds/src-noconflict', {
    srcDir: '/',
    include: [
      'snippets/javascript.js',
      'snippets/json.js',
      'snippets/text.js',
      'worker-javascript.js',
      'worker-json.js',
      'worker-tern.js'
    ],
    destDir: '/'
  });

  return mergeTrees([app.toTree(), gatewayIcons, swaggerAssets, aceAssets]);
};
