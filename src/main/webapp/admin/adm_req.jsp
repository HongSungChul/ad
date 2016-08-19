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
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />
    <link href="/ad/css/ad.css" rel="stylesheet">

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
    
    <script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    <script src="/ad/js/metisMenu.min.js"></script>
	<script src="//code.angularjs.org/1.3.15/angular.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-route.js"></script>
    <script src="//code.angularjs.org/1.3.15/angular-resource.js"></script>
    <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.0.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	
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
		    $rootScope.title="광고물 심사";
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
	       		when('/:amdReq/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/new',{ //new
	 		  		templateUrl:'part/new.html',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/:amdReq/edit',{ //view
	 		  		templateUrl:'part/edit.html',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal){
	    	
	    	
	    	
			/*$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/member/'+aData.member_code+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});*/
			
			$scope.searchForm={};
			$rootScope.loadCodeTbl(['admReq.kind','admReq.result'],function(){
	    		$.each(  $scope.table.fnGetData(), function( index, ele ){
	    			$scope.table.fnUpdate(ele,index );
				});
	    		
	    	});
			$scope.onNew=function(){
				$location.path('/new');
			}
			$scope.onView=function(items){
				//console.log(items);
				//$scope.onBid=function(){
				$rootScope.newItem=items;	
					var modalInstance = $modal.open({
					      animation: true,
					      templateUrl: 'part/edit.html',
					      controller: 'EditController',
					      size: undefined,
					      resolve: {
						        item: function () {
						          return items;
						        }
						  }
					      
					});

				    modalInstance.result.then(function (item) {  
				    	$scope.table.api().ajax.reload();
				       
				    }, function () {
				      	
				    });
				}
			//}
			$scope.cb = function(start, end) {
				//console.log(start,end);
				$scope.searchForm.startDate = start.format('YYYY-MM-DD');
				$scope.searchForm.endDate=end.format('YYYY-MM-DD');
	    		$('#daterange span').html($scope.searchForm.startDate + ' ~ ' + $scope.searchForm.endDate);
	    		if($scope.table)
	    			$scope.table.api().ajax.reload();
	        }
			
			$('#daterange').daterangepicker(
    			{
    				ranges: {
    		           'Today': [new Date(), new Date()],
    		           'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
    		           'Last 7 Days': [moment().subtract('days', 6), new Date()],
    		           'Last 30 Days': [moment().subtract('days', 29), new Date()],
    		           'This Month': [moment().startOf('month'), moment().endOf('month')],
    		           'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    				},
    				opens: 'right',
    				locale: {
    					format: 'YYYY-MM-DD',
    				},
    				startDate: moment().format('YYYY-MM-DD'),
    				endDate: moment().format('YYYY-MM-DD')
    			}, 
    			$scope.cb
	    	);
			//$('#daterange span').html(moment().format('YYYY-MM-DD') + ' ~ ' + moment().format('YYYY-MM-DD'));
	        $scope.cb(moment(), moment());
	        $scope.table = $('#table').dataTable( {
	    		fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    // Row click
	    		    $(nRow).on('click', function() {
	    		      //console.log('Row Clicked. Look I have access to all params, thank You closures.', this, aData, iDisplayIndex, iDisplayIndexFull);
	    		    });
	    		 
	    		    // Cell click
	    		    $(nRow).on( 'click', 'td', function () {
	    		    	
	    		    	var columnIndex = $(this).index(); 
	    		    	//var aData = $scope.table.fnGetData(this);
	    		    	//console.log(columnIndex);
	    		    	if(columnIndex==0){
	    		    		//detailDashboard(1);
	    		    	}else if(columnIndex==1){
	    		    		detailMember(1);
	    		    	}else if(columnIndex==2){
	    		    		//detailPoint(1);
	    		    		$scope.onView(aData);
	    		    	}
	    		    	
	    		    } );
	    		  },
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다."
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"processing": true,
    	        "serverSide": true,
    			"ajax": {
		        	url:'/ad/admin/admReq', // 록록전체
		        	method:'GET',
		        	data:function(d){
		        		d.startDate = $scope.searchForm.startDate;
		        		d.endDate = $scope.searchForm.endDate;
		        		d.kind=$scope.searchForm.kind;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
   				            
		   					{"targets": 0,"data": "regDate"},
		   					{"targets": 1,"data": "userInfo","render": function ( data, type, full, meta ) {
		   					    return full.companyName+'('+full.userid+')';
		   					},"orderable": false},
		   					
		   					{"targets": 2,"data": "title"},
		   					{"targets": 3,"data": "kwd","render": function ( data, type, full, meta ) {
		   						var s="";
		   						$.each(full.kwList,function(i,e){
		   							s+= e.kw1Name +'-'+ e.kw2Name+'<br>';
		   						});
		   					    return s;
		   					},"orderable": false},
		   					{"targets": 4,"data": "kind","render": function ( data, type, full, meta ) {
		   					    return $rootScope.getCodeDesc('admReq.kind',data);
		   					},"orderable": false},
		   					{"targets": 5,"data": "result","render": function ( data, type, full, meta ) {
		   						return $rootScope.getCodeDesc('admReq.result',data);
		   					}}
		   		            
		   		         ]
	    	
			});
	        $scope.onSearch=function(){
	        	$scope.table.api().ajax.reload();
	        }; 
		});
	   
	    
	    
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,AdmReq,$modal){
	    	
			$scope.item = AdmReq.get({admReqSq:$routeParams.admReqSq} , function (res){
				
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
	    appControllers.controller('NewController',function($scope,$routeParams,$location,AdmReq,$modal){
	    	$scope.item=new AdmReq();
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
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdmReq,$modal,$modalInstance){
			//$scope.item = AdmReq.get({admReqSq:$routeParams.admReqSq} );
			
			$scope.doUpdate= function(){
				AdmReq.update($rootScope.newItem,function(res){
					if(res.success){
						$modalInstance.close(true);
					}else{
						alert(res.msg);
					}
				});
				
				
			}
			$scope.cancel = function () {
				$modalInstance.dismiss('cancel');
			};
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdmReq',function($resource){
			
			return $resource('/ad/admin/admReq/:admReqSq', { admReqSq: '@admReqSq' }, {
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
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form" name="myForm" novalidate>
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					<div class="form-group">
						<label>구분:</label>
    					<select ng-model="searchForm.kind" ng-options="code.key as code.description for code in codetbl['admReq.kind']">
							<option value=''>선택하세요</option>
						</select>
  					</div>
					<!--
  					<div class="form-group">
    					<label for="pwd">검색어:</label>
    					<input type="text" class="form-control" id="pwd">
  					</div>
  					-->
  					<button type="button" class="btn btn-default" ng-click="onSearch()">검색</button>
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
							<th>날짜</th>
							<th>업체명(아이디)</th>
							<th>제목</th>
							<th>키워드</th>
							<th>요청구분</th>
							<th>승인결과</th>
							
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
					<a class="btn btn-default btn-sm" href="#/member">## 조회화면으로</a>
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
  <a class="btn btn-primary" ng-href="#/member/{{item.member_code}}/edit">수정하기</a>
  <a class="btn btn-primary" ng-click="doDelete()">삭제</a>
</p>
</div>
	</div>

	</script>
	<script type='text/ng-template' id='part/edit.html'>
		
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">광고물 신청정보</h4>
</div>

<div class="panel-body">
	<form class="form-horizontal">
 
  		<div class="form-group">
    		<label class="col-sm-2 control-label">신청일</label>
    		<div class="col-sm-10">
      			{{newItem.regDate}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">키워드</label>
    		<div class="col-sm-10">
      			<div ng-repeat="item in newItem.kwList">{{item.kw1Name}}-{{item.kw2Name}}</div>
				
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">제목</label>
    		<div class="col-sm-10">
      			{{newItem.title}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">링크</label>
    		<div class="col-sm-10">
      			{{newItem.link}}
    		</div>
  		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">광고사진</label>
    		<div class="col-sm-10">
      			<img ng-src='{{newItem.imgUri}}' width="200" height="200"/>
    		</div>
			
		</div>

		<div class="form-group">
    		<label class="col-sm-2 control-label">비고</label>
    		<div class="col-sm-10">
      			{{newItem.description}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">구분</label>
    		<div class="col-sm-10">
      			{{getCodeDesc('admReq.kind',newItem.kind)}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">결과처리</label>
    		<div class="col-sm-10">
      			<select ng-model="newItem.result" ng-options="code.key as code.description for code in codetbl['admReq.result']">
				</select>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">반려사유</label>
    		<div class="col-sm-10">
      			<textarea cols=40 rows=5>{{newItem.backWhy}}</textarea>
    		</div>
  		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary" ng-click="doUpdate()">확인</button>
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

