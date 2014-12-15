_ = require 'lodash'
config = require '../config'
utf8 = require 'utf8'
ResrobotMock = require './resrobot-mock'
RealtidsinfoMock = require './realtidsinfo-mock'
ReseplanerareMock = require './reseplanerare-mock'

module.exports =
	resrobot: (data) -> data
	realtidsinfo: (data) -> data
	reseplanerare: (data) -> data
