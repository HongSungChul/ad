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
			$rootScope.title='광고정보'; // 타이틀 베목
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
	       		when('/:adInfoSq/view',{ //view
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
	 		  	when('/:adInfoSq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($timeout,$scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	
	    	
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
		        	url:'/ad/advertiser/adInfo', // 록록전체
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
    			"columnDefs": [ 
    				            
					
		            {"targets": 0,"data": "adInfoSq"},
		            {"targets": 1,"data": "regDate"},
		            {"targets": 2,"data": "imgUri","render": function ( data, type, full, meta ) {
		                return '<img src="http://brandbox.kr'+data+'" width=50 height=50>';
		            },"orderable": false},
		            {"targets": 3,"data": "adInfo","render": function ( data, type, full, meta ) {
						return full.title+'<br>'+full.description+'<br>'+full.link;
					    
					}}
		            
		         ]
	    	    
			});
	    	
	    	$('.dataTables_filter input').attr("placeholder", "검색어");
			$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/'+aData.adInfoSq+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});
			$scope.onNew=function(){
				$location.path('/new');
			}
		});
	   
	    
	    
	    appControllers.controller('ViewController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	//alert(11111);
	    	//$('#loading').loadingOverlay({loadingText: '로딩중'});
	    	//$scope.item={adInfoSq:1,regDate:'2015.0.10',imgUri:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	/*AdInfo.get({adInfoSq:$routeParams.adInfoSq} , function (res){
				if(res.success){	
					//$scope.item =res.data;
				}
				$('#loading').loadingOverlay('remove');
			});*/
			var adInfo  = new AdInfo({adInfoSq:$routeParams.adInfoSq});
			adInfo.$get(function(res){
				if(res.success){	
					$rootScope.newItem =res.data;
				}
			});
			
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						
						var adInfo  = new AdInfo({adInfoSq:$routeParams.adInfoSq});
						adInfo.$delete(function(res){
							if(res.success){	
								$location.path('/');
							}else{
		    					alert(response.msg);
		    				 }
						});
					}
				});
			}
	    	
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
		    $rootScope.newItem = {};
		    $location.path('/new/1').replace();
			
	    });
		appControllers.controller('New1Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
			
			$scope.subMenuName = angular.isDefined($rootScope.newItem.adInfoSq)?"수정":"생성";
			$scope.initUpload=function(){
				  $('#fileupload').fileupload({
				        url: '/ad/file/upload',
				        dataType: 'json',
				        //autoUpload:true,
				        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
				        formData:{service:22},
				        done: function (e, data) {
				            $.each(data.result.files, function (index, file) {
				            	//console.log(file);
				            	//console.log(file.url);
				                //$('<p/>').text(file.name).appendTo('#files');
				                $rootScope.newItem.imgUri = file.url;
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
			$scope.submitForm=function(isValid){
				//alert($scope.myForm.$valid);
				//console.log($scope.myForm);
				//if(true) return;
				if(!isValid){
					alert('필드 입력 오류!!!');
					return;
				}
				if($rootScope.newItem.adInfoSq){ // 수정
					AdInfo.update($rootScope.newItem,function(res){
						if(res.success){
							$location.path('/'+$rootScope.newItem.adInfoSq+'/view').replace();
						}else{
							alert(res.msg);
						}
					})
				}else{
					AdInfo.save($rootScope.newItem,function(res){
						if(res.success){
							$location.path('/').replace();
						}else{
							alert(res.msg);
						}
					})
				}
				
			}
			 
		});
	    
	   
		
		
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	
			var adInfo  = new AdInfo({adInfoSq:$routeParams.adInfoSq});
			adInfo.$get(function(res){
				if(res.success){	
					$rootScope.newItem =res.data;
					$location.path('/new/1').replace();
				}else{
					alert(res.msg);
				}
			});
			
			
			
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdInfo',function($resource){
			
			return $resource('/ad/advertiser/adInfo/:adInfoSq', { adInfoSq: '@adInfoSq' }, {
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
			<div style="float:right">
				
				<button type="button" class="btn btn-danger btn-sm"  ng-click="onNew()">
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 생성
				</button>
			</div>
			<div class="dataTable_wrapper">
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
	</div>

	</script>
	<script type='text/ng-template' id='part/view.html'>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 조회
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/adInfo">## 조회화면으로</a>
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
							<td>등록일</td>
							<td>{{newItem.regDate}}</td>
						</tr>
	   			</tbody>
  			</table>
			<p>
  				<a class="btn btn-primary" ng-href="#/adInfo/{{newItem.adInfoSq}}/edit">수정하기</a>
  				<a class="btn btn-primary" ng-click="doDelete()">삭제</a>
			</p>
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/new1.html'>

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 등록
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/adInfo">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			<form class="form-horizontal" name="myForm" ng-submit="submitForm(myForm.$valid)" novalidate>
 
 			<div class="form-group">
 			   <label class="col-sm-2 control-label">광고타이틀</label>
 			   <div class="col-sm-10">
 			     <input type="text"  class="form-control" ng-model="newItem.title" required>
 			   </div>
 			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">썸네일</label>
    			<div class="col-sm-10">
     			 	
					<span class="btn btn-success fileinput-button">
        				<i class="glyphicon glyphicon-plus"></i>
        				<span>Select files...</span>
        				<input    ng-init="initUpload();" id="fileupload" type="file" name="files[]" data-url="/ad/file/upload" required multiple>
					</span>
					<img ng-src='{{newItem.imgUri}}' width="60" height="60"/>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">설명</label>
    			<div class="col-sm-10">
      				<textarea class="form-control" ng-model="newItem.description" required></textarea>
    			</div>
  			</div>
			<div class="form-group">
    			<label class="col-sm-2 control-label">링크URL</label>
    			<div class="col-sm-10">
      				<input type="url" class="form-control" ng-model="newItem.link" required>
    			</div>
  			</div>
			<div class="form-group">
  				<button type='submit' class="btn btn-danger btn-block" >확인</button>
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

