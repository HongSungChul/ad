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

<body style="padding:10px">

    <div id="wrapper">

        <!-- Navigation -->
        
        <!-- Page Content -->
        <div id="pa ge-wrapper">
            <div class="container-fluid">
                
                <!-- /.row -->
                <div class="row" style="padding-top:10px;">
	                
	                <div>
	                
	                
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
								<div class="dataTable_wrapper">
									<table id="table" class="display" cellspacing="0" width="100%">
										<thead>
											<tr>
												<th colspan=4>광고신청 현황</th>
												<th colspan=2 rowspan=2>광고집행정보</th>
												
												
											</tr>
											<tr>
												<th>구분</th>
												<th>광고물</th>
												<th>1차키워드</th>
												<th>2차키워드</th>
											</tr>
											
										</thead>
										<tbody>
											<tr>
												<td>전체</td>
												<td>0</td>
												<td>1</td>
												<td>2</td>
												<td>전일광고비</td>
												<td>3</td>
											</tr>
											<tr>
												<td>광고 ON</td>
												<td>0</td>
												<td>1</td>
												<td>2</td>
												<td>오늘의 광고비</td>
												<td>3</td>
											</tr>
											<tr>
												<td>광고 OFF</td>
												<td>0</td>
												<td>1</td>
												<td>2</td>
												<td>예치금잔액</td>
												<td>3</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					
	                </div>
                    
                </div>    
                    
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    
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
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($scope,$routeParams,$location,$modal){
	    	
			
	    	//console.log($routeParams.member_sq);
	    	$scope.table = $('#table').dataTable( {
	    		"bLengthChange": false, // hide show entries
	    	    "bFilter": false,
    			"paging": false,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			"aoColumnDefs": [{
    			      "bSortable": false,
    			      "aTargets": [0]
    			    }, {
    			      "bSortable": true,
    			      "aTargets": [1]
    			    }, {
    			      "bSortable": false,
    			      "aTargets": [2]
    			    }],
    			
			});
	    	
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

</body>

</html>

