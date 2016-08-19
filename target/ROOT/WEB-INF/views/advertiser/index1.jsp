<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko" ng-app="app" ng-controller="ListController">

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

    <!-- Custom CSS -->
    <link href="/ad/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/ad/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- DataTables Responsive CSS -->
    <link href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css" rel="stylesheet">
    

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <%@ include file="menu_logo.jsp" %>
            <!-- /.navbar-header -->

            <%@ include file="menu_top.jsp" %>
            <!-- /.navbar-top-links -->
			<%@ include file="menu_left.jsp" %>
        </nav>    

        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    
                        <h1 class="page-header">광고현황</h1>
                    
                    <!-- /.col-lg-12 -->
                </div>
                
                <!-- /.row -->
                <div class="row">
	                <div ng-view></div>
	                
                    
                </div>    
                    
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
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
	
	<script>
	
	
		
		
		var app = angular.module('app',['ngRoute','ngResource','appControllers','appServices','ui.bootstrap']);
		app.run(function($rootScope,$http) {
		    
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
       		  	when('/list',{ //view
	 		  		templateUrl:'part/list.html',
	 		  		controller:'ListController'
	 		  }).
	 		  otherwise({
	 		  		redirectTo:'/list'
	 		  });
		       		  
		}]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($scope,$http,$routeParams,$location,$modal){
	    	
			
	    
	    	
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
		
		
   
	</script>	
		
		
	<script type='text/ng-template' id='part/list.html'>
	
	<div class="panel panel-default">
	<div class="panel-heading">
		<h4>
			광고현황
	
				
		</h4>
	</div>
<!--
	<div class="alert alert-info" role="alert">
		노출수 :1,000 회 클릭수 : 1,304회 광금집행금액
	</div>
-->
	<div class="panel-body">
		<blockquote>
			<p>전체요약정보</p>
		</blockquote>
		<div class="table-responsive"> 
	        <table class="table table-bordered">
	            <thead>
	                <tr>
	                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>광고집행현황</th>
	                    <th>전체광고물</th>
	                    <td>${admCnt}</td>
	                    <th>광고집행광고물</th>
	                    <td>${advertisingCnt}</td>
	                    
	                </tr>
	                <tr>
	                    <th>입찰키워드(1차/2차)</th>
	                    <td>${kwCntInfo.kw1Cnt}/${kwCntInfo.kw2Cnt}</td>
	                    <th>광고클릭수(전일)</th>
	                    <td>100</td>
	                </tr>
	                
	                
	                <tr>
	                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>재정</th>
	                    <th class='info'>포인트 잔액</th>
	                    <td>${memberInfo.point}</td>
	                    <th>이달충전금액</th>
	                    <td>${recentMonthSaveSum}</td>
	                </tr>
	                <tr>
	                    <th>이달 집행금액</th>
	                    <th>${recentMonthUseSum}원</th>
	                    <th>전일 집행금액</th>
	                    <th>${yesterdayUseSum}원</th>
	                </tr>
	            </thead>
	            
	        </table>
	    </div>
	</div>
</div>
	</script>
	

</body>

</html>

