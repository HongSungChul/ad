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
    
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.5/js/bootstrap-select.min.js"></script>
	
	<script>
	
		$(function() {
			
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
			$rootScope.title='기간별 집행보고'; // 타이틀 베목
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
       		  	when('/report_period',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/report_period/:ad_info_sq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/report_period/new',{ 
	 		  		template:'',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/report_period/new/1',{ //new
	 		  		templateUrl:'part/new1.html',
	 		  		controller:'New1Controller'
	 		  	}).
	 		  	when('/report_period/:ad_info_sq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/report_period'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($timeout,$scope,$routeParams,$location,AdInfo,$modal,PageInfo){
	    	
	    	
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
	    				},
	    				startDate: '2015-07-11',
	    				endDate: '2015-08-09'
	    						}, 
	    			$scope.cb
	    	);
	    	$scope.cb = function(start, end) {
	    		$('#daterange span').html(start.format('YYYY MM DD') + ' ~ ' + end.format('YYYY MM DD'));
	        }
	        $scope.cb(moment(), moment());
	    	$scope.table = $('#table').dataTable( {
	    		fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    // Row click
	    		    $(nRow).on('click', function() {
	    		      //console.log('Row Clicked. Look I have access to all params, thank You closures.', this, aData, iDisplayIndex, iDisplayIndexFull);
	    		    });
	    		 
	    		    // Cell click
	    		    $(nRow).on( 'click', 'td', function () {
	    		    	
	    		    	var columnIndex = $(this).index(); 
	    		    	console.log(columnIndex);
	    		    	if(columnIndex==0){
	    		    		location.href="report_adm.jsp?collDate=20100203#";
	    		    	}
	    		    	
	    		    } );
	    		},
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
	    	$('.dataTables_filter input').attr("placeholder", "검색어");
			$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/ad_info/'+aData.ad_info_sq+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});
			$scope.onNew=function(){
				$location.path('/ad_info/new');
			}
		});
	   
	    
	    
	   
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdInfo',function($resource){
			
			return $resource('/ad/reg/ad_info/:ad_info_sq', { ad_info_sq: '@ad_info_sq' }, {
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

		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					
  					
  					<button type="submit" class="btn btn-default">검색</button>
				</form>
			</div>
			<div style="float:right">
				<button type="button" class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 다운로드
				</button>
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
							<th></th>
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

