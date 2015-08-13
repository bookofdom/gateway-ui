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
     "name":"sql-server-simple",
     "codename":"sql-server",
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
     "name":"sql-server-complex",
     "codename":"sql-server",
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
     "id": 6,
     "api_id": 1,
     "name": "postgres-simple",
     "codename": "psql",
     "description": "psql",
     "type": "postgres",
     "data": {
       "config": {
         "host": "server.foo.com",
         "port": 1433,
         "user": "anypresence",
         "password": "password",
         "dbname": "database"
       },
       "transactions": true,
       "maxIdleConn": 100,
       "maxOpenConn": 80
     }
   },
   {
      "id":9,
      "api_id":1,
      "name":"mongo",
      "codename":"mongodb",
      "description":"MongoDB endpoint",
      "type":"mongodb",
      "data":{
        "config": {
          "hosts":[
            {
              "host": "www.mongodb.com",
              "port": 27017
            }
          ],
          "database":"myproject",
          "username":"mongo-user",
          "password":"password"
        },
        "limit": 4096
      }
   },
  {
    "id":10,
    "api_id":1,
    "name":"mysql",
    "codename":"mysql",
    "description":"MySQL endpoint",
    "type":"mysql",
    "data":{
      "config": {
        "server":"server.foo.com",
        "port":1433,
        "username":"anypresence",
        "password":"password",
        "dbname":"database"
      }
    }
  },
  {
    "id":11,
    "api_id":1,
    "name":"mysql",
    "codename":"mysql",
    "description":"MySQL endpoint",
    "type":"mysql",
    "data":{
      "config": {
        "server":"server.foo.com",
        "port":1433,
        "username":"anypresence",
        "password":"password",
        "dbname":"database",
        "timeout":"65000ms"
      },
      "transactions":true,
      "maxIdleConn":100,
      "maxOpenConn":80
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
    if (body.remote_endpoint.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.remote_endpoint.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.status(201).send(body).end();
    }
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
