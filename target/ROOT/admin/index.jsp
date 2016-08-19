<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--
* INSPINIA - Responsive Admin Theme
* Version 2.3
*
-->
<script>
<%
	ObjectMapper mapper = new ObjectMapper();
 	
 %>
 USERINFO=<%=mapper.writeValueAsString(session.getAttribute("userInfo"))%>;
 if(USERINFO==null){
	 location.replace("login.jsp");
 }
</script>
<!DOCTYPE html>
<html lang="ko" ng-app="app">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Page title set in pageTitle directive -->
    <title page-title></title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Font awesome -->
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Main Inspinia CSS files -->
    <link href="css/animate.css" rel="stylesheet">
    <link id="loadBefore" href="css/style.css" rel="stylesheet">


</head>

<!-- ControllerAs syntax -->
<!-- Main controller with serveral data used in Inspinia theme on diferent view -->
<body landing-scrollspy id="page-top">

<!-- Main view  -->
   <!-- Wrapper-->
<div id="wrapper">

    <!-- Navigation -->
    <div ng-include="'views/common/navigation.htm'"></div>

    <!-- Page wraper -->
    <!-- ng-class with current state name give you the ability to extended customization your view -->
    <div id="page-wrapper" class="gray-bg">

        <!-- Page wrapper -->
        <div ng-include="'views/common/topnavbar.htm'"></div>
		<div ng-view></div>
        <!-- Main view  -->
        <!-- Page Content -->
        
        <!-- /#page-wrapper -->

        <!-- Footer -->
        <div ng-include="'views/common/footer.htm'"></div>

    </div>
    <!-- End page wrapper-->

    <!-- Right Sidebar -->
    <div ng-include="'views/common/right_sidebar.htm'"></div>

</div>
<!-- End wrapper-->
<script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <script src="/ad/js/metisMenu.min.js"></script>
	<script src="//code.angularjs.org/1.3.15/angular.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-route.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-resource.js"></script>
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.0.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
	<script src="/ad/js/bootstrap-treeview.js"></script>
	<script src="/ad/js/common.js"></script>

<!--
 You need to include this script on any page that has a Google Map.
 When using Google Maps on your own site you MUST signup for your own API key at:
 https://developers.google.com/maps/documentation/javascript/tutorial#api_key
 After your sign up replace the key in the URL below..
-->



