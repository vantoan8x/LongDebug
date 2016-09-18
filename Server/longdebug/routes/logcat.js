var express = require('express');
var router = express.Router();
var fs = require('fs')

/* GET logcat listing. */
router.get('/', function(req, res, next) {
	fs.readFile('./public/html/index.html', 'utf8', function (err, data) {
  		if (err) {
    		return console.log(err);
  		}
  		res.send(data);
	});
});

router.get('/test', function(req, res, next) {
	res.send("OK");
});

module.exports = router;