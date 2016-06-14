'use strict';


var astroApp = angular.module('astroApp.controller', ['ngResource', 'ngAnimate', 'ui.bootstrap', 'smart-table',
'angularjs-datetime-picker', 'angularModalService', 'chart.js', 'angularSpinner']);

    astroApp.config(['$httpProvider', function ($httpProvider) {
                $httpProvider.defaults.useXDomain = true;
                delete $httpProvider.defaults.headers.common['X-Requested-With'];
            }]);

//---------------------------------------------------Table List---------------------------------------------------------
    //tableListCtrl
	astroApp.controller('tableListCtrl', function($scope) {
	});

    //tableCtrl
    astroApp.controller('tableCtrl', ['$rootScope', '$routeParams', 'getObservations',
                                     function($scope, $routeParams, Observations) {
       $scope.displayedObservations = [];
       $scope.observations = Observations.query();

       $scope.toggleAnimation = function () {
       $scope.animationsEnabled = !$scope.animationsEnabled;

       scope.itemsByPage=15
       };

    }]);

    astroApp.controller('ModalCtrl', ['$scope', '$uibModal', function ($scope, $uibModal) {

       $scope.animationsEnabled = true;


       $scope.addObservation = function () {
            var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'newModalContent.html',
              controller: 'ModalInstanceCtrl',
            });
       };

        $scope.removeObservation = function (removePhotometry) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'removeObservationModal.html',
              controller: 'ModalInstanceRemoveCtrl',
              resolve: {
                  removePhotometry: function () {
                      return removePhotometry;
                  }
              }
           });
        }

        $scope.editObservation = function (editPhotometry) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editObservationModal.html',
              controller: 'ModalInstanceEditCtrl',
              resolve: {
                  editPhotometry: function () {
                      return editPhotometry;
                  }
              }
           });
        }

        $scope.editUPhotometry = function (editUPhotometry) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editUPhotometryModal.html',
              controller: 'ModalInstanceEditUPhotometryCtrl',
              resolve: {
                  editUPhotometry: function () {
                      return editUPhotometry;
                  }
              }
           });
        }

        $scope.editVPhotometry = function (editVPhotometry) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editVPhotometryModal.html',
              controller: 'ModalInstanceEditVPhotometryCtrl',
              resolve: {
                  editVPhotometry: function () {
                      return editVPhotometry;
                  }
              }
           });
        }

        $scope.editBPhotometry = function (editBPhotometry) {
           var modalInstance = $uibModal.open({
              animation: $scope.animationsEnabled,
              templateUrl: 'editBPhotometryModal.html',
              controller: 'ModalInstanceEditBPhotometryCtrl',
              resolve: {
                  editBPhotometry: function () {
                      return editBPhotometry;
                  }
              }
           });
        }
    }]);

    astroApp.controller('ModalInstanceCtrl', ['$scope', '$uibModalInstance', 'postObservation', function ($scope, $uibModalInstance, NewObservation) {
      $scope.addRow = function(){
   		  NewObservation.save({name:$scope.name,startDate:$scope.startDate,endDate:$scope.endDate,
   		                     uPhotometry:$scope.uPhotometry,vPhotometry:$scope.vPhotometry,bPhotometry:$scope.bPhotometry}, function(response){
   		  $scope.message = response.message;
   		   });
   		  $uibModalInstance.dismiss();
       };

       $scope.cancel = function () {
         $uibModalInstance.dismiss('cancel');
       };
    }]);

    astroApp.controller('ModalInstanceRemoveCtrl', ['$scope', '$log', '$uibModalInstance', 'removeObservation', 'removePhotometry', function ($scope, $log, $uibModalInstance, RemoveObservation, removePhotometry) {
      $log.debug(removePhotometry);
      $scope.ob = $scope.observations;
      var removePhotometry = parseInt(removePhotometry);

      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };

      $scope.remove = function () {
        //$scope.observations.splice(removePhotometry, 1);

        $scope.removePhotometry = removePhotometry;
        RemoveObservation.save({id:$scope.ob[removePhotometry].id}, function(response){
           $scope.message = response.message;
        });
        $scope.isDisabled = true;
        $uibModalInstance.dismiss();
        return false;
      };
    }]);

    astroApp.controller('ModalInstanceEditCtrl', function ($scope, $uibModalInstance, editPhotometry) {
      $scope.ob = $scope.observations;
      $scope.editPhotometry = editPhotometry;
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    });

    astroApp.controller('ModalInstanceEditUPhotometryCtrl',  ['$scope', '$log', '$uibModalInstance', 'editUPhotometry', function ($scope, $log, $uibModalInstance, editUPhotometry) {
      $log.debug(editUPhotometry);
      $scope.ob = $scope.observations;
      $scope.editUPhotometry = editUPhotometry;
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    }]);

    astroApp.controller('ModalInstanceEditVPhotometryCtrl', function ($scope, $uibModalInstance, editVPhotometry) {
      $scope.ob = $scope.observations;
      $scope.editVPhotometry = editVPhotometry;
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
      };
    });

    astroApp.controller('ModalInstanceEditBPhotometryCtrl', function ($scope, $uibModalInstance, editBPhotometry) {
      $scope.ob = $scope.observations;
      $scope.editBPhotometry = editBPhotometry;
      $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
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

	astroApp.controller('processCtrl', ['$scope', 'usSpinnerService', '$rootScope', 'processData', 'getProcessedData', '$window', '$timeout',
      function($scope, usSpinnerService, $rootScope, ProcessData, GetProcessedData, $window, $timeout) {
        $scope.message = 'Admin Panel';

        $scope.displayedObservations = [];
        $scope.observations = GetProcessedData.query();

        $scope.startSpin = function() {
          if (!$scope.spinneractive) {
            usSpinnerService.spin('spinner-1');
   		    ProcessData.query(function(response){
   		      $scope.message = response.message;
   		   });
          }
          $timeout(function(){
             $window.location.reload();
             }, 5000);

        };


        $scope.spinneractive = false;

        $rootScope.$on('us-spinner:spin', function(event, key) {
          $scope.spinneractive = true;
        });

        $rootScope.$on('us-spinner:stop', function(event, key) {
          $scope.spinneractive = false;
        });
      }
    ]);
//-----------------------------------------------------------Home-------------------------------------------------------

    //mainCtrl
	astroApp.controller('mainCtrl', function($scope) {
	   $scope.message = 'Home made HR diagram';
	});