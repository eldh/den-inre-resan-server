module.exports = 
	host: '*'
	apis:
		resrobot:
			url: 'https://api.trafiklab.se/samtrafiken/resrobot/'
			params:
				key: 'API_KEY'
				apiVersion: '2.1'
				coordSys: 'RT90'
				searchType: 'T'
				mode1: false
				mode2: false
				mode4: false
				mode5: false
				output: 'json'
		realtid:
			url: 'https://api.sl.se/api2/realtimedepartures.json'
			params:
				key: 'API_KEY'
		platsuppslag:
			url: 'https://api.sl.se/api2/typeahead.json'
			params:
				key: 'API_KEY'
				maxresults: 20
		reseplanerare:
			url: 'https://api.sl.se/api2/TravelplannerV2/trip.json'
			params:
				key: 'API_KEY'

