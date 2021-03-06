<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
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
    <!-- /#wrapper -->
     <div id="contextMenu" class="dropdown clearfix">
	    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
	      <li id='skwd' class='skwd'><span tabindex="-1" style='cursor:pointer;padding-left:20px;'>2차카테고리추가</span></li>
	      <li class="divider skwd"></li>
	      <li class="manufacture"><span tabindex="-1" style='cursor:pointer;padding-left:20px;'>정보</span></li>
	      <li class="divider"></li>
	      <li><span tabindex="-1" style='cursor:pointer;padding-left:20px;'>수정하기</span></li>
	      <li><span tabindex="-1" style='cursor:pointer;padding-left:20px;'>삭제하기</span></li>
	    </ul>
    </div>
    <!-- 
    <div id="categoryEdit" class="col-sm-4" style="position;absolute;display:none;z-index:10000">
	    <div id="new_category" class="panel panel-default">
		  <div class="panel-body">
		    <div class='form-inline' role="form">
		  	   <div class="form-group">
			      <input class="form-control" id="category_name" type="text" placeholder="카테고리명">
			  </div>
			  <button type="button" id='ok_btn' class="btn btn-default">확인</button>
			  <button type="button" id='cancel_btn' class="btn btn-default">취소</button>
			  </div>
		  </div>
		</div>
    </div>
    -->
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
		    $rootScope.title="카테고리관리";
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
		       		when('/new',{ //new
		       			templateUrl:'part/new.html',
		 		  		controller:'NewController'
		 		  	}).
		 		  	when('/new1',{ //new
		       			templateUrl:'part/new1.html',
		 		  		controller:'New1Controller'
		 		  	}).
		 		  	when('/new2',{ //new
		       			templateUrl:'part/new2.html',
		 		  		controller:'New2Controller'
		 		  	}).
		 		  	otherwise({
		 		  		redirectTo:'/'
		 	  });
		       		  
		}]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($rootScope,$scope,$http,$routeParams,$location,$modal){
	    	$scope.selectedItem = undefined;
	    	$("#contextMenu").hide();
			$.fn.contextMenu = function (settings) {

		        return this.each(function () {

		            // Open context menu
		            $(this).on("contextmenu", function (e) {
		                // return native menu if pressing control
		                if (e.ctrlKey) return;
		                
		                //open menu
		                $(settings.menuSelector)
		                    .data("invokedOn", $(e.target))
		                    .show()
		                    .css({
		                        position: "absolute",
		                        left: e.pageX,
		          		      	top: e.pageY
		                    })
		                    .off('click')
		                    .on('click', function (e) {
		                        $(this).hide();
		                
		                        var $invokedOn = $(this).data("invokedOn");
		                        var $selectedMenu = $(e.target);
		                        //console.log($invokedOn);
		                        settings.menuSelected.call(this, $invokedOn, $selectedMenu,e.pageX,e.pageX);
		                });
		                
		                return false;
		            });

		            //make sure menu closes on any click
		            $(document).click(function () {
		                $(settings.menuSelector).hide();
		                //$('#categoryEdit').hide();
		            });
		        });
		        
		          

		    };
	    	
		    $scope.loadTree=function(){
		    	$http.get('/ad/api/category').success(function(res){
		    		if(res.success){
		    			$scope.initTree(res.data);
		    		}
		    	});
		    }
	    	$scope.initTree=function(treeData){
	    		$scope.treeData=treeData;
	    		$('#treeview1').treeview({
	  	          	data: treeData,
	  	          	levels:1
	  	        });
		    	$('#treeview1').on('nodeSelected', function(event, data) {
		  			 
		    		//console.log(data);
		    		$scope.selectedItem = data;
		    		$(event.target).contextMenu({
		  			    menuSelector: "#contextMenu",
		  			    menuSelected: function (invokedOn, selectedMenu,x,y) {
		  			    	
		  			      	if(selectedMenu.text()=='2차카테고리추가'){
		  			    	    $scope.onNew2();
		  			      	}else if(selectedMenu.text()=='수정하기'){
		  			      		$scope.editNode();
		  			      	}else if(selectedMenu.text()=='삭제하기'){
		  			      		$scope.deleteNode();
		  			      	}else if(selectedMenu.text()=='정보'){
		  			      		$scope.onView();
		  			      	}
		  			        //$('#categoryEdit').data( "data", { first: 16, last: "pizza!" } );
		  			    }
		  			});
		  		});
	    	};
	    	
	    	$scope.editNode=function(){ //1차,2차 수정하기
	    		var templateUrl;
	    		var controller;
	    		if($scope.selectedItem.parentId){ // 2차수정 
	    			templateUrl='part/new2.html';
	    			controller= 'New2Controller'
	    		}else{ // 1차수정 
	    			templateUrl='part/new1.html';
	    			controller= 'New1Controller';
	    		}
	    		$rootScope.newItem=$scope.selectedItem.data;
	    		var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: templateUrl,
				      controller: controller,
				      size: undefined,
				      resolve: {
					        item: function () {
					          return $scope.selectedItem;
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			       //$rootScope.newItem.address.post_num = newItem.post_num;
			    	$scope.loadTree();
			       
			    }, function () {
			      	
			    });
	    	}
	  		$scope.deleteNode=function(){
	  			sitem = $('#treeview1').treeview('getSelected', 0)[0];
	  			if(sitem==undefined){
	  				return;
	  			}
	  			if(confirm('삭제하시겠습니까?')){
	  				if(sitem.parentId==undefined){
		  				var cg1  = new Cg1({cg1Sq:sitem.data.cg1Sq});
						cg1.$delete(function(res){
							if(res.success){	
								$scope.loadTree();
							}else{
		    					alert(response.msg);
		    				 }
						});
	  				}else{
	  					var cg2  = new Cg2({cg2Sq:sitem.data.cg2Sq});
						cg2.$delete(function(res){
							if(res.success){	
								$scope.loadTree();
							}else{
		    					alert(response.msg);
		    				 }
						});
	  				}
	  			}
	  		}
	  		$scope.onNew2=function(){
	  			sitem = $('#treeview1').treeview('getSelected', 0)[0];
	  			//console.log(sitem);
	  			if(sitem==undefined){
	  				return;
	  			}
	  			
	  			var sortOrder=1;
	  			if(sitem.data.kw2Sq){ // 2차선택
	  				sortOrder = sitem.data.sortOrder+1;
	  			}else{
	  				if(sitem.nodes){
	  					sortOrder = sitem.nodes.length+1;
	  				}
	  			}
	  			$rootScope.newItem = {status:'B',cg1Sq:sitem.data.cg1Sq,sortOrder:sortOrder};
	  			var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: 'part/new2.html',
				      controller: 'New2Controller',
				      size: undefined,
				      resolve: {
					        item: function () {
					          return $scope.selectedItem;
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			       //$rootScope.newItem.address.post_num = newItem.post_num;
			    	$scope.loadTree();
			       
			    }, function () {
			      	
			    });
	  		}
	    	$scope.onView=function(){
	    		
	    		var sitem = $('#treeview1').treeview('getSelected', 0)[0];
	    		$rootScope.newItem = sitem.data;
	    		if(sitem.parentId!=undefined){ // 
	    			$rootScope.newItem.parentName = $('#treeview1').treeview('getNode', sitem.parentId).data.name;	
	    		}
	    		
	    		
	    		
	    		var templateUrl;
	    		var controller;
	    		if(sitem.parentId!=undefined){ // 2차수정 
	    			templateUrl='part/view2.html';
	    			controller='View2Controller'
	    		}else{ // 1차수정 
	    			templateUrl='part/view1.html';
	    			controller= 'View1Controller';
	    		}
    			var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: templateUrl,
				      controller: controller,
				      size: undefined,
				      resolve: {
					        item: function () {
					          return $scope.selectedItem;
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			       //$rootScope.newItem.address.post_num = newItem.post_num;
			    	$scope.loadTree();
			    	
			    }, function () {
			    	  	
			    });
			    
			    
				    
				
	    	}
	    	$scope.onNew1=function(){
	    		//console.log($('#treeview1'));
	    		sitem = $('#treeview1').treeview('getSelected', 0)[0];
	  			if(sitem==undefined){
	  				$rootScope.newItem = {status:'B',sortOrder:$scope.treeData.length+1};
	  			}else{
	  			
	  			//var sortOrder=1;
	  				//console.log(sitem);
		  			if(sitem.parentId!=undefined){ // 2차.
		  				//sortOrder = sitem.data.sortOrder+1;
		  				sitem = $('#treeview1').treeview('getNode', sitem.parentId);
		  			}
		  			//console.log(sitem);
		  			var sortOrder= sitem.data.sortOrder;
		  			$rootScope.newItem = {status:'B',sortOrder:sortOrder};
	  			}
	  			
	    		//$rootScope.newItem = {status:'B'};
	    		var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: 'part/new1.html',
				      controller: 'New1Controller',
				      size: undefined,
				      resolve: {
					        item: function () {
					          return $scope.selectedItem;
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			       //$rootScope.newItem.address.post_num = newItem.post_num;
			    	$scope.loadTree();
			       
			       
			    }, function () {
			      	
			    });
			}
	    	$scope.loadTree();
		});
	    appControllers.controller('New1Controller',function($http,$rootScope,$scope,$routeParams,$location,$modal,item,Cg1,$modalInstance){
		
	    	//console.log(item);
	    	
			$scope.cancel = function () {
			    
				$modalInstance.dismiss('cancel');
			};
			$scope.dataSave=function(){
				//$modalInstance.dismiss('cancel');
				//console.log($rootScope.newItem);
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				if($rootScope.newItem.cg1Sq){ // 수정
					Cg1.update($rootScope.newItem,function(res){
						if(res.success){
							//$location.path('/'+$rootScope.newItem.adInfoSq+'/view').replace();
							$modalInstance.close(true);
						}else{
							alert(res.msg);
						}
					})
				}else{
					//console.log(aaa);
					//console.log($rootScope.newItem);
					Cg1.save($rootScope.newItem,function(res){
						if(res.success){
							//$location.path('/').replace();
							$modalInstance.close(true);
						}else{
							alert(res.msg);
						}
					})
				}
			}
		});
	    appControllers.controller('New2Controller',function($http,$rootScope,$scope,$routeParams,$location,$modal,Cg2,item,$modalInstance){
	    	//$rootScope.newItem = item;//{status:'B'};
			$scope.cancel = function () {
			    
				$modalInstance.dismiss('cancel');
			};
			$scope.dataSave=function(){
				//$modalInstance.dismiss('cancel');
				
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				if($rootScope.newItem.cg2Sq){ // 수정
					Cg2.update($rootScope.newItem,function(res){
						if(res.success){
							//$location.path('/'+$rootScope.newItem.adInfoSq+'/view').replace();
							$modalInstance.close(true);
						}else{
							alert(res.msg);
						}
					})
				}else{
					Cg2.save($rootScope.newItem,function(res){
						if(res.success){
							//$location.path('/').replace();
							$modalInstance.close(true);
						}else{
							alert(res.msg);
						}
					})
				}
			}
		});
	    appControllers.controller('View1Controller',function($http,$rootScope,$scope,$routeParams,$location,$modal,item,$modalInstance){
	    	//$rootScope.newItem = {status:'B'};
	    	
			$scope.cancel = function () {
				//console.log('ssss');
				$modalInstance.dismiss('cancel');
			};
			
		});
	    appControllers.controller('View2Controller',function($http,$rootScope,$scope,$routeParams,$location,$modal,item,$modalInstance){
	    	//$rootScope.newItem = {status:'B'};
			$scope.cancel = function () {
			    
				$modalInstance.dismiss('cancel');
			};
			
		});
	    var appServices = angular.module('appServices',[]);
		
	    appServices.factory('Cg1',function($resource){
			
			return $resource('/ad/api/cg1/:cg1Sq', { cg1Sq: '@cg1Sq' }, {
				update:{ method:'PUT'}
			  });
		});
		appServices.factory('Cg2',function($resource){
			
			return $resource('/ad/api/cg2/:cg2Sq', { cg2Sq: '@cg2Sq' }, {
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
						
	<div class="panel-body">
		
		<div style="float:right;">
					<button type="button" class="btn btn-danger btn-sm" ng-click="onNew1()">
						<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 1차카테고리 생성
					</button>
		</div>
		<br>
		<br>
		<div id="treeview1" class="text-left"></div>
	<div>
				
</div>
	</script>
	<script type='text/ng-template' id='part/new1.html'>

		<div class="modal-header" >
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">1차카테고리생성</h4>
	    </div>

		<div class="modal-body">
			<form class="form-horizontal" name="myForm" novalidate>

				
				<div class="form-group">
    				<label class="col-sm-2 control-label">카테고리명</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" ng-model="newItem.name" required>
    				</div>
  				</div>
				<div class="form-group">
    				<label class="col-sm-2 control-label">정렬순서</label>
    				<div class="col-sm-10">
      					<input type="number" class="form-control" ng-model="newItem.sortOrder" required>
    				</div>
  				</div>
				<div class="form-group">
    				<label class="col-sm-2 control-label">상태</label>
    				<div class="col-sm-10">
      					<select ng-model="newItem.status" ng-options="code.key as code.description for code in codetbl['keyword.status']" ng-init="loadCodeTbl(['keyword.status'])">
						</select>
    				</div>
  				</div>
			</form>
		
		</div>
 		<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="dataSave()">확인</button>
	    </div>
	
	</script>	
	<script type='text/ng-template' id='part/new2.html'>
		<div class="modal-header" >
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">2차카테고리생성</h4>
	    </div>
		<!-- /.panel-heading -->
		<div class="modal-body">
			<form class="form-horizontal"  name="myForm" novalidate>
<!--
				<div class="form-group">
    				<label class="col-sm-2 control-label">1차카테고리명</label>
    				<div class="col-sm-10">
      					 신발
    				</div>
  				</div>
-->  				
				<div class="form-group">
    				<label class="col-sm-2 control-label">카테고리명</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" ng-model="newItem.name" required>
    				</div>
  				</div>
				<div class="form-group">
    				<label class="col-sm-2 control-label">정렬순서</label>
    				<div class="col-sm-10">
      					<input type="number" class="form-control" ng-model="newItem.sortOrder"  required>
    				</div>
  				</div>
				<div class="form-group">
    				<label class="col-sm-2 control-label">상태</label>
    				<div class="col-sm-10">
      					<select ng-model="newItem.status" ng-options="code.key as code.description for code in codetbl['keyword.status']" ng-init="loadCodeTbl(['keyword.status'])">
						</select>
    				</div>
  				</div>
			</form>
			
		</div>
		<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
			<button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="dataSave()">확인</button>
	    </div>
	</script>	
	<script type='text/ng-template' id='part/view1.html'>
		<div class="modal-header" >
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">1차카테고리정보</h4>
	    </div>
		<div class="modal-body">
			<div class="table-responsive">
  				<table class="table">
      				<tbody>
						<tr>
							<td>1차카테고리명</td>
							<td>{{newItem.name}}</td>

						</tr>
						
						<tr>
							<td>상태</td>
							<td>{{newItem.status}}</td>
						</tr>
						<tr>
							<td>정렬순서</td>
							<td>{{newItem.sortOrder}}</td>
						</tr>
						<tr>
							<td>등록일</td>
							<td>{{newItem.regDate}}</td>
						</tr>
						<tr>
							<td>수정일</td>
							<td>{{newItem.modDate}}</td>
						</tr>

					</tbody>
  				</table>
			</div>
		</div>
  		<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">확인</button>

	    </div>

	</script>
	<script type='text/ng-template' id='part/view2.html'>
		<div class="modal-header" >
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">2차카테고리정보</h4>
	    </div>
		<div class="modal-body">
			<div class="table-responsive">
  				<table class="table">
      				<tbody>
						<tr>
							<td>1차카테고리명</td>
							<td>{{newItem.parentName}}</td>

						</tr>
						<tr>
							<td>2차카테고리명</td>
							<td>{{newItem.name}}</td>
						</tr>
						<tr>
							<td>상태</td>
							<td>{{newItem.status}}</td>
						</tr>
						<tr>
							<td>정렬순서</td>
							<td>{{newItem.sortOrder}}</td>
						</tr>
						<tr>
							<td>등록일</td>
							<td>{{newItem.regDate}}</td>
						</tr>
						<tr>
							<td>수정일</td>
							<td>{{newItem.modDate}}</td>
						</tr>
					</tbody>
  				</table>
			</div>
		</div>
  		<div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">확인</button>

	    </div>

	</script>

</body>

</html>

