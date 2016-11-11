import { PROJECT_REVISION, VERSION, addFetchListener } from 'ember-service-worker/service-worker';

/**
 * Caches index page (served from service worker scope) on a fallback basis.
 * It is requested from the network first, cached, and returned by the service
 * worker only if the network request fails.
 */
const CACHE_KEY_PREFIX = 'index-fallback-';
const CACHE_NAME = `${CACHE_KEY_PREFIX}${PROJECT_REVISION}-${VERSION}`;

self.addEventListener('install', function (event) {
  event.waitUntil(
    caches
      .open(CACHE_NAME)
      .then(function (cache) {
        cache.add(self.registration.scope);
      })
  );
});

addFetchListener(function (event) {
  return caches
    .open(CACHE_NAME)
    .then(function (cache) {
      return fetch(event.request)
        .catch(function (response) {
          var htmlRequested = event.request.headers.get('accept').indexOf('text/html') >= 0;
          var notSwagger = event.request.url.indexOf('swagger') < 0;
          if (htmlRequested && notSwagger) {
            return caches.match(self.registration.scope);
          }
        });
    });
});

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheNames) {
      cacheNames.forEach(function (cacheName) {
        if (cacheName.indexOf(CACHE_KEY_PREFIX) === 0 && cacheName !== CACHE_NAME) {
          caches.delete(cacheName);
        }
      });
    })
  );
});
