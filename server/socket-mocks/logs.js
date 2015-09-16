module.exports = function (httpServer) {
  // mock socket reloader
  var WebSocketServer = require('ws').Server,
      wss = new WebSocketServer({server: httpServer});

  wss.on('connection', function connection(ws) {
    console.log('Opened socket connection:', ws.upgradeReq.url);

    ws.on('message', function incoming(message) {
      console.log('received: %s', message);
    });

    ws.on('close', function closed() {
      console.log('Closed socket connection:', ws.upgradeReq.url);
      clearInterval(interval);
    });

    var interval = setInterval(function () {
      ws.send('127.0.0.1 captain picard [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326\n');
    }, 1000);
  });

  return wss;
};
