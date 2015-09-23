module.exports = function (httpServer) {
  // mock socket reloader
  var WebSocketServer = require('ws').Server,
      wss = new WebSocketServer({server: httpServer});

  wss.on('connection', function connection(ws) {
    var interval;
    var isLogs = !!ws.upgradeReq.url.match('/logs/socket');
    var isNotifications = !!ws.upgradeReq.url.match('/notifications');

    console.log('Opened socket connection:', ws.upgradeReq.url);

    ws.on('message', function incoming(message) {
      console.log('received: %s', message);
    });

    ws.on('close', function closed() {
      console.log('Closed socket connection:', ws.upgradeReq.url);
      clearInterval(interval);
    });

    if (isLogs) {
      interval = setInterval(function () {
        ws.send('127.0.0.1 captain picard [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326\n');
      }, 3000);
    }
    
    if (isNotifications) {
      var payload = JSON.stringify({
        resource: 'proxy_endpoint',
        resource_id: 1,
        api_id: 1,
        action: 'updated',
        user: 'developer@software.com'
      });
      interval = setInterval(function () {
        ws.send(payload);
      }, 3000);
    }
  });

  return wss;
};
