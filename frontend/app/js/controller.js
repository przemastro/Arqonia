'use strict';


var astroApp = angular.module('astroApp.controller', ['ngResource', 'ngAnimate', 'ui.bootstrap', 'smart-table',
'angularjs-datetime-picker', 'angularModalService', 'chart.js']);

    astroApp.config(['$httpProvider', function ($httpProvider) {
                $httpProvider.defaults.useXDomain = true;
                delete $httpProvider.defaults.headers.common['X-Requested-With'];
            }]);

//---------------------------------------------------Table List---------------------------------------------------------
    //tableListCtrl
	astroApp.controller('tableListCtrl', function($scope) {
	});

    //tableCtrl
    astroApp.controller('tableCtrl', ['$scope', '$routeParams', 'getObservations',
                                     function($scope, $routeParams, Observations) {
       $scope.displayedObservations = [];
       $scope.observations = Observations.query();


       $scope.toggleAnimation = function () {
       $scope.animationsEnabled = !$scope.animationsEnabled;

       scope.itemsByPage=15
       };

    }]);

    astroApp.controller('ModalCtrl', ['$scope', '$uibModal', 'postObservation', function ($scope, $uibModal, NewObservation) {

       $scope.animationsEnabled = true;


       $scope.addObservation = function () {
            var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'newModalContent.html',
              controller: 'ModalInstanceCtrl'
            });


          $scope.addRow = function(){
   	      $scope.observations.push({ 'name':$scope.name,
   	                           'startDate': $scope.startDate,
   	                           'endDate':$scope.endDate,
   	                           'uPhotometry':$scope.uPhotometry,
   	                           'vPhotometry':$scope.vPhotometry,
   	                           'bPhotometry':$scope.bPhotometry});

   		   NewObservation.save({name:$scope.name,startDate:$scope.startDate,endDate:$scope.endDate,
   		                     uPhotometry:$scope.uPhotometry,vPhotometry:$scope.vPhotometry,bPhotometry:$scope.bPhotometry}, function(response){
   		      $scope.message = response.message;
   		   });
          };
       };

        $scope.removeObservation = function (index) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'removeObservationModal.html',
              controller: 'ModalInstanceRemoveCtrl'
           });
           $scope.observations.splice(index, 1);
        }

        $scope.editObservation = function () {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editObservationModal.html',
              controller: 'ModalInstanceEditCtrl'
           });
        }

        $scope.editPhotometry = function () {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editPhotometryModal.html',
              controller: 'ModalInstanceEditPhotometryCtrl'
           });
        }
    }]);

    astroApp.controller('ModalInstanceCtrl', function ($scope, $uibModalInstance) {
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    });

    astroApp.controller('ModalInstanceEditCtrl', function ($scope, $uibModalInstance) {
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    });

    astroApp.controller('ModalInstanceEditPhotometryCtrl', function ($scope, $uibModalInstance) {
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    });

    astroApp.controller('ModalInstanceRemoveCtrl', function ($scope, $uibModalInstance) {
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };

      $scope.remove = function (index) {
        $scope.observations.splice(index, 1);
        $uibModalInstance.dismiss();
      };
    });

//---------------------------------------------------------Diagrams-----------------------------------------------------
    //hrDiagramCtrl
	astroApp.controller('hrDiagramCtrl', function($scope) {
	});

	astroApp.controller("observationsCtrl", function ($scope)
     {
      $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
      $scope.series = ['Series A'];
      $scope.data = [
        [65, 59, 80, 81, 56, 55, 40]
      ];
      $scope.onClick = function (points, evt) {
        console.log(points, evt);
      };
    });

    astroApp.controller("periodCtrl", function ($scope)
     {
      $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
      $scope.series = ['Series A'];
      $scope.data = [
        [65, 59, 80, 81, 56, 55, 40]
      ];
      $scope.onClick = function (points, evt) {
        console.log(points, evt);
      };
    });

    astroApp.controller("hrCtrl", function ($scope)
     {
      $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
      $scope.series = ['Series A'];
      $scope.data = [
        [65, 59, 80, 81, 56, 55, 40]
      ];
      $scope.onClick = function (points, evt) {
        console.log(points, evt);
      };
    });

//--------------------------------------------------------Admin Panel---------------------------------------------------

	astroApp.controller('adminCtrl', function($scope) {
	   $scope.message = 'Admin Panel';
	});
//-----------------------------------------------------------Home-------------------------------------------------------

    //mainCtrl
	astroApp.controller('mainCtrl', function($scope) {
	   $scope.message = 'Home made HR diagram';
	});