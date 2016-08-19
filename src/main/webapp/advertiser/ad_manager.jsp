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
			$rootScope.title='광고물관리'; // 타이틀 베목
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
       		  	when('/ad_manager',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/ad_manager/:ad_manager_sq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/ad_manager/new',{ 
	 		  		template:'',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/ad_manager/new/1',{ //new
	 		  		templateUrl:'part/new1.html',
	 		  		controller:'New1Controller'
	 		  	}).
	 		  	when('/ad_manager/new/2',{ //new
	 		  		templateUrl:'part/new2.html',
	 		  		controller:'New2Controller'
	 		  	}).
	 		  	when('/ad_manager/new/3',{ //new
	 		  		templateUrl:'part/new3.html',
	 		  		controller:'New3Controller'
	 		  	}).
	 		  	when('/ad_manager/:ad_manager_sq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/ad_manager'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($timeout,$scope,$routeParams,$location,AdInfo,$modal,PageInfo){
	    	
	    	
	    	
	    	
			$scope.onNew=function(){
				$location.path('/ad_manager/new');
			}
			
			$scope.onBid=function(){
				var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: 'part/bid.html',
				      controller: 'BidController',
				      size: undefined,
				      resolve: {
					        item: function () {
					          return {};
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			       
			       
			    }, function () {
			      	
			    });
			}
			
		});
	   
	    
	    appControllers.controller('BidController',function($http,$rootScope,$scope,$routeParams,$location,$modal,item,$modalInstance){
			$scope.search_name="";
			
			$scope.cancel = function () {
			    
				$modalInstance.dismiss('cancel');
			};
			
			
		});
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	//alert(11111);
	    	//$('#loading').loadingOverlay({loadingText: '로딩중'});
	    	$scope.item={ad_manager_sq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	/*AdInfo.get({ad_manager_sq:$routeParams.ad_manager_sq} , function (res){
				if(res.success){	
					//$scope.item =res.data;
				}
				$('#loading').loadingOverlay('remove');
			});*/
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						AdInfo.delete({ad_manager_sq:$routeParams.ad_manager_sq},function(response){
							if(response.success){
								$location.path('/ad_manager');
		    				  }else{
		    					alert(response.msg);
		    				  }
							
						});
					}
				});
			}
	    	
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
		    
		    $location.path('/ad_manager/new/1').replace();
			
	    });
		appControllers.controller('New1Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
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
    			"paging": false,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			"data":[{ad_info_sq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:2,regDate:'2015.0.09',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:3,regDate:'2015.0.09',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:4,regDate:'2015.0.09',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:5,regDate:'2015.0.01',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:6,regDate:'2015.0.01',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:7,regDate:'2015.0.01',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:8,regDate:'2015.0.01',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'},
    			        {ad_info_sq:9,regDate:'2015.0.01',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'}]
	    	    ,
    			"columnDefs": [ 
					
					{"targets": 0,"data": "ad_info_sq"},
					{"targets": 1,"data": "regDate"},
		            {"targets": 2,"data": "photo_url","render": function ( data, type, full, meta ) {
						return '<img src="'+data+'" width=50 height=50>'
					}},
		            {"targets": 3,"data": "description"}
		            
		         ]
			});
			$scope.subMenuName = "광고정보 선택";
			$scope.initUpload=function(){
				  $('#fileupload').fileupload({
				        url: '/ad/file/upload',
				        dataType: 'json',
				        //autoUpload:true,
				        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
				        formData:{service:22},
				        done: function (e, data) {
				            $.each(data.result.files, function (index, file) {
				            	console.log(file);
				            	console.log(file.url);
				                //$('<p/>').text(file.name).appendTo('#files');
				                $rootScope.newItem.photo_url = file.url;
				                $scope.$apply();
				                //$scope.save();
				            });
				        },
				        progressall: function (e, data) {
				            /*var progress = parseInt(data.loaded / data.total * 100, 10);
				            $('#progress .progress-bar').css(
				                'width',
				                progress + '%'
				            );*/
				        }
				   });
			    }
			$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    //var aData = $scope.table.fnGetData(this);
			    //var gUrl = '/ad_manager/'+aData.ad_manager_sq+'/view';
			    //$location.path(gUrl);
			    //$scope.$apply();
			    //console.log('dddd');
			    $location.path('/ad_manager/new/2');
			    $scope.$apply();
			});
			$scope.next=function(){
				$location.path('/ad_manager/new/2');
			}
			 
		});
		appControllers.controller('New2Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
				
			$scope.next=function(){
				$location.path('/ad_manager/new/3');
			} 
		});
		
		appControllers.controller('New3Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
			
			$scope.dataSave=function(){
				$location.path('/ad_manager');
			} 
		});
	   
		
		
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	//console.log('dddd');
			$rootScope.newItem={ad_manager_sq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
			$location.path('/ad_manager/new/1').replace();
			
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdInfo',function($resource){
			
			return $resource('/ad/reg/ad_manager/:ad_manager_sq', { ad_manager_sq: '@ad_manager_sq' }, {
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

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 목록
				<div class="btn-group pull-right">
					<button class="btn btn-default btn-sm" ng-click="onNew()">## 광고중지</button>
					<button class="btn btn-default btn-sm" ng-click="onNew()">## 광고정보수정</button>
					<button class="btn btn-default btn-sm" ng-click="onNew()">## 광고삭제</button>
 
					
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			<div class="dataTable_wrapper">
				<table id="table" class="table" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>광고명</th>
							<th>키워드</th>
							<th>광고상태</th>
							<th>광고순위</th>
							<th>입찰상태</th>
							<th>입찰</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th rowspan=3><input type='radio' name=a>맥북광고</th>
							<td>노트북-맥북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							<td rowspan=3><button class="btn btn-default btn-sm" ng-click='onBid()'>입찰</button></td>
						</tr>
						<tr>
							<td>노트북-노트북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							
						</tr>
						<tr>
							<td>노트북-울트라북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							
						</tr>
						<tr>
							<th rowspan=3><input type='radio' name=a>맥북광고</th>
							<td>노트북-맥북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							<td rowspan=3><button class="btn btn-default btn-sm"  ng-click='onBid()'>입찰</button></td>
						</tr>
						<tr>
							<td>노트북-노트북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							
						</tr>
						<tr>
							<td>노트북-울트라북</td>
							<td>ON</td>
							<td>2</td>
							<td>입찰대기</td>
							<td>입찰완료</td>
							
						</tr>
					</tbody>

				</table>
			</div>
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/view.html'>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 조회
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/ad_manager">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<div class="table-responsive">
  				<table class="table">
      				<tbody>
						<tr>
							<td>광고타이틀</td>
							<td>{{item.title}}</td>

						</tr>
						<tr>
							<td>썸네일</td>
							<td><img ng-src='{{item.photo_url}}'></td>

						</tr>

						<tr>
							<td>설명</td>
							<td>{{item.description}}</td>

						</tr>
						<tr>
							<td>링크URL</td>
							<td>{{item.link}}</td>

						</tr>
			
						<tr>
							<td>등록일</td>
							<td>{{item.regDate}}</td>
						</tr>
	   			</tbody>
  			</table>
			<p>
  				<a class="btn btn-primary" ng-href="#/ad_manager/{{item.ad_manager_sq}}/edit">수정하기</a>
  				<a class="btn btn-primary" ng-click="doDelete()">삭제</a>
			</p>
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/new1.html'>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/ad_manager">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			
      				<table id="table" class="display" cellspacing="0" width="100%">
        				<thead>
            				<tr>
                				<th rowspan="2">No</th>
                				<th rowspan="2">등록일</th>
								<th colspan="2" align="center">광고정보</th>
            				</tr>
            				<tr>
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
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" back-button>## 이전화면으로</a>
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			
      				<form class="form-horizontal">

  						<div class="form-group">
    						<label class="col-sm-2 control-label">카테고리선택</label>
    						<div class="col-sm-2">
      							<select >
									<option value='ddddd'>1차카테고리선택</option>
									<option value='ddddd'>여성의류</option>
									<option value='ddddd'>남성의류</option>
								</select>
    						</div>
							<div class="col-sm-2">
      							<select >
									<option value='ddddd'>여성브랜드의류</option>
									<option value='ddddd'>언더웨어</option>
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
    								<a  class="list-group-item" onclick="javascript:alert(1)">청바지</a>
									<a  class="list-group-item" onclick="javascript:alert(1)">치마</a>
									<a  class="list-group-item" onclick="javascript:alert(1)">브라우스</a>
									<a  class="list-group-item" onclick="javascript:alert(1)">양복</a>
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
    											<li cla ss="list-group-item">운동화</li>
    											<li cla ss="list-group-item">패션</li>
    											<li cla ss="list-group-item">ㅇㅇㅇ</li>
    											<li cla ss="list-group-item">ㅋㅋㅋ</li>
    											<li cla ss="list-group-item">ㅇㅇㅇ</li>
  											</ul>
										</td>
          								<td>
											<ul cla ss="list-group">
    											<li cl ass="list-group-item">운동화</li>
    											<li cl ass="list-group-item">패션</li>
    											<li cl ass="list-group-item">ㅇㅇㅇ</li>
    											<li cl ass="list-group-item">ㅋㅋㅋ</li>
    											<li cl ass="list-group-item">ㅇㅇㅇ</li>
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
    								<li class="list-group-item">1차-운동화 &nbsp; <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
    								<li class="list-group-item">패션&nbsp; <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
    								<li class="list-group-item">ㅇㅇㅇ&nbsp; <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
    								<li class="list-group-item">ㅋㅋㅋ&nbsp; <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
    								<li class="list-group-item">ㅇㅇㅇ&nbsp; <button type="button" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></li>
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
		<div class="panel-heading">
			<h4>
				{{title}} {{subMenuName}}
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" back-button>## 이전화면으로</a>
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			
      				<table class="table table-bordered">
						<tbody>
							<tr>
  								<th style="text-align: center;vertical-align: middle;">광고정보</th>
								<td>
									<img src='' width=100 height=100>
									<ul style="display:inline-block;vertical-align: middle;">
										<li>타이틀</li>
										<li>설명</li>
										<li>URL</li>
									</ul>
									
								</td>
							</tr>
							<tr>
  								<th style="text-align: center;vertical-align: middle;">광고정보</th>
								<td>
									<ul style="display:inline-block;vertical-align: middle;">
										<li>1차-2차</li>
										<li>1차-2차</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
    			
    				<button type="button" class="btn btn-danger btn-block" ng-click="dataSave()">저장</button>
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
<script type='text/ng-template' id='part/bid.html'>
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">입찰</h4>
</div>
<div class="modal-body">
	<table id="table" class="table" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th rowspan=2>키워드</th>
							<th colspan=3>순위별입찰가</th>
							<th rowsapn=2>내순위</th>
							<th rowspan=2>현재가격</th>
							<th rowspan=2>입찰가</th>
							<th rowspan=2>입찰</th>
						</tr>
						<tr>
							<th>1</th>
							<th>2</th>
							<th>3</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>노트북-맥북</td>
							<td>100</td>
							<td>120</td>
							<td>110</td>
							<td>2</td>
							<td>1,000</td>
						<td><input type='text'></td>
							<td><button class="btn btn-default btn-sm" ng-cl ick='onBid()'>입찰</button></td>
						</tr>
<tr>
							<th>노트북-맥북</td>
							<td>100</td>
							<td>120</td>
							<td>110</td>
							<td>2</td>
							<td>1,000</td>
						<td><input type='text'></td>
							<td><button class="btn btn-default btn-sm" ng-cl ick='onBid()'>입찰</button></td>
						</tr>
<tr>
							<th>노트북-맥북</td>
							<td>100</td>
							<td>120</td>
							<td>110</td>
							<td>2</td>
							<td>1,000</td>
						<td><input type='text'></td>
							<td><button class="btn btn-default btn-sm" ng-cl ick='onBid()'>입찰</button></td>
						</tr>
				</tbody>
			</table>
</div>

<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary">인출요청</button>
</div>
</script>
</body>

</html>

