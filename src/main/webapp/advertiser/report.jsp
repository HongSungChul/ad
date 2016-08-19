<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko" ng-app="app">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>광고주 어드민 페이지</title>
	<link href="/ad/css/ad.css" rel="stylesheet">
    <!-- Bootstrap Core CSS -->
    <link href="/ad/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/ad/css/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/animate.css" rel="stylesheet">
    <link id="loadBefore" href="css/style.css" rel="stylesheet">
    

    <!-- Custom Fonts -->
    <link href="/ad/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- DataTables Responsive CSS -->
    <link href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css" rel="stylesheet">
    <link type="text/css" href="/ad/css/loading.css" rel="stylesheet"></link>
	<link href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/css/bootstrap-select.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />
	
	<link rel="stylesheet" type="text/css" href="/ad/css/bootstrap-monthpicker.css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

      <!-- Wrapper-->
<div id="wrapper">

    <!-- Navigation -->
    <div ng-include="'views/common/navigation.htm'"></div>

    <!-- Page wraper -->
    <!-- ng-class with current state name give you the ability to extended customization your view -->
    <div id="page-wrapper" class="gray-bg {{$state.current.name}}">

        <!-- Page wrapper -->
        <div ng-include="'views/common/topnavbar.htm'"></div>

        <!-- Main view  -->
        <div ng-view></div>

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
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.1.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
    <script src="/ad/js/loading-overlay.min.js"></script>
    <script src="/ad/js/vendor/jquery.ui.widget.js"></script>
	<script src="/ad/js/jquery.iframe-transport.js"></script>
    <script src="/ad/js/jquery.fileupload.js"></script>
    
    <script src="/ad/js/bootstrap-monthpicker.js"></script>
    
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/js/bootstrap-select.min.js"></script>
	
	<script>
	
		$(function() {
			//$('#dpMonths').datepicker();
		});
	</script>
		
	<script>
	<%
	ObjectMapper mapper = new ObjectMapper();
 	
	 %>
	 USERINFO=<%=mapper.writeValueAsString(session.getAttribute("userInfo"))%>;
	 if(USERINFO==null)	{
		location.href="login.jsp";
		//return;
	 }

		var app = angular.module('app',['ngRoute','ngResource','appControllers','appServices','ui.bootstrap']);
		app.run(function($rootScope,$http) {
			$rootScope.userid = USERINFO.userid;
			$rootScope.newItem={};
		    
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
		app.directive('selectWatcher', function ($timeout) {
		    return {
		        link: function (scope, element, attr) {
		            //var last = attr.last;
		            //if (last === "true") {
		                $timeout(function () {
		                    //$(element).parent().selectpicker('val', 'any');
		                     $(element).parent().selectpicker('refresh');
		                });
		            //}
		        }
		    };
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
       		  	when('/daily_ac',{ // list
       		  		templateUrl:'part/daily_ac.html',
       		  		controller:'DailyAcController'
       		  	}).
       		 	when('/month_ac',{ // list
    		  		templateUrl:'part/month_ac.html',
    		  		controller:'MonthAcController'
    		  	}).
    		  	when('/report_ad',{ // list
       		  		templateUrl:'part/report_ad.html',
       		  		controller:'ReportAdController'
       		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/daily_ac'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('DailyAcController',function($rootScope,$timeout,$scope,$routeParams,$location,$modal){
	    	$rootScope.title='보고서-일별'; // 타이틀 베목
	    	
	    	$scope.searchForm={};
	    	$scope.cb = function(start, end) {
	    		$scope.searchForm.startDate = start.format('YYYY-MM-DD');
				$scope.searchForm.endDate=end.format('YYYY-MM-DD');
	    		$('#daterange span').html(start.format('YYYY MM DD') + ' ~ ' + end.format('YYYY MM DD'));
	    		if($scope.table)
	    			$scope.table.api().ajax.reload();
	        }
	    	$('#daterange').daterangepicker(
	    			{
	    				ranges: {
	    		           'Today': [new Date(), new Date()],
	    		           'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
	    		           'Last 7 Days': [moment().subtract('days', 6), new Date()],
	    		           'Last 30 Days': [moment().subtract('days', 29), new Date()],
	    		           'This Month': [moment().startOf('month'), moment().endOf('month')],
	    		           'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
	    				},
	    				opens: 'right',
	    				locale: {
	    					format: 'YYYY-MM-DD',
	    				}
	    			}, 
	    			$scope.cb
	    	);
	    	
	        $scope.cb(moment().set('date', 1), moment());
	    	$scope.table = $('#table').dataTable( {
	    		"formatNumber": function ( toFormat ) {
	    		    return toFormat.toString().replace(
	    		      /\B(?=(\d{3})+(?!\d))/g, "'"
	    		    );
	    		},
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/advertiser/dailyAc', // 록록전체
		        	method:'GET',
		        	data:function(d){
		        		d.target="daily";
		        		d.startDate = $scope.searchForm.startDate;
		        		d.endDate = $scope.searchForm.endDate;
		        		d.kind=$scope.searchForm.kind;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
   				            
   					{"targets": 0,"data": "collDate"},
   					{"targets": 1,"data": "viewCnt"},
   					{"targets": 2,"data": "clickCnt"},
   					{"targets": 3,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.clickCnt/full.viewCnt*100)/100*100;
   					},"orderable": false},
   					{"targets": 4,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.sales/full.clickCnt*100)/100;
   					},"orderable": false},
   					
   					{"targets": 5,"data": "sales"}
		   		            
		   		 ],
		   		"fnFooterCallback" : function(nRow, aaData, iStart, iEnd,aiDisplay) {
		   			var tViewCnt = 0;
	        	      var tClickCnt = 0;
	        	      var tSales = 0;
	        	      if (aaData.length > 0) {
	        	       for ( var i = 0; i < aaData.length; i++) {
	        	    	tViewCnt += aaData[i].viewCnt;
	        	        tClickCnt += aaData[i].clickCnt;
	        	        tSales += aaData[i].sales;
	        	       }
	        	      }
	        	     
	        	      var nCells = nRow.getElementsByTagName('th');
	        	      nCells[1].innerHTML = tViewCnt;
	        	      nCells[2].innerHTML = tClickCnt;
	        	      nCells[3].innerHTML = Math.round(tClickCnt/tViewCnt*100)/100*100;
	        	      nCells[4].innerHTML = Math.round(tSales/tClickCnt*100)/100;
	        	      nCells[5].innerHTML = tSales;
		   		}
	    	    
			});
	    	
		});
	   
	    
	    appControllers.controller('MonthAcController',function($rootScope,$timeout,$scope,$routeParams,$location,$modal){
	    	$rootScope.title='보고서-월별'; // 타이틀 베목
	    	$timeout(function() {
	            //otherService.updateTestService('Mellow Yellow')
	            //console.log('update with timeout fired')
	    		$('#startDate').bootstrapMonthpicker({
			          from: '2015-01',
			          to: moment().format("YYYY-MM"),
			          onSelect: function(value) {
			           
			          }
			    });
		    	$('#endDate').bootstrapMonthpicker({
			          from: '2015-01',
			          to: moment().format("YYYY-MM"),
			          onSelect: function(value) {
			              
			          }
			    });
	        }, 1000);
	    	
	    	$scope.searchForm={startDate:moment().format("YYYY-MM"),endDate:moment().format("YYYY-MM")};
	    	//console.log($scope.searchForm);
	    	
	    	$scope.table = $('#table').dataTable( {
	    		"formatNumber": function ( toFormat ) {
	    		    return toFormat.toString().replace(
	    		      /\B(?=(\d{3})+(?!\d))/g, "'"
	    		    );
	    		},
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/advertiser/monthAc', // 록록전체
		        	method:'GET',
		        	data:function(d){
		        		//d.target="daily";
		        		//d.startDate = $scope.searchForm.startDate;
		        		//d.endDate = $scope.searchForm.endDate;
		        		//d.kind=$scope.searchForm.kind;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
   				            
   					{"targets": 0,"data": "collDate"},
   					{"targets": 1,"data": "viewCnt"},
   					{"targets": 2,"data": "clickCnt"},
   					{"targets": 3,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.clickCnt/full.viewCnt*100)/100*100;
   					},"orderable": false},
   					{"targets": 4,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.sales/full.clickCnt*100)/100;
   					},"orderable": false},
   					
   					{"targets": 5,"data": "sales"}
		   		            
		   		 ],
		   		"fnFooterCallback" : function(nRow, aaData, iStart, iEnd,aiDisplay) {
		   			var tViewCnt = 0;
	        	      var tClickCnt = 0;
	        	      var tSales = 0;
	        	      if (aaData.length > 0) {
	        	       for ( var i = 0; i < aaData.length; i++) {
	        	    	tViewCnt += aaData[i].viewCnt;
	        	        tClickCnt += aaData[i].clickCnt;
	        	        tSales += aaData[i].sales;
	        	       }
	        	      }
	        	     
	        	      var nCells = nRow.getElementsByTagName('th');
	        	      nCells[1].innerHTML = tViewCnt;
	        	      nCells[2].innerHTML = tClickCnt;
	        	      nCells[3].innerHTML = Math.round(tClickCnt/tViewCnt*100)/100*100;
	        	      nCells[4].innerHTML = Math.round(tSales/tClickCnt*100)/100;
	        	      nCells[5].innerHTML = tSales;
		   		}
	    	    
			});
	    	
	    	$scope.onSearch=function(){
	    		$scope.table.api().ajax.reload();
	    	}
	    	
		});
	    appControllers.controller('ReportAdController',function($rootScope,$timeout,$scope,$routeParams,$location,$modal){
	    	$rootScope.title='보고서-광고별'; // 타이틀 베목
	    	$scope.searchForm={};
	    	$scope.cb = function(start, end) {
	    		$scope.searchForm.startDate = start.format('YYYY-MM-DD');
				$scope.searchForm.endDate=end.format('YYYY-MM-DD');
	    		$('#daterange span').html(start.format('YYYY MM DD') + ' ~ ' + end.format('YYYY MM DD'));
	    		if($scope.table)
	    			$scope.table.api().ajax.reload();
	        }
	    	$('#daterange').daterangepicker(
	    			{
	    				ranges: {
	    				   '이번달': [moment().set('date', 1), new Date()],
	    		           'Today': [new Date(), new Date()],
	    		           'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
	    		           'Last 7 Days': [moment().subtract('days', 6), new Date()],
	    		           'Last 30 Days': [moment().subtract('days', 29), new Date()],
	    		           'This Month': [moment().startOf('month'), moment().endOf('month')],
	    		           'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
	    				},
	    				opens: 'right',
	    				locale: {
	    					format: 'YYYY-MM-DD',
	    				},
	    				startDate:moment().set('date', 1),
	    				endDate:new Date()
	    			}, 
	    			$scope.cb
	    	);
	    	
	        $scope.cb(moment().set('date', 1), moment());
	    	$scope.table = $('#table').dataTable( {
	    		"formatNumber": function ( toFormat ) {
	    		    return toFormat.toString().replace(
	    		      /\B(?=(\d{3})+(?!\d))/g, "'"
	    		    );
	    		},
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/advertiser/dailyAcGroupByAdm', // 록록전체
		        	method:'GET',
		        	data:function(d){
		        		//d.target="daily";
		        		//d.startDate = $scope.searchForm.startDate;
		        		//d.endDate = $scope.searchForm.endDate;
		        		//d.kind=$scope.searchForm.kind;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
   				            
   					{"targets": 0,"data": "title"},
   					{"targets": 1,"data": "viewCnt"},
   					{"targets": 2,"data": "clickCnt"},
   					{"targets": 3,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.clickCnt/full.viewCnt*100)/100*100;
   					},"orderable": false},
   					{"targets": 4,"data": "clickRatio","render": function ( data, type, full, meta ) {
   					    return Math.round(full.sales/full.clickCnt*100)/100;
   					},"orderable": false},
   					
   					{"targets": 5,"data": "sales"}
		   		            
		   		 ],
		   		"fnFooterCallback" : function(nRow, aaData, iStart, iEnd,aiDisplay) {
		   			var tViewCnt = 0;
	        	      var tClickCnt = 0;
	        	      var tSales = 0;
	        	      if (aaData.length > 0) {
	        	       for ( var i = 0; i < aaData.length; i++) {
	        	    	tViewCnt += aaData[i].viewCnt;
	        	        tClickCnt += aaData[i].clickCnt;
	        	        tSales += aaData[i].sales;
	        	       }
	        	      }
	        	     
	        	      var nCells = nRow.getElementsByTagName('th');
	        	      nCells[1].innerHTML = tViewCnt;
	        	      nCells[2].innerHTML = tClickCnt;
	        	      nCells[3].innerHTML = Math.round(tClickCnt/tViewCnt*100)/100*100;
	        	      nCells[4].innerHTML = Math.round(tSales/tClickCnt*100)/100;
	        	      nCells[5].innerHTML = tSales;
		   		}
	    	    
			});
	    	
		});
	    var appServices = angular.module('appServices',[]);
		
		
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
	<script type='text/ng-template' id='part/daily_ac.html'>

	<div class="panel panel-default">
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					
				</form>
			</div>
			<div style="float:right">
				
				<div class="btn-group" style='float:right' role="group" aria-label="...">
  					<a type="button" class="btn btn-default active" ng-href="#/daily_ac">일별</a>
  					<a type="button" class="btn btn-default" ng-href="#/month_ac">월별</a>
  					<a type="button" class="btn btn-default" ng-href="#/report_ad">광고별</a>
				</div>
			</div>
			<div class="dataTable_wrapper">
				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>광고명</th>
							<th>노출수</th>
							<th>클릭수</th>
							<th>클릭율</th>
							<th>평균CPC</th>
							<th>광고집행금액</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>합계</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/month_ac.html'>

	<div class="panel panel-default">
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				  날짜범위:<input id="startDate" type="text" size=8  ng-model="searchForm.startDate"/>~<input id="endDate" type="text"  size=8 ng-model="searchForm.endDate"/>
				<button class="btn btn-default" ng-click="onSearch()">검색</button>
            </div>
			<div style="float:right">
				
				<div class="btn-group" style='float:right' role="group" aria-label="...">
  					<a type="button" class="btn btn-default" href="#/daily_ac">일별</a>
  					<a type="button" class="btn btn-default active" ng-href="#/month_ac">월별</a>
  					<a type="button" class="btn btn-default" ng-href="#/report_ad">광고별</a>
				</div>
			</div>
			<div class="dataTable_wrapper">
				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>날짜</th>
							<th>노출수</th>
							<th>클릭수</th>
							<th>클릭율</th>
							<th>평균CPC</th>
							<th>광고집행금액</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>합계</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	</script>
<script type='text/ng-template' id='part/report_ad.html'>

	<div class="panel panel-default">
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					
				</form>
			</div>
			<div style="float:right">
				
				<div class="btn-group" style='float:right' role="group" aria-label="...">
  					<a type="button" class="btn btn-default" href="#/daily_ac">일별</a>
  					<a type="button" class="btn btn-default" ng-href="#/month_ac">월별</a>
  					<a type="button" class="btn btn-default active" ng-href="#/report_ad">광고별</a>
				</div>
			</div>
			<div class="dataTable_wrapper">
				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>날짜</th>
							<th>노출수</th>
							<th>클릭수</th>
							<th>클릭율</th>
							<th>평균CPC</th>
							<th>광고집행금액</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>합계</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
							<th>0</th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

	</script>
</body>

</html>

