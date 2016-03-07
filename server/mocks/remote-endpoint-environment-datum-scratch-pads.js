module.exports = function(app) {
  var express = require('express');
  var padsRouter = express.Router();
  var pads = [
    {
        "environment_datum_id": 1,
        "id": 1,
        "name": "Test 1",
        "code": "console.log('Test 1');"
    },
    {
        "environment_datum_id": 1,
        "id": 2,
        "name": "Test 2",
        "code": "console.log('Test 2');"
    }
  ];

  var executeResult = {
    "time": 100,
    "request": '{"a": "request"}',
    "response": '{"a": "response"}'
  };

  padsRouter.get('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/', function(req, res) {
    var _pads = pads.filter(function (value) {
      return value.environment_datum_id == req.params.environment_data_id;
    });
    res.send({
      'scratch_pads': _pads
    });
  });

  padsRouter.post('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/', function(req, res) {
    var body = req.body;
    var id = Math.round(Math.random() * 100) + 100;
    body.scratch_pad.id = id;
    res.status(201).send(body).end();
  });

  padsRouter.get('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/:id', function(req, res) {
    var pad = pads.filter(function (value) {
      return value.id == req.params.id;
    });
    res.send({
      'scratch_pad': pad[0]
    });
  });

  padsRouter.put('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/:id', function(req, res) {
    var body = req.body;
    body.scratch_pad.id = req.params.id;
    if (body.scratch_pad.name.toLowerCase() == 'error') {
      res.status(422).send({errors: {name: 'This field is in error.'}});
    } else if (body.scratch_pad.name.toLowerCase() == '500') {
      res.status(500).send();
    } else {
      res.send(body);
    }
  });

  padsRouter.delete('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/:id', function(req, res) {
    res.status(204).end();
  });

  padsRouter.get('/:remote_endpoint_id/environment_data/:environment_data_id/scratch_pads/:id/execute', function(req, res) {
    res.send(executeResult);
  });

  app.use('/admin/apis/:api_id/remote_endpoints', padsRouter);
};
