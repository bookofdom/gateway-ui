module.exports = function(app) {
  var express = require('express');
  var remoteEndpointsRouter = express.Router();
  var remoteEndpoints = [
    {
      "id":1,
      "api_id":1,
      "name":"hello",
      "codename":"hello",
      "description":"world",
      "type":"http",
      "data":{
        "url":"http://demo.ap.com",
        "method":"GET",
        "headers":{
          "X-Pasta":"spaghetti",
          "X-Addition":"meatballs"
        },
        "query":{
          "foo":"bar",
          "baz":"baf"
        }
      },
      "environment_data":[
        {
          "environment_id":1,
          "data":{
            "url":"http://demo.ap.com",
            "method":"GET",
            "headers":{
              "X-Pasta":"spaghetti",
              "X-Addition":"meatballs"
            },
            "query":{
              "foo":"bar",
              "baz":"baf"
            }
          }
        }
      ]
    },
    {
      "id":2,
      "api_id":1,
      "name":"hello",
      "codename":"hello_world",
      "description":"world",
      "type":"http",
      "data":{
        "url":"http://demo.ap.com",
        "method":"PUT"
      },
      "environment_data":[
        {
          "environment_id":1,
          "data":{
            "url":"http://demo.ap.com",
            "method":"PUT",
            "headers":{
              "X-Pasta":"spaghetti",
              "X-Addition":"meatballs"
            },
            "query":{
              "foo":"bar",
              "baz":"baf"
            }
          }
        }
      ]
    },
    {
      "id":3,
      "api_id":1,
      "name":"hello",
      "codename":"world",
      "description":"world",
      "type":"http",
      "data":{
        "url":"http://demo.ap.com",
        "method":"DELETE"
      },
      "environment_data":[
        {
          "environment_id":1,
          "data":{
            "url":"http://demo.ap.com",
            "method":"DELETE",
            "headers":{
              "X-Pasta":"spaghetti",
              "X-Addition":"meatballs"
            },
            "query":{
              "foo":"bar",
              "baz":"baf"
            }
          }
        }
      ]
    },
    {
      "id":4,
      "api_id":1,
      "name":"sql-simple",
      "codename":"sql",
      "description":"sql",
      "type":"sqlserver",
      "data":{
        "config":{
          "server":"server.foo.com",
          "port":1433,
          "user id":"anypresence",
          "password":"password",
          "database":"database",
          "schema":"schema"
        }
      }
    },
    {
      "id":5,
      "api_id":1,
      "name":"sql-complex",
      "codename":"sql",
      "description":"sql",
      "type":"sqlserver",
      "data":{
        "config":{
          "server":"server.foo.com",
          "port":1433,
          "user id":"anypresence",
          "password":"password",
          "database":"database",
          "schema":"schema",
          "connection timeout":30
        },
        "transactions":true,
        "maxIdleConn":100,
        "maxOpenConn":80
      }
    },
    {
      "id":6,
      "api_id":1,
      "name":"postgres-simple",
      "codename":"super-postgres",
      "description":"postgres!",
      "type":"postgres",
      "data":{
        "config":{
          "server":"server.foo.com",
          "port":1433,
          "user id":"anypresence",
          "password":"password",
          "database":"database"
        }
      }
    }
  ];

  remoteEndpointsRouter.get('/', function(req, res) {
    res.send({
      'remote_endpoints': remoteEndpoints
    });
  });

  remoteEndpointsRouter.post('/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.remote_endpoint.id = id;
    res.status(201).send(body).end();
  });

  remoteEndpointsRouter.get('/:id', function(req, res) {
    var endpoint = remoteEndpoints.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'remote_endpoint': endpoint[0]
    });
  });

  remoteEndpointsRouter.put('/:id', function(req, res) {
    var body = req.body;
    body.remote_endpoint.id = req.params.id;
    if (body.remote_endpoint.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}})
    } else {
      res.send(body);
    }
  });

  remoteEndpointsRouter.delete('/:id', function(req, res) {
    res.status(204).end();
  });

  app.use('/admin/apis/:api_id/remote_endpoints', remoteEndpointsRouter);
};
