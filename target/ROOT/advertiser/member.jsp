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

    <!-- Custom CSS -->
    <link href="css/animate.css" rel="stylesheet">
    <link id="loadBefore" href="css/style.css" rel="stylesheet">
    

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
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.0.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
	
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
       		  	when('/view/:memberSq',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/new',{ //new
	 		  		templateUrl:'part/new.html',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/edit',{ //view
	 		  		templateUrl:'part/edit.html',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/view/'+USERINFO.memberSq
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	    
	    
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,Member,$modal){
	    	
			$scope.item = Member.get({memberSq:$routeParams.memberSq} , function (res){
				
				$scope.item =res.data; 
			});
			
			
			//$scope.item={uid:'paparoti',phone:'010-222-3345',email:'aaa@aa.com',business_num:'222-222-222',hp:'010-22-2222',point:'1,000',bonus:'222',regDate:'2004-02-22',type:'광고주',company_name:'업체명~~~',passwd:'ssss'};
			
	    	//console.log($routeParams.member_sq);
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,Member,$modal){
	    	$rootScope.loadCodeTbl(['member.status']);
	    	$scope.item=new Member({'kind':'A','status':'A','profit':0});
			$scope.memberJoin = function(){
				$scope.item.$save(function(res){
					if(res.success){
						//$location.path('/member');
						alert('가입을 축하드립니다.');
					}else{
						alert(res.msg);
					}
				});
			}
			 
		});
	    appControllers.controller('EditController',function($scope,$routeParams,$location,Member,$modal){
			//$scope.item = Member.get({member_code:$routeParams.member_code} );
			$scope.doUpdate= function(){
				//console.log($scope.item);
				
				Member.update($scope.newItem,function(res){
					if(res.success){
						$location.path('/');
						//alert("업데이트 하였습니다.");
					}else{
						alert(res.msg);
					}
				});
			}
		});
		
	    var appServices = angular.module('appServices',[]);
		
	    appServices.factory('Member',function($resource){
			
			return $resource('/ad/member/member/:memberSq', { member_code: '@memberSq' }, {
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
					<!--
					<tr>
						<td>수익배분</td>
						<td>{{item.profit}}</td>
					</tr>
					-->
					<tr>
						<td>상태</td>
						<td>{{item.status}}</td>
					</tr>
					
					<tr>
						<td>가입일</td>
						<td>{{item.regDate}}</td>
					</tr>
	   			</tbody>
  			</table>
			<p>
  				<a class="btn btn-primary" ng-href="#/member/edit">수정하기</a>
  
			</p>
		</div>
	</div>
</div>

	</script>
	<script type='text/ng-template' id='part/edit.html'>
		
<div class="panel panel-default">
	<div class="panel-body">
		<form class="form-horizontal">

  			<div class="form-group">
    			<label class="col-sm-2 control-label">사용자아이디</label>
    			<div class="col-sm-10">
      				<input type="number" class="form-control" ng-model="item.userid">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">패스워드</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.passwd">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">업체명</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.companyName">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 이름</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.name">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 연락처</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.phone">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 HP</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.hp">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">이메일</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.email">
    			</div>
  			</div>
			<!--

			<div class="form-group">
    			<label class="col-sm-2 control-label">수익배분</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.profit">
    			</div>
  			</div>


			<div class="form-group">
    			<label class="col-sm-2 control-label">상태</label>
    			<div class="col-sm-10">
      				<select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']" ng-init="item.status='A';loadCodeTbl(['member.status'])">
						<option>활성</option>
						<option>비활성</option>
					</select>
    			</div>
  			</div>
			-->
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-10">
      				<button type="button" class="btn btn-default" ng-click="doUpdate()">수정</button>
    			</div>
  			</div>
		</form>
	</div>
</div>
	</script>
	<script type='text/ng-template' id='part/new.html'>

<div class="panel panel-default">
	<div class="panel-heading">
			<h4>
				광고주회원가입
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" back-button>## 전화면으로</a>
				</div>
			</h4>
	</div>
	<div class="panel-body">
		<form class="form-horizontal">

  			<div class="form-group">
    			<label class="col-sm-2 control-label">사용자아이디</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.userid">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">패스워드</label>
    			<div class="col-sm-10">
      				<input type="password" class="form-control" ng-model="item.passwd">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">업체명</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.companyName">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 이름</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.name">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 연락처</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.phone">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">담당자 HP</label>
    			<div class="col-sm-10">
      				<input type="text" class="form-control" ng-model="item.hp">
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">이메일</label>
    			<div class="col-sm-10">
      				<input type="email" class="form-control" ng-model="item.email">
    			</div>
  			</div>
			
			

			<div class="form-group">
    			<label class="col-sm-2 control-label">상태</label>
    			<div class="col-sm-10">
      				<select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
						<option>활성</option>
						<option>비활성</option>
					</select>
    			</div>
  			</div>
			
  			<div class="form-group">
    			<div class="col-sm-offset-2 col-sm-10">
      				<button type="button" class="btn btn-default" ng-click="memberJoin()">가입완료</button>
    			</div>
  			</div>
		</form>
	</div>
</div>

		
	</script>

</body>

</html>