<script>
	
		function detail(){
			window.open('at_main.jsp','GoogleWindow', 'width=800, height=600');
		}
	</script>
	<script>
	
	
		
		
		var app = angular.module('app',['ngRoute','ngResource','appControllers','appServices','ui.bootstrap']);
		app.run(function($rootScope,$http) {
			$rootScope.userid = USERINFO.userid;
		    $rootScope.codetbl={};
		    $rootScope.loadCodeTbl=function(array,callback){
		    	var codes=[];
		    	for(i=0; i<array.length; i++){
		    		if(!$rootScope.codetbl[array[i]]){
		    			codes.push(array[i]);
		    		}
		    	}
		    	if(codes.length==0) return;
		    	
		    	
		    	for(i=0; i<codes.length; i++){
		    		codes[i]='g_code='+codes[i];
		    	}
		    	var query= codes.join("&");
		    	
	 		    
		    	$http.get('/ad/api/code_tbl?'+query).success(function(response) {
		    	    //console.log(response.data);
		    	    $.each(response.data, function(key, element) {
		    	    	$rootScope.codetbl[key]= element;
		    	    	if(callback) callback(key,element);
		    	    });
		    	    
		    	});
		    	
		    };
		    
		    $rootScope.getCodeDesc=function(g_code,key){
		    	var list = $rootScope.codetbl[g_code];
		    	if(list==undefined) return "";
		    	for(i=0;  i<list.length; i++){
		    		if(list[i].key == key){
		    			return list[i].description;
		    		}
		    	}
		    	return "";
		    }
		   
		    
		});
		app.directive('backButton', function(){
		    return {
		        restrict: 'A',
		        link: function(scope, element, attrs) {
		            element.bind('click', function () {
		                history.back();
		                $scope.$apply();
		            });
		        }
		    }
		});
		
		app.config(['$routeProvider',
		       	  	function($routeProvider){
		       		  $routeProvider.
		       		  	when('/list1',{ // list
		       		  		templateUrl:'part/list.html',
		       		  		controller:'ListController'
		       		  	}).
			       		
			 		  	otherwise({
			 		  		redirectTo:'/list1'
			 		  	});
		       		  
		       }]);
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($scope,$routeParams,$location,$modal){
	    	
			
	    	//console.log($routeParams.member_sq);
	    	$scope.table = $('#table').dataTable( {
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "sScrollY": "300px",
	    	    "bLengthChange": false, // hide show entries
	    	    "bFilter": false,
    			"paging": false,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			
    			"data":[{ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:1200},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:234},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:100},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:100},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:200},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:40},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:30},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:24},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:34},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:33},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:11},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:44}
    			        ]
	    	    ,
    			"columnDefs": [ 
					
		            {"targets": 0,"data": "regDate"},
		            {"targets": 1,"data": "view_count"},
		            {"targets": 2,"data": "click_count"},
		            {"targets": 3,"data": "click_ratio"},
		            {"targets": 4,"data": "cpc"},
		            {"targets": 5,"data": "amount"}
		         ],
		         "fnFooterCallback" : function(nRow, aaData, iStart, iEnd,aiDisplay) {
		        	      var iTotalNuma = 0;
		        	      var iTotalNumb = 0;
		        	      var iTotalNumc = 0;
		        	      if (aaData.length > 0) {
		        	       for ( var i = 0; i < aaData.length; i++) {
		        	        iTotalNuma += aaData[i].view_count;
		        	        iTotalNumb += aaData[i].click_count;
		        	        iTotalNumc += aaData[i].amount;
		        	       }
		        	      }
		        	      /*
		        	       * render the total row in table footer
		        	       */
		        	      var nCells = nRow.getElementsByTagName('th');
		        	      nCells[1].innerHTML = iTotalNuma;
		        	      nCells[2].innerHTML = iTotalNumb;
		        	      nCells[3].innerHTML = iTotalNumb/iTotalNuma;
		        	      nCells[5].innerHTML = iTotalNumc;

		         }
	    	    
			});
	    	
	    	$('#main_content').show();
	    	
		});
	    
		
	    var appServices = angular.module('appServices',[]);
		
	    appServices.factory('Member',function($resource){
			
			return $resource('/ad/member/member/:member_code', { member_code: '@member_code' }, {
				update:{ method:'PUT'}
			  });
		});
	    appServices.factory('PageInfo', function(){
	    	  return {
	    	    data: {
	    	      currentPage: 1
	    	    },
	    	    updatePage: function(p) {
	    	      // Improve this method as needed
	    	      this.data.currentPage = p;
	    	      
	    		}
	    	};
	    });
		
		
	    function minimalizaSidebar($timeout) {
	        return {
	            restrict: 'A',
	            template: '<a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="" ng-click="minimalize()"><i class="fa fa-bars"></i></a>',
	            controller: function ($scope, $element) {
	                $scope.minimalize = function () {
	                    $("body").toggleClass("mini-navbar");
	                    if (!$('body').hasClass('mini-navbar') || $('body').hasClass('body-small')) {
	                        // Hide menu in order to smoothly turn on when maximize menu
	                        $('#side-menu').hide();
	                        // For smoothly turn on menu
	                        setTimeout(
	                            function () {
	                                $('#side-menu').fadeIn(500);
	                            }, 100);
	                    } else if ($('body').hasClass('fixed-sidebar')){
	                        $('#side-menu').hide();
	                        setTimeout(
	                            function () {
	                                $('#side-menu').fadeIn(500);
	                            }, 300);
	                    } else {
	                        // Remove all inline style from jquery fadeIn function to reset menu state
	                        $('#side-menu').removeAttr('style');
	                    }
	                }
	            }
	        };
	    };

	    function sideNavigation($timeout) {
	        return {
	            restrict: 'A',
	            link: function(scope, element) {
	                // Call the metsiMenu plugin and plug it to sidebar navigation
	                $timeout(function(){
	                    element.metisMenu();

	                });
	            }
	        };
	    };

	    angular
	    .module('app')
	    .directive('sideNavigation', sideNavigation)
	    .directive('minimalizaSidebar', minimalizaSidebar);

   
	</script>	
		
	<script type='text/ng-template' id='part/list.html'>
	<div id="main_content" style="display:none">
            
   
   
   <div class="wrapper wrapper-content">
        <div class="row">
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">전체</span>
                                <h5>광고물 등록건수</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-success">0% <i class="fa fa-bolt"></i></div>
                                <small>등록건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">전체</span>
                                <h5>입찰키워드(1차/2차)</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-info">0% <i class="fa fa-level-up"></i></div>
                                <small>등록건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">이번달</span>
                                <h5>충전금액</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-navy">0% <i class="fa fa-level-up"></i></div>
                                <small>충전</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">전체</span>
                                <h5>집행금액</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-danger">0% <i class="fa fa-level-down"></i></div>
                                <small>이번달</small>
                            </div>
                        </div>
            </div>
        </div>
        <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>유입트래픽</h5>
                                <div class="pull-right">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-xs btn-white active">Today</button>
                                        <button type="button" class="btn btn-xs btn-white">Monthly</button>
                                        <button type="button" class="btn btn-xs btn-white">Annual</button>
                                    </div>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-9">
                                    <div class="flot-chart">
                                        <div class="flot-chart-content" id="flot-dashboard-chart" style="padding: 0px; position: relative;"><canvas class="flot-base" width="1494" height="400" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 747px; height: 200px;"></canvas><div class="flot-text" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; font-size: smaller; color: rgb(84, 84, 84);"><div class="flot-x-axis flot-x1-axis xAxis x1Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 74px; text-align: center;">Jan 03</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 142px; text-align: center;">Jan 06</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 211px; text-align: center;">Jan 09</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 279px; text-align: center;">Jan 12</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 347px; text-align: center;">Jan 15</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 415px; text-align: center;">Jan 18</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 483px; text-align: center;">Jan 21</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 551px; text-align: center;">Jan 24</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 619px; text-align: center;">Jan 27</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 687px; text-align: center;">Jan 30</div></div><div class="flot-y-axis flot-y1-axis yAxis y1Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; top: 173px; left: 19px; text-align: right;">0</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 132px; left: 7px; text-align: right;">250</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 92px; left: 7px; text-align: right;">500</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 52px; left: 7px; text-align: right;">750</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 12px; left: 1px; text-align: right;">1000</div></div><div class="flot-y-axis flot-y2-axis yAxis y2Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; top: 173px; left: 735px;">0</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 144px; left: 735px;">5</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 115px; left: 735px;">10</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 87px; left: 735px;">15</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 58px; left: 735px;">20</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 29px; left: 735px;">25</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 1px; left: 735px;">30</div></div></div><canvas class="flot-overlay" width="1494" height="400" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 747px; height: 200px;"></canvas><div class="legend"><div style="position: absolute; width: 111px; height: 30px; top: 13px; left: 35px; opacity: 0.85; background-color: rgb(255, 255, 255);"> </div><table style="position:absolute;top:13px;left:35px;;font-size:smaller;color:#545454"><tbody><tr><td class="legendColorBox"><div style="border:1px solid #000000;padding:1px"><div style="width:4px;height:0;border:5px solid #1ab394;overflow:hidden"></div></div></td><td class="legendLabel">사용자</td></tr><tr><td class="legendColorBox"><div style="border:1px solid #000000;padding:1px"><div style="width:4px;height:0;border:5px solid #1C84C6;overflow:hidden"></div></div></td><td class="legendLabel">집행금액</td></tr></tbody></table></div></div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <ul class="stat-list">
                                        <li>
                                            <h2 class="no-margins">0</h2>
                                            <small>오늘 방문자</small>
                                            <div class="stat-percent">48% <i class="fa fa-level-up text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 48%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        <li>
                                            <h2 class="no-margins ">0</h2>
                                            <small>최근 월간 방문자</small>
                                            <div class="stat-percent">60% <i class="fa fa-level-down text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 60%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        <li>
                                            <h2 class="no-margins ">0</h2>
                                            <small>이달집행금액</small>
                                            <div class="stat-percent">0% <i class="fa fa-bolt text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 22%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        </ul>
                                    </div>
                                </div>
                                </div>

                            </div>
                        </div>
                    </div>


                
                </div>
   
   
   
   
        </div>
        <!-- /#page-wrapper -->
	</script>	
	

</body>
</html>
