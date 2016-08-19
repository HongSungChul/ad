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

    <title>매체사 어드민 페이지</title>
	<link href="/ad/css/ad.css" rel="stylesheet">
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
                    <h1 class="page-header">{{title}}</h1>
                </div>
                <div class="row" id="loading">
	                <div ng-view></div>
                </div>
            </div>
            
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
		var app = angular.module('app',['ngRoute','ngResource','appControllers','appServices','ui.bootstrap']);
		app.run(function($rootScope,$http) {
			$rootScope.title='광고코드'; // 타이틀 베목
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
       		  	when('/ad_unit',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/ad_unit/:ad_unit_sq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/ad_unit/new',{ 
	 		  		template:'',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/ad_unit/new/1',{ //new
	 		  		templateUrl:'part/new1.html',
	 		  		controller:'New1Controller'
	 		  	}).
	 		  	when('/ad_unit/new/2',{ //new
	 		  		templateUrl:'part/new2.html',
	 		  		controller:'New2Controller'
	 		  	}).
	 		  	when('/ad_unit/new/3',{ //new
	 		  		templateUrl:'part/new3.html',
	 		  		controller:'New3Controller'
	 		  	}).
	 		  	when('/ad_unit/:ad_unit_sq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/ad_unit'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($timeout,$scope,$routeParams,$location,AdInfo,$modal,PageInfo){
	    	
	    	
	    	
	    	
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
    			"data":[{ad_info_sq:1,regDate:'2015.0.10',service_name:'코코코',ad_unit_name:'타이틀:~~~~'},
    			        {ad_info_sq:1,regDate:'2015.0.10',service_name:'코코코',ad_unit_name:'타이틀:~~~~'},
    			        {ad_info_sq:1,regDate:'2015.0.10',service_name:'코코코',ad_unit_name:'타이틀:~~~~'},
    			        {ad_info_sq:1,regDate:'2015.0.10',service_name:'코코코',ad_unit_name:'타이틀:~~~~'}]
	    	    ,
    			"columnDefs": [ 
					
					{"targets": 0,"data": "regDate"},
					{"targets": 1,"data": "service_name"},
					{"targets": 2,"data": "ad_unit_name"},
					{"targets": 3,"data": "copy","render": function ( data, type, full, meta ) {
						return '<button class="btn btn-primary">복사</button'
					}}
		            
		         ]
			});
	    	$scope.onNew=function(){
				$location.path('/ad_unit/new');
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
	    	$scope.item={ad_unit_sq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	/*AdInfo.get({ad_unit_sq:$routeParams.ad_unit_sq} , function (res){
				if(res.success){	
					//$scope.item =res.data;
				}
				$('#loading').loadingOverlay('remove');
			});*/
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						AdInfo.delete({ad_unit_sq:$routeParams.ad_unit_sq},function(response){
							if(response.success){
								$location.path('/ad_unit');
		    				  }else{
		    					alert(response.msg);
		    				  }
							
						});
					}
				});
			}
	    	
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
		    
		    $location.path('/ad_unit/new/1').replace();
			
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
			    //var gUrl = '/ad_unit/'+aData.ad_unit_sq+'/view';
			    //$location.path(gUrl);
			    //$scope.$apply();
			    //console.log('dddd');
			    $location.path('/ad_unit/new/2');
			    $scope.$apply();
			});
			$scope.next=function(){
				if($( "input[name='f']")[0].checked){
				$location.path('/ad_unit/new/2');
				}else{
					$location.path('/ad_unit/new/3');
				}
			}
			 
		});
		appControllers.controller('New2Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
				
			$scope.next=function(){
				$location.path('/ad_unit/new/3');
			} 
		});
		
		appControllers.controller('New3Controller',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
			
			$scope.dataSave=function(){
				$location.path('/ad_unit');
			} 
		});
	   
		
		
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdInfo,$modal){
	    	
	    	//console.log('dddd');
			$rootScope.newItem={ad_unit_sq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
			$location.path('/ad_unit/new/1').replace();
			
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdInfo',function($resource){
			
			return $resource('/ad/reg/ad_unit/:ad_unit_sq', { ad_unit_sq: '@ad_unit_sq' }, {
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
				{{title}} 목록
				<div class="btn-group pull-right">
					<button class="btn btn-default btn-sm" ng-click="onNew()">## 광고코드 생성</button>
				</div>
			</h4>
		</div>
		
		<div class="panel-body">
			
				<table id="table" class="table" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>생성일</th>
							<th>서비스명</th>
							<th>광고단위명</th>
							<th>스크립트복사</th>
						</tr>
					</thead>
					

				</table>
			
		</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/view.html'>
<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 조회
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/ad_unit">## 조회화면으로</a>
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
  				<a class="btn btn-primary" ng-href="#/ad_unit/{{item.ad_unit_sq}}/edit">수정하기</a>
  				<a class="btn btn-primary" ng-click="doDelete()">삭제</a>
			</p>
		</div>
	</div>
</div>
	</script>
	
	<script type='text/ng-template' id='part/new2.html'>
<div class="col-lg-12">
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
			
      		<ul>

				<li style='padding:5px'>
					<input type=radio name='f' checked>
					<img width=100 height=100>
					[이미지형]
				</li>
				<li style='padding:5px' name='f'>
					<input type=radio>
					<img width=100 height=100>
					[리스트형]
				</li>
			</ul>	
<form class="form-horizontal">

 <div class="form-group">
    <label class="col-sm-2 control-label">광고단위명</label>
    <div class="col-sm-10">
      <input type='text'>
    </div>
	
  </div>

  
</form>	
    		<button type="button" class="btn btn-danger btn-block" ng-click="dataSave()">광고코드 생성</button>
  			


  			
			
		</div>
	</div>
</div>
		

	</script>
	<script type='text/ng-template' id='part/new3.html'>
<div class="col-lg-12">
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
			
      				<ul>

				<li style='padding:5px;display:inline'>
					<input type=radio name='f' checked>
					<img width=100 height=100>
					[풀사이즈]
				</li>
				<li style='padding:5px;display:inline'>
					<input type=radio name='f'>
					<img width=100 height=100>
					[하프사이즈]
				</li>
<li style='padding:5px;display:inline'>
					<input type=radio name='f'>
					<img width=100 height=100>
					[배너사이즈]
				</li>
			</ul>	
<form class="form-horizontal">

 <div class="form-group">
    <label class="col-sm-2 control-label">광고단위명</label>
    <div class="col-sm-10">
      <input type='text'>
    </div>
	
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">카테고리선택</label>
    <div class="col-sm-4">
      <select ng -model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
	<select ng- model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
    </div>
	
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">카테고리선택</label>
    <div class="col-sm-4">
      <select ng -model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
	<select ng- model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
    </div>
	
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">카테고리선택</label>
    <div class="col-sm-4">
      <select ng -model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
	<select ng- model="item.status" ng- options="code.key as code.description for code in codetbl['member.status']" ng-init="loadCodeTbl(['member.status'])">
		<option>1차카테고리명</option>
	</select>
    </div>
	
  </div>
</form>	
    		<button type="button" class="btn btn-danger btn-block" ng-click="dataSave()">광고코드 생성</button>
  			


  			
			
		</div>
	</div>
</div>
		

	</script>
	<script type='text/ng-template' id='part/new1.html'>
<div class="col-lg-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4>
				{{title}} 생성
				<div class="btn-group pull-right">
					<a class="btn btn-default btn-sm" href="#/ad_unit">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<form class="form-horizontal">

 <div class="form-group">
    <label class="col-sm-2 control-label">서비스</label>
    <div class="col-sm-2">
      <select ng-model="item.status" ng-options="code.key as code.description for code in codetbl['member.status']" ng-init="item.status='A';loadCodeTbl(['member.status'])">
		<option>브랜드박스</option>
		<option>브랜드박스1</option>
	</select>
    </div>
	<div class="col-sm-2"><button class='btn btn-primary'>만들기</button></div>
  </div>
<div class="form-group">
    <label class="col-sm-2 control-label">AD 타입</label>
    <div class="col-sm-10">
      <input type='radio' name='f' checked>검색 <input type='radio' name=f>매칭
    </div>
  </div>

  
</form>
<button type="button" class="btn btn-danger btn-block" ng-click="next()">다음</button>
		</div>
	</div>
</div>
		
	</script>

</body>

</html>

