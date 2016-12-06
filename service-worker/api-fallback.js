import { PROJECT_REVISION, VERSION, addFetchListener } from 'ember-service-worker/service-worker';

/**
 * Caches CORS-based API requests for offline use.  All API requests are sent to
 * the network first.  If the network fails, a cached version of the request
 * is returned.
 */
const CACHE_KEY_PREFIX = 'api-fallback-';
const CACHE_NAME = `${CACHE_KEY_PREFIX}${PROJECT_REVISION}-${VERSION}`;

addFetchListener(function (event) {
  return caches
    .open(CACHE_NAME)
    .then(function (cache) {
      return fetch(event.request)
        .then(function (response) {
          var isCorsGet = event.request &&
            (event.request.method == 'GET') &&
            (event.request.mode == 'cors');
          var success = response && (response.status >= 200) && (response.status < 300);
          if (isCorsGet && success) {
            cache.put(event.request, response.clone());
            return response;
          }
        })
        .catch(function (response) {
          return caches.match(event.request, {cacheName: CACHE_NAME});
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
