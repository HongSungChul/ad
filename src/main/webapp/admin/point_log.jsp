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

    <!-- Bootstrap Core CSS -->
    <link href="/ad/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/ad/css/metisMenu.min.css" rel="stylesheet">

	<link href="css/animate.css" rel="stylesheet">
    <link id="loadBefore" href="css/style.css" rel="stylesheet">
    
    
    <!-- Custom Fonts -->
    <link href="/ad/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- DataTables Responsive CSS -->
    <link href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />
    <link href="/ad/css/ad.css" rel="stylesheet">

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
    
    <script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <script src="/ad/js/metisMenu.min.js"></script>
	<script src="//code.angularjs.org/1.3.15/angular.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-route.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-resource.js"></script>
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.0.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
	<script src="/ad/js/bootstrap-treeview.js"></script>
	<script src="/ad/js/common.js"></script>
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
		    $rootScope.title="포인트 관리";
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
       		  	when('/',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($rootScope,$scope,$routeParams,$location,$modal){
	    	
	    	$scope.searchForm={gubun:'',kind:''};
	    	$rootScope.loadCodeTbl(['pointLog.kind','pointLog.gubun','pointLog.A','pointLog.B'],function(){
	    		$.each(  $scope.table.fnGetData(), function( index, ele ){
	    			$scope.table.fnUpdate(ele,index );
				});
	    		
	    	});
	    	
	    	$scope.cb = function(start, end) {
				console.log(start,end);
				$scope.searchForm.startDate = start.format('YYYY-MM-DD');
				$scope.searchForm.endDate=end.format('YYYY-MM-DD');
	    		$('#daterange span').html($scope.searchForm.startDate + ' ~ ' + $scope.searchForm.endDate);
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
    				}//,
    				//startDate: '2015-07-11',
    				//endDate: '2015-08-09'
    			}, 
    			$scope.cb
	    	);
			
			$scope.cb(moment().set('date', 1), moment());
	        $scope.searchItem={}
	        $scope.kinds=[];
	        $scope.$watch(
	                "searchForm.gubun",
	                function( newValue, oldValue ){
	                	$scope.kinds=[];
						if(newValue){
							$rootScope.loadCodeTbl(['pointLog.'+newValue],function(){
								$scope.kinds=$rootScope.codetbl['pointLog.'+newValue];
							});
						}
	                }
	         );
	        $scope.onSearch=function(){
	        	$scope.table.api().ajax.reload();
	        }; 
	        $scope.table = $('#table').dataTable( {
	        	fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    // Row click
	    		    $(nRow).on('click', function() {
	    		      //console.log('Row Clicked. Look I have access to all params, thank You closures.', this, aData, iDisplayIndex, iDisplayIndexFull);
	    		    });
	    		 
	    		    // Cell click
	    		    $(nRow).on( 'click', 'td', function () {
	    		    	
	    		    	var columnIndex = $(this).index(); 
	    		    	//var aData = $scope.table.fnGetData(this);
	    		    	//console.log(columnIndex);
	    		    	if(columnIndex==0){
	    		    		//detailDashboard(1);
	    		    	}else if(columnIndex==1){
	    		    		detailMember(1);
	    		    	}else if(columnIndex==2){
	    		    		//detailPoint(1);
	    		    		//$scope.onView(aData);
	    		    	}
	    		    	
	    		    } );
	    		  },
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다."
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"sort":[],
		        "ajax": {
		        	url:'/ad/admin/pointLog', // 록록전체
		        	data:function(d){
		        		d.gubun = $scope.searchForm.gubun;
		        		d.searchType = $scope.searchForm.searchType;
		        		d.startDate=$scope.searchForm.startDate;
		        		d.endDate=$scope.searchForm.endDate;
		        		d.query=$scope.searchForm.query;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
					{"targets": 0,"data": "regDate"},
					{"targets": 1,"data": "userInfo","render": function ( data, type, full, meta ) {
   					    return full.companyName+'('+full.userid+')';
   					},"orderable": false},
					{"targets": 2,"data": "point"},
					{"targets": 3,"data": "gubunName","render": function ( data, type, full, meta ) {
		                return $rootScope.getCodeDesc('pointLog.gubun',full.gubun);
		            },"orderable": false},
		            {"targets": 4,"data": "kindName","render": function ( data, type, full, meta ) {
		                return $rootScope.getCodeDesc('pointLog.kind',full.kind);
		            },"orderable": false},
		            {"targets": 5,"data": "descriptionName","render": function ( data, type, full, meta ) {
		            	if(data==null) return "";
		            	return data;
		            },"orderable": false},
		         ]
	    	
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
	<script type='text/ng-template' id='part/list.html'>

	<div class="panel panel-default">
		
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form" name="myForm">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					<div class="form-group">
						
						
						<select ng-model="searchForm.gubun" ng-options="code.key as code.description for code in codetbl['pointLog.gubun']">
							<option value=''>구분</option>
						</select>
						<select ng-model="searchForm.kind" ng-options="code.key as code.description for code in kinds">
							<option value=''>전체</option>
						</select>
						
							<label>대상:</label>
    					<select ng-model="searchForm.searchType">
							<option>선택하세요</option>
							<option value='A'>아이디</option>
							<option value='B'>업체명</option>
						</select>
						
  					</div>
					
  					<div class="form-group ">
    					<label for="pwd">검색어:</label>
    					<input type="text" class="form-control" ng-model="searchForm.query">
  					</div>
  					
  					<button type="button" class="btn btn-default" ng-click="onSearch()">검색</button>
				</form>
			</div>
			<div style="float:right">
				
				<button type="button" class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 다운로드
				</button>
			</div>

				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>날짜</th>
							<th>업체명(아이디)</th>
							<th>포인트</th>
							<th>유형</th>
							<th>대상</th>
							<th>비고</th>
							
						</tr>
					</thead>
					
				</table>
			
		</div>
	</div>

	</script>
	

</body>

</html>

