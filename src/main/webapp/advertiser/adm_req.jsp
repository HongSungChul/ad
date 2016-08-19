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
			$rootScope.title='광고신청'; // 타이틀 베목
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
       		  	when('/',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/:admReqSq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/new',{ 
	 		  		template:'',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/new/1',{ //new
	 		  		templateUrl:'part/new1.html',
	 		  		controller:'New1Controller'
	 		  	}).
	 		  	when('/new/2',{ //new
	 		  		templateUrl:'part/new2.html',
	 		  		controller:'New2Controller'
	 		  	}).
	 		  	when('/new/3',{ //new
	 		  		templateUrl:'part/new3.html',
	 		  		controller:'New3Controller'
	 		  	}).
	 		  	when('/:admReqSq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($rootScope,$timeout,$scope,$routeParams,$location,AdmReq,$modal){
	    	
	    	
	    	
	    	$scope.table = $('#table').dataTable( {
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "bLengthChange": false, // hide show entries
	    	    "bFilter": false,
    			"paging": true,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/advertiser/admReq', // 록록전체
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
    			"columnDefs": [ 
    				            
					{"targets": 0,"data": "regDate"},
					{"targets": 1,"data": "kwd","render": function ( data, type, full, meta ) {
						var s="";
						$.each(full.kwList,function(i,e){
							s+= e.kw1Name +'-'+ e.kw2Name+'<br>';
						});
					    return s;
					},"orderable": false},
					{"targets": 2,"data": "kind","render": function ( data, type, full, meta ) {
					    return $rootScope.getCodeDesc('admReq.kind',data);
					},"orderable": false},
					{"targets": 3,"data": "result","render": function ( data, type, full, meta ) {
						return $rootScope.getCodeDesc('admReq.result',data);
					}},
					{"targets": 4,"data": "backWhy","render": function ( data, type, full, meta ) {
						if(data==null) return "";						
						return data;
					}}
		            
		         ]
			});
	    	$rootScope.loadCodeTbl(['admReq.kind','admReq.result'],function(){
	    		$.each(  $scope.table.fnGetData(), function( index, ele ){
	    			$scope.table.fnUpdate(ele,index );
				});
	    		
	    	});
	    	$('.dataTables_filter input').attr("placeholder", "검색어");
			$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/'+aData.admReqSq+'/view';
			    $rootScope.newItem=aData;
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});
			$scope.onNew=function(){
				$location.path('/new');
			}
		});
	   
	    
	    
	    appControllers.controller('ViewController',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal){
	    	
	    	//alert(11111);
	    	//$('#loading').loadingOverlay({loadingText: '로딩중'});
	    	//$scope.item={admReqSq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	/*AdmReq.get({admReqSq:$routeParams.admReqSq} , function (res){
				if(res.success){	
					//$scope.item =res.data;
				}
				$('#loading').loadingOverlay('remove');
			});*/
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						AdmReq.delete({admReqSq:$routeParams.admReqSq},function(response){
							if(response.success){
								$location.path('/');
		    				  }else{
		    					alert(response.msg);
		    				  }
							
						});
					}
				});
			}
	    	
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal){
	    	
	    	$rootScope.newItem = {};
		    $location.path('/new/1').replace();
			
	    });
		appControllers.controller('New1Controller',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal){
			$scope.table = $('#table').dataTable( {
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    //"sScrollY" : "250",
	            //"sScrollX" : "100%",
	    	    "bLengthChange": false, // hide show entries
	    	    "bFilter": false,
    			"paging": true,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/advertiser/adInfo', // 록록전체
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
    			"columnDefs": [ 
					
					{"targets": 0,"data": "adInfoSq"},
		            {"targets": 1,"data": "regDate"},
		            {"targets": 2,"data": "imgUri","render": function ( data, type, full, meta ) {
		                return '<img src='+data+' width=50 height=50>';
		            },"orderable": false},
		            {"targets": 3,"data": "adInfo","render": function ( data, type, full, meta ) {
						return full.title+'<br>'+full.description+'<br>'+full.link;
					    
					}}
		            
		         ]
			});
			$scope.subMenuName = "광고정보 선택";
			
			$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    //var gUrl = '/admReq/'+aData.admReqSq+'/view';
			    //$location.path(gUrl);
			    //$scope.$apply();
			    //console.log('dddd');
			    $rootScope.newAdInfo = aData;
			    $location.path('/new/2');
			    $scope.$apply();
			});
			$scope.next=function(){
				$location.path('/new/2');
			}
			 
		});
		appControllers.controller('New2Controller',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal,Cg1,Cg2,Kw1,Kw2){
				
			$scope.next=function(){
				if($rootScope.kwList.length!=0){
					$location.path('/new/3');
				}else{
					alert('키워드를 선택해주세요');
				}
			} 
			$scope.$watch(
	                "cg1",
	                function( newValue, oldValue ){
	                	//$scope.selectedRegion=[];
						if(newValue){
							
							Cg2.query({cg1Sq:newValue.cg1Sq},function(res){
								//if(res.success){
									$scope.cg2List = res.data;
								//}
							});
							
						}
						$scope.isNew=false;
	                }
	            );
	    	$scope.$watch(
	                "cg2",
	                function( newValue, oldValue ){
	                	//console.log(newValue,oldValue);
	                	
	                	
	                	//$scope.selectedRegion=[];
	                	//console.log(newValue);
						if(!$.isEmptyObject(newValue)){
							Kw1.query({cg2Sq:newValue.cg2Sq},function(res){
								//if(res.success){
									$scope.kw1List = res.data;
								//}
							});
						}else{
							//$scope.isNew=false;
						}
	                }
	            );
	    	$scope.cg1List=[];
	    	Cg1.query({},function(res){
	    		//console.log(res);
				if(res.success){
					$scope.cg1List = res.data;
					//console.log($scope.cg1List);
					//$scope.$apply();
				}
			});
	    	
	    	$scope.selectedKw1=function(item){
	    		//console.log(item);
	    		$rootScope.newKw1 = item;
	    		Kw2.query({kw1Sq:item.kw1Sq},function(res){
					if(res.success){
						$scope.kw2List = res.data;
						//$scope.$apply();
					}
				});
	    	}
	    	$scope.onDelete=function(item){
	    		for(i=0; i<$rootScope.kwList.length; i++){
	    			if($rootScope.kwList[i].kw2Sq==item.kw2Sq){
	    				$rootScope.kwList.splice(i,1); 
	    				break;
	    			}
	    			
	    			
	    		}
	    	}
	    	$scope.selectedKw2=function(item){
	    		
	    		
	    		for(i=0; i<$rootScope.kwList.length; i++){
	    			if($rootScope.kwList[i].kind==item.kind){
	    				$rootScope.kwList.splice(i,1);
	    				break;
	    			}
	    			
	    			
	    		}
	    		$rootScope.kwList.push(item);
	    	}
	    	$rootScope.kwList=[];
		});
		
		appControllers.controller('New3Controller',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal,AdmReq){
			
			$scope.dataSave=function(){
				req ={adInfo:$rootScope.newAdInfo,kwList:$rootScope.kwList};
				AdmReq.save(req,function(res){
					if(res.success){
						//$modalInstance.close(true);
						$location.path('/');
					}else{
						alert(res.msg);
					}
				})
				
			} 
		});
	   
		
		
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal){
	    	
	    	//console.log('dddd');
			//$rootScope.newItem={admReqSq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	var admReq  = new AdmReq({admReqSq:$routeParams.admReqSq});
	    	admReq.$get(function(res){
				if(res.success){	
					$rootScope.newItem =res.data;
					$location.path('/new/1').replace();
				}else{
					alert(res.msg);
				}
			});
			
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdmReq',function($resource){
			
			return $resource('/ad/advertiser/admReq/:admReqSq', { admReqSq: '@admReqSq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
	    
		appServices.factory('Kw1',function($resource){
			
			return $resource('/ad/api/kw1/:kw1Sq', { kw2Sq: '@kw1Sq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
		appServices.factory('Kw2',function($resource){
			
			return $resource('/ad/api/kw2/:kw2Sq', { kw2Sq: '@kw2Sq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
		appServices.factory('Cg1',function($resource){
			
			return $resource('/ad/api/cg1/:cg1Sq', { kw2Sq: '@cg1Sq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
		appServices.factory('Cg2',function($resource){
			
			return $resource('/ad/api/cg2/:cg2Sq', { kw2Sq: '@cg2Sq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
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
			<div style="float:right;padding-bottom:10px;">
				<button type="button" class="btn btn-danger btn-sm"  ng-click="onNew()">
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 신규광고 신청
				</button>
			</div>
			<div class="dataTable_wrapper">
				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>날짜</th>
							<th>키워드</th>
							<th>구분</th>
							<th>요청상태</th>
							<th>반려사유</th>
						</tr>
					</thead>
					
				</table>
			</div>
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/view.html'>

	<div class="panel panel-default">
		<!--
		<div class="panel-heading">
			<h4>
				{{title}} 조회
				<div class="btn-group pull-right">
					<button class="btn btn-default btn-sm" back-button>## 조회화면으로</button>
				</div>
			</h4>
		</div>
		-->
		<!-- /.panel-heading -->
		<div class="panel-body">
			
			<div class="table-responsive">
  				<table class="table">
      				<tbody>
						<tr>
							<td>광고타이틀</td>
							<td>{{newItem.title}}</td>

						</tr>
						<tr>
							<td>썸네일</td>
							<td><img ng-src='{{newItem.imgUri}}'></td>

						</tr>

						<tr>
							<td>설명</td>
							<td>{{newItem.description}}</td>

						</tr>
						<tr>
							<td>링크URL</td>
							<td>{{newItem.link}}</td>

						</tr>
						<tr>
							<td>구분</td>
							<td>{{getCodeDesc('admReq.kind',newItem.kind)}}</td>

						</tr>
						<tr>
							<td>상태</td>
							<td>{{getCodeDesc('admReq.result',newItem.result)}}</td>

						</tr>
						<tr>
							<td>반려사유</td>
							<td>{{newItem.backWhy}}</td>

						</tr>				
						<tr>
							<td>신청일</td>
							<td>{{newItem.regDate}}</td>
						</tr>
	   			</tbody>
  			</table>
<!--
			<p>
  				<a class="btn btn-primary" ng-href="#/{{item.admReqSq}}/edit">수정하기</a>
  				<a class="btn btn-primary" ng-click="doDelete()">삭제</a>
			</p>
-->
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/new1.html'>

	<div class="panel panel-default">
		<!--
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		-->
		<div class="panel-body">
			
      				<table id="table" class="display" cellspacing="0" width="100%">
        				<thead>
            				<tr>
                				<th>No</th>
								<th>등록일</th>
								<th>이미지</th>
								<th>소개정보</th>
            				</tr>
            				
        				</thead>
					</table>
    		

				
  			
		</div>
	</div>


	</script>
	
	<script type='text/ng-template' id='part/new2.html'>

	<div class="panel panel-default">
<!--
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" back-button>## 이전화면으로</a>
				</div>
			</h4>
		</div>
	-->	
		<div class="panel-body">
			
      				<form class="form-horizontal">

  						<div class="form-group" style="text-align: center;vertical-align: middle;">
    						<label class="col-sm-2 control-label">카테고리선택</label>
    						<div class="col-sm-4" style="text-align: center;vertical-align: bottom;">
      							<select ng-model="cg1" ng-options="item.name for item in cg1List">
									<option value=''>1차카테고리</option>
								</select>
								<select ng-model="cg2" ng-options="item.name for item in cg2List">
									<option value=''>2차카테고리</option>
								</select>
    						</div>
							<div class="col-sm-2">
								<button type="button" class="btn btn-primary">조회</button>
							</div>
  						</div>

					</form>
    				<hr style="width: 100%; color: black; height: 1px; background-color:black;" />
					<div class="row">
        				<div class="col-xs-6 col-sm-4">
							<div class="panel panel-default">
					
  								<div class="panel-heading">1차키워드</div>
  								
  
  								<div class="list-group">
    								<button  class="list-group-item btn-block" ng-repeat="item in kw1List" ng-click="selectedKw1(item)">{{item.name}}</button>
  								</div>
							</div>
						</div>
        				<div class="col-xs-6 col-sm-4">
							<table class="table table-bordered">
      							<thead>
        							<tr>
          								<th>브랜드</th>
          								<th>분류</th>
        							</tr>
      							</thead>
      							<tbody>
        							<tr>
          								<td>
											<ul cl ass="list-group">
    											<li cla ss="list-group-item" ng-show="item.kind=='A'" ng-click="selectedKw2(item)" ng-repeat="item in kw2List">{{item.name}}</li>
  											</ul>
										</td>
          								<td>
											<ul cla ss="list-group">
    											<li cla ss="list-group-item" ng-show="item.kind=='B'" ng-click="selectedKw2(item)" ng-repeat="item in kw2List">{{item.name}}</li>
  											</ul>
										</td>
        							</tr>
      							</tbody>
    						</table>
						</div>
        				<div class="col-xs-6 col-sm-4">
							<div class="panel panel-default">
					
  								<div class="panel-heading">선택키워드</div>
  								
  
  								<ul class="list-group">
    								<li class="list-group-item" ng-repeat="item in kwList">{{item.name}} &nbsp; <button type="button" class="btn btn-default btn-xs" ng-click="onDelete(item)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
    							</ul>
							</div>
						</div>
      				</div>

    				<button type="button" class="btn btn-danger btn-block" ng-click="next()">다음</button>
  			</div>


  			
			
		</div>
	</div>

		

	</script>
	<script type='text/ng-template' id='part/new3.html'>

	<div class="panel panel-default">
<!--
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" back-button>## 이전화면으로</a>
				</div>
			</h4>
		</div>
	-->	
		<div class="panel-body">
			
      				<table class="table table-bordered">
						<tbody>
							<tr>
  								<th style="text-align: center;vertical-align: middle;">광고정보</th>
								<td>
									<img ng-src="{{newAdInfo.imgUri}}" width=100 height=100>
									<ul style="display:inline-block;vertical-align: middle;">
										<li>{{newAdInfo.title}}</li>
										<li>{{newAdInfo.description}}</li>
										<li>{{newAdInfo.link}}</li>
									</ul>
									
								</td>
							</tr>
							<tr>
  								<th style="text-align: center;vertical-align: middle;">광고정보</th>
								<td>
									<ul style="display:inline-block;vertical-align: middle;">
										<li ng-repeat="item in kwList">{{newKw1.name}}-{{item.name}}</li>
										
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
    			
    				<button type="button" class="btn btn-danger btn-block" ng-click="dataSave()">저장완료</button>
  			</div>
  			
			
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

