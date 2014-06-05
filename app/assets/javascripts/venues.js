var songKickApp = angular.module('songkick-app', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    //defaults.common["X-CSRF-TOKEN"] = authToken;
    //defaults.patch = defaults.patch || {};
    //defaults.patch['Content-Type'] = 'application/json';
    //defaults.common['Accept'] = 'application/json';
}]);

songKickApp.factory('venue', ['$http', function($http) {
  return $http({method: 'GET', url: 'http://api.songkick.com/api/3.0/search/locations.json?query=los+angeles&apikey=Phaj1PyBhlWJiN94'});
}])

songKickApp.controller('venueCtrl', ['venue', 'calendar', '$scope', function(venue, calendar, $scope) {
  $scope.venues= [];

  venue.success(function(data, status, headers, config) {
  	console.log(data);
    $scope.metroAreaId = data.resultsPage.results.location[0].metroArea.id;
    calendar.forMetroArea($scope.metroAreaId).success(function(data, status, headers, config) {
    	console.log(data)
    })
  });
}])

songKickApp.factory('calendar', ['$http', function($http) {
   Calendar = {
   	 forMetroArea: function(metroAreaId) {
   	    return $http({method: 'GET', url: 'http://api.songkick.com/api/3.0/metro_areas/'+metroAreaId+'/calendar.json?apikey=Phaj1PyBhlWJiN94'});
   	 }
   }
  return Calendar;
}])

songKickApp.controller('calendarCtrl', ['calendar', '$scope', function(calendar, $scope) {
  $scope.calendar= [];

  calendar.success(function(data, status, headers, config) {
  	console.log(data);

    
  });
}])