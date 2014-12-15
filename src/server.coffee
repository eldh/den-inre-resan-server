mach = require 'mach'
rest = require 'rest'
_ = require 'lodash'
config = require '../config'
app = mach.stack()
utf8 = require 'utf8'
ResrobotMock = require './resrobot-mock'
RealtidsinfoMock = require './realtidsinfo-mock'
ReseplanerareMock = require './reseplanerare-mock'
PlatsuppslagMock = require './platsuppslag-mock'
sslRootCAs = require 'ssl-root-cas/latest'
sslRootCAs.inject()
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"
getUrl = (name, req) ->
	api = config.apis[name]
	paramsObject = _.merge getQueryObject(req.queryString), api.params
	paramsArray = _.map paramsObject, (value, key) ->
		"#{key}=#{value}"
	params = paramsArray.join ''
	"#{api.url}?#{paramsArray.join '&'}"

getQueryObject = (queryString) ->
	queryObject = {}
	queryString.replace new RegExp("([^?=&]+)(=([^&]*))?", "g"), ($0, $1, $2, $3) ->
		queryObject[$1] = $3
	queryObject

sendResponse = (content) ->
	"rejectUnauthorized": false
	headers:
		"rejectUnauthorized": false
		"Access-Control-Allow-Origin": config.host
		'Access-Control-Allow-Credentials': true
		'Content-Type': 'application/json; charset=UTF-8'
		"Access-Control-Allow-Headers": "X-Requested-With"
	content: content

mach.serve (req, res) ->
	if req.path.indexOf('mock') > -1
		if req.path.indexOf('realtidsinfo') > -1
			sendResponse utf8.encode JSON.stringify RealtidsinfoMock
		else if req.path.indexOf('platsuppslag') > -1
			sendResponse utf8.encode JSON.stringify PlatsuppslagMock
		else if req.path.indexOf('reseplanerare') > -1
			sendResponse utf8.encode JSON.stringify ReseplanerareMock
	else

		args =
			api: 'resrobot'
			method: 'Search'

		if req.path.indexOf('/resrobot/search') > -1
			args = 
				api: 'resrobot'
				method: 'Search'
		if req.path.indexOf('/resrobot/stations') > -1
			args = 
				api: 'resrobot'
				method: 'StationsInZone'
		if req.path.indexOf('/reseplanerare/') > -1
			args = 
				api: 'reseplanerare'
				method: 'Trip'
		if req.path.indexOf('/realtidsinfo/') > -1
			args = 
				api: 'realtidsinfo'
				method: 'Search'
		if req.path.indexOf('/platsuppslag/') > -1
			args = 
				api: 'platsuppslag'
				method: 'typeahead'
		if req.path.indexOf('/resrobot/location') > -1
			args = 
				api: 'resrobot'
				method: 'FindLocation'
		rest(getUrl args.api, req).then (response) ->
			sendResponse utf8.encode response.entity

, process.env.PORT or 8005
