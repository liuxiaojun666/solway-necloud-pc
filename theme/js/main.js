'use strict';

/* Controllers */

angular.module('app')
  .controller('AppCtrl', ['$scope', '$rootScope', '$translate', '$localStorage', '$window','$http',
    function($scope, $rootScope, $translate, $localStorage, $window,$http ) {
      $rootScope.$on("chCompanyInfo", function(e, data){
        $rootScope.currCompanyName = data.currCompanyName;
        $rootScope.currCompanyLogo = data.currCompanyLogo;
      });
      // add 'ie' classes to html
      var isIE = !!navigator.userAgent.match(/MSIE/i);
      isIE && angular.element($window.document.body).addClass('ie');
      isSmartDevice( $window ) && angular.element($window.document.body).addClass('smart');
      $scope.$on("refreshViewData", function (event, msg) {
      	$scope.$broadcast("refreshViewDataForHead", msg);
      });
      $scope.$on("emitSwitchStation", function (event, msg) {
        $scope.$broadcast("broadcastSwitchStation", msg);
      });
      // config
      $scope.app = {
        name: '创维互联',
        version: '1.3.3',
        // for chart colors
        color: {
          primary: '#7266ba',
          info:    '#23b7e5',
          success: '#27c24c',
          warning: '#fad733',
          danger:  '#f05050',
          light:   '#e8eff0',
          dark:    '#3a3f51',
          black:   '#1c2b36',
          green:   '#6fbb18',
          orange:   '#ee974b'
        },
        settings: {
          themeID: 1,
          navbarHeaderColor: 'bg-black',
          navbarCollapseColor: 'bg-white-only',
          asideColor: 'bg-black',
          headerFixed: true,
          asideFixed: false,
          asideFolded: false,
          asideDock: false,
          container: false
        }
      }

      // save settings to local storage
      if ( angular.isDefined($localStorage.settings) ) {
        $scope.app.settings = $localStorage.settings;
      } else {
        $localStorage.settings = $scope.app.settings;
      }
      $scope.$watch('app.settings', function(){
        if( $scope.app.settings.asideDock  &&  $scope.app.settings.asideFixed ){
          // aside dock and fixed must set the header fixed.
          $scope.app.settings.headerFixed = true;
        }
        // save to local storage
        $localStorage.settings = $scope.app.settings;
      }, true);

      // angular translate
      $scope.lang = { isopen: false };
      $scope.langs = {en:'English', de_DE:'German', it_IT:'Italian'};
      $scope.selectLang = $scope.langs[$translate.proposedLanguage()] || "English";
      $scope.setLang = function(langKey, $event) {
        // set the current lang
        $scope.selectLang = $scope.langs[langKey];
        // You can change the language during runtime
        $translate.use(langKey);
        $scope.lang.isopen = !$scope.lang.isopen;
      };

      function isSmartDevice( $window )
      {
          // Adapted from http://www.detectmobilebrowsers.com
          var ua = $window['navigator']['userAgent'] || $window['navigator']['vendor'] || $window['opera'];
          // Checks for iOs, Android, Blackberry, Opera Mini, and Windows mobile devices
          return (/iPhone|iPod|iPad|Silk|Android|BlackBerry|Opera Mini|IEMobile/).test(ua);
      }
      
      //$rootScope.headCenterTitle = "智能运营平台";
      
      var scriptParam = document.getElementById('routerJS').getAttribute('param');
      /**$.ajax({
      	type : "post",
      	url : scriptParam + "/UserAuthHandle/getRightListForPCNew.htm",
      	async : false,
      	success : function(result) {
      		console.log(result)
      		if(result.result){
				if(result.mainPageType == 1){
					$rootScope.headCenterTitle = "能源管理系统";
				}else{
					$rootScope.headCenterTitle = "集中监控系统";
				}
			}
      	},
      	error : function(json) {
      	}
      });*/
      
      $.get(scriptParam+'/Login/getCustomConfigByComId.htm',function(result){
    	  //console.log("-----------------")
    	  //console.log(result)
		  var currConfig = result.data;
    	  $rootScope.mainPageUrl = currConfig.mainPage;
		  $rootScope.headCenterTitle = currConfig.os_title;
		  
		  document.title = currConfig.os_title;

	  });
      
      $.get(scriptParam+'/UserAuthHandle/getFirstRightUisref.htm',function(result){
    	  $rootScope.firstMenuUrl = result;

	  });

  }]);
