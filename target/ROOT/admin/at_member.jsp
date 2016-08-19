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
        <%@ include file="at_top_menu.jsp" %>

        <!-- Page Content -->
        <div id="pa ge-wrapper">
            <div class="container-fluid">
                
                
                <!-- /.row -->
                <div class="row" style='padding-top:10px'>
	                
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
       		  	when('/:memberSq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/:memberSq/edit',{ //view
	 		  		templateUrl:'part/edit.html',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/:memberSq/view'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	    
	    
	    appControllers.controller('ViewController',function($rootScope,$scope,$routeParams,$location,Member,$modal){
	    	
			$rootScope.loadCodeTbl(['member.status'],function(){
	    		
	    	});
			Member.get({memberSq:$routeParams.memberSq} , function (res){
				if(res.success) $scope.item =res.data; 
			});
			//$scope.item={uid:'paparoti',phone:'010-222-3345',email:'aaa@aa.com',business_num:'222-222-222',hp:'010-22-2222',point:'1,000',bonus:'222',regDate:'2004-02-22',type:'광고주',company_name:'업체명~~~',passwd:'ssss'};
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						$scope.item.$delete(function(res){
							if(res.success){
								$location.path('/member');
								$scope.$apply();
		    				  }else{
		    					alert(res.msg);
		    				  }
							
						});
					}
				});
			}
	    	//console.log($routeParams.member_sq);
			 
	    	
		});
	    appControllers.controller('NewController',function($scope,$routeParams,$location,Member,$modal){
	    	$scope.item=new Member();
			$scope.addItem = function(){
				$scope.item.$save(function(res){
					if(res.success){
						$location.path('/');
					}else{
						alert(res.msg);
					}
				});
			}
			 
		});
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,Member,$modal){
	    	Member.get({memberSq:$routeParams.memberSq} , function (res){
				if(res.success) $scope.item =res.data; 
			});
			$rootScope.loadCodeTbl(['member.status'],function(){
	    		
	    	});
			$scope.doUpdate= function(){
				//console.log($scope.item);
				//$location.path('/');
				//if(true) return;
				if(!$scope.myForm.$valid){
					alert('입력오류!!!');
					return;
				}
				Member.update($scope.item,function(res){
					if(res.success){
						$location.path('/'+$routeParams.memberSq+'/view');
						//alert("업데이트 하였습니다.");
					}else{
						alert(res.msg);
					}
				});
			}
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('Member',function($resource){
			
			return $resource('/ad/admin/member/:memberSq', { memberSq: '@memberSq' }, {
				update:{ method:'PUT'}
			  });
		});
		
		
   
	</script>	
		
		
	
	<script type='text/ng-template' id='part/view.html'>

<div class="panel panel-default">
		
	<div class="panel-body">
		<div class="table-responsive">
  			<table class="table">
      			<tbody>
					<tr>
						<td>회원아이디</td>
						<td>{{item.userid}}</td>

					</tr>
					<tr>
						<td>패스워드</td>
						<td>{{item.passwd}}</td>
					</tr>
					<tr>
						<td>업체명</td>
						<td>{{item.companyName}}</td>
					</tr>

					<tr>
						<td>담당자 이름</td>
						<td>{{item.name}}</td>
					</tr>
					<tr>
						<td>담당자 연락처</td>
						<td>{{item.phone}}</td>

					</tr>
					<tr>
						<td>담당자 HP</td>
						<td>{{item.hp}}</td>

					</tr>
					<tr>
						<td>이메일</td>
						<td>{{item.email}}</td>

					</tr>
					
					<tr>
						<td>포인트</td>
						<td>{{item.point}}</td>
					</tr>
					
					<tr>
						<td>상태</td>
						<td>{{getCodeDesc('member.status',item.status)}}</td>
					</tr>
					
					<tr>
						<td>가입일</td>
						<td>{{item.regDate}}</td>
					</tr>
					<tr>
						<td>변경일</td>
						<td>{{item.modDate}}</td>
					</tr>
	   			</tbody>
  			</table>
			<p>
  				<a class="btn btn-primary" ng-href="#/{{item.memberSq}}/edit">수정하기</a>
  
			</p>
		</div>
	</div>
</div>

	</script>
	<script type='text/ng-template' id='part/edit.html'>
		
		
<div class="panel panel-default">
	<div class="panel-body">
		<form class="form-horizontal" name="myForm" novalidate>

  			<div class="form-group">
    			<label class="col-sm-2 control-label">사용자아이디</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.userid" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">패스워드</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" ng-model="item.passwd" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">업체명</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.companyName" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 이름</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.name" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 연락처</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.phone" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 HP</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.hp" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">이메일</label>
    			<div class="col-sm-10">
      				<input type="email" class="form-control" ng-model="item.email" required>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">상태</label>
    			<div class="col-sm-10">
      				<select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
					</select>
    			</div>
  			</div>
			
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-10">
      				<button type="button" class="btn btn-primary" ng-click="doUpdate()">수정</button>
    			</div>
  			</div>
		</form>
	</div>
</div>

		

	</script>
	

</body>

</html>

