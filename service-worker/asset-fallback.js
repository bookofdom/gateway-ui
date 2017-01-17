import { PROJECT_REVISION, VERSION, addFetchListener } from 'ember-service-worker/service-worker';

/**
 * Caches assets that aren't cached by the default asset-cache plugin on a
 * fallback basis.  That is, non-cors assets are requested from the network
 * first, cached, and returned by the service worker only if the network
 * request fails.
 */
const CACHE_KEY_PREFIX = 'asset-fallback-';
const CACHE_NAME = `${CACHE_KEY_PREFIX}${PROJECT_REVISION}-${VERSION}`;

addFetchListener(function (event) {
  return caches
    .open(CACHE_NAME)
    .then(function (cache) {
      return fetch(event.request)
        .then(function (response) {
          // "no cors" is defined as either literally "no-cors" mode OR as
          // a cors request with same-origin credentials.
          var isNoCorsHttpGet =
            event.request &&
            (event.request.method == 'GET') &&
            (event.request.url.match(/^(http)s?\:\/{2}/)) &&
            (
              (event.request.mode == 'no-cors') ||
              (event.request.credentials == 'same-origin')
            );
          var success = response && (response.status >= 200) && (response.status < 300);
          if (isNoCorsHttpGet && success) {
            cache.put(event.request, response.clone());
          }
          return response;
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
