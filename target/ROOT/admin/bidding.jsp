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
		    $rootScope.title="광고물";
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
	       		when('/view',{ //view
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
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($scope,$routeParams,$location,Bidding,$modal){
	    	
	    	$scope.table = $('#table').dataTable( {
	    		fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    // Row click
	    		    $(nRow).on('click', function() {
	    		      //console.log('Row Clicked. Look I have access to all params, thank You closures.', this, aData, iDisplayIndex, iDisplayIndexFull);
	    		    });
	    		 
	    		    // Cell click
	    		    $(nRow).on( 'click', 'td', function () {
	    		    	
	    		    	var columnIndex = $(this).index(); 
	    		    	if(columnIndex==0){
	    		    		detailDashboard(aData.memberSq);
	    		    	}else if(columnIndex==1){
	    		    		detailMember(aData.memberSq);
	    		    	}else if(columnIndex==3){
	    		    		detailPoint(aData.memberSq);
	    		    	}
	    		    	
	    		    } );
	    		  },
	    		  "language": {
		    	        "emptyTable":     "관련된 데이타가 없습니다."
		    	    },
		    	    "paging": true,
	    			"bInfo": false,
	    			"bSort":true,
	    			"bFilter": false,
	    			"order":[],
	    			"processing": true,
	    	        "serverSide": true,
	    			"ajax": {
			        	url:'/ad/admin/bidding',
			        	method:'GET',
			        	dataSrc: function ( json ) {
			        		
			        		return json.data;
			        	}
			        },
			        "columnDefs": [
			   					{"targets": 0,"data": "regDate"},
			   					{"targets": 1,"data": "company","render": function ( data, type, full, meta ) {
			   						return full.companyName+'('+full.userid+')';
			   					}},
			   					{"targets": 2,"data": "title"},
			   					{"targets": 3,"data": "kwd","render": function ( data, type, full, meta ) {
			   						return full.kw1Name+'-'+full.kw2Name;
			   					},"orderable": false},
			   					
			   					{"targets": 4,"data": "point","render": function ( data, type, full, meta ) {
			   						return data;
			   					}}
			   		         ]
			        
			});
	    	
			/*$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/member/'+aData.member_code+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});*/
			$scope.onNew=function(){
				$location.path('/new');
			}
		});
	   
	    
	    
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,Member,$modal){
	    	
			$scope.item = Member.get({member_code:$routeParams.member_code} , function (res){
				
				$scope.item =res.data; 
			});
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						$scope.item.$delete(function(res){
							if(res.success){
								$location.path('/');
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
	    appControllers.controller('EditController',function($scope,$routeParams,$location,Bidding,$modal){
			$scope.item = Member.get({member_code:$routeParams.member_code} );
			$scope.doUpdate= function(){
				//console.log($scope.item);
				$scope.item.$update(function(res){
					if(res.success){
						$location.path('/member');
						//alert("업데이트 하였습니다.");
					}else{
						alert(res.msg);
					}
				});
			}
		});
		
	    var appServices = angular.module('appServices',[]);
		
	    appServices.factory('Bidding',function($resource){
			
			return $resource('/ad/admin/bidding/:biddingSq', { biddingSq: '@biddingSq' }, {
				update:{ method:'PUT'}
			  });
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

	<div class="panel panel-default">
		
		<ul class="nav nav-tabs">
			<ul class="nav nav-tabs">
			<li role="presentation" ><a href="adm.jsp">전체광고</a></li>
			<li role="presentation" class="active"><a href="bidding.jsp">입찰광고</a></li>			  
			<li role="presentation"><a href="advertising.jsp">집행광고</a></li>  
		</ul>
			  
			</ul>
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
  					<div class="form-group">
						<label>항목:</label>
    					<select>
							<option>분류</option>
							<option>1차키워드</option>
							<option>업체명</option>
							
						</select>
						
  					</div>
					
  					<div class="form-group">
    					<label for="pwd">검색어:</label>
    					<input type="text" class="form-control" id="pwd">
  					</div>
  					
  					<button type="submit" class="btn btn-default">검색</button>
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
							<th>입찰일</th>
							<th>업체명(아이디)</th>
							<th>광고명</th>
							<th>키워드</th>
							<th>입찰액</th>
						</tr>
					</thead>
					
				</table>
			
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/view.html'>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 조회
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
		<div class="table-responsive">
  <table class="table">
      <tbody>
			<tr>
				<td>핸드펀번호</td>
				<td>{{item.hp}}</td>

			</tr>
			<tr>
				<td>기기번호</td>
				<td>{{item.dev_id}}</td>

			</tr>

			<tr>
				<td>이름</td>
				<td>{{item.name}}</td>

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
				<td>레그아이디</td>
				<td>{{item.reg_id}}</td>

			</tr>
			<tr>
				<td>상태</td>
				<td>{{item.status}}</td>
			</tr>
			<tr>
				<td>푸시여부</td>
				<td>{{item.push_yn}}</td>
			</tr>
<tr>
				<td>등록일</td>
				<td>{{item.regDate}}</td>
			</tr>
	   </tbody>
  </table>
<p>
  <a class="btn btn-primary" ng-href="#/{{item.member_code}}/edit">수정하기</a>
  <a class="btn btn-primary" ng-click="doDelete()">삭제</a>
</p>
</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/edit.html'>
		
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 수정
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<form class="form-horizontal">
 
  <div class="form-group">
    <label class="col-sm-2 control-label">핸드폰번호</label>
    <div class="col-sm-10">
      <input type="number" class="form-control" ng-model="item.hp">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">기기번호</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.dev_id">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">이름</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.name">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">이메일</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" ng-model="item.email">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">보유포인트</label>
    <div class="col-sm-10">
      <input type="number" class="form-control" ng-model="item.point">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">레그아이디</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.reg_id">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">상태</label>
    <div class="col-sm-10">
      <select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']">
						</select>
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">콜수신여부</label>
    <div class="col-sm-10">
      <select ng-model="item.push_yn" ng-options="code.key as code.description for code in codetbl['yn']">
						</select>
    </div>
  </div>

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
				{{title}} 생성
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/member">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<form class="form-horizontal">

  <div class="form-group">
    <label class="col-sm-2 control-label">핸드폰번호</label>
    <div class="col-sm-10">
      <input type="number" class="form-control" ng-model="item.hp">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">기기번호</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.dev_id">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">이름</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.name">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">이메일</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" ng-model="item.email">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">보유포인트</label>
    <div class="col-sm-10">
      <input type="number" class="form-control" ng-model="item.point">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">레그아이디</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" ng-model="item.reg_id">
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">상태</label>
    <div class="col-sm-10">
      <select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']" ng-init="item.status='A';loadCodeTbl(['member.status'])">
						</select>
    </div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">콜수신여부</label>
    <div class="col-sm-10">
      <select ng-model="item.push_yn" ng-options="code.key as code.description for code in codetbl['yn']" ng-init="item.push_yn='Y';loadCodeTbl(['yn'])">
						</select>
    </div>
  </div>
  
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="button" class="btn btn-default" ng-click="addItem()">등록</button>
    </div>
  </div>
</form>
		</div>
	</div>

		
	</script>

</body>

</html>

