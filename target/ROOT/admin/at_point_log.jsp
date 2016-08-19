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

    <div id="wrapper" style="padding:10px">

         <%@ include file="at_top_menu.jsp" %>

        <!-- Page Content -->
        <div id="pag e-wrapper">
            <div class="container-fluid">
                
                <!-- /.row -->
                <div class="row">
	                
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
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
	
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
	<script src="/ad/js/bootstrap-treeview.js"></script>
	<script src="/ad/js/common.js"></script>
	<script>
	
	
		
		
		var app = angular.module('app',['ngRoute','ngResource','appControllers','appServices','ui.bootstrap']);
		app.run(function($rootScope,$http) {
		    $rootScope.title="포인트 관리";
		    $rootScope.codetbl={};
		    $rootScope.loadCodeTbl=function(array,callback){
		    	var codes=[];
		    	for(i=0; i<array.length; i++){
		    		if(!$rootScope.codetbl[array[i]]){
		    			codes.push(array[i]);
		    		}
		    	}
		    	if(codes.length==0) {
		    		if(callback) callback();
		    		return;
		    	}
		    	
		    	
		    	for(i=0; i<codes.length; i++){
		    		codes[i]='g_code='+codes[i];
		    	}
		    	var query= codes.join("&");
		    	
	 		    
		    	$http.get('/ad/api/code_tbl?'+query).success(function(response) {
		    	    //console.log(response.data);
		    	    $.each(response.data, function(key, element) {
		    	    	$rootScope.codetbl[key]= element;
		    	    	
		    	    });
		    	    
		    	});
		    	if(callback) callback();
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
       		  	when('/:memberSq',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/:memberSq/new',{ //new
	 		  		templateUrl:'part/new.html',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/:memberSq/edit',{ //view
	 		  		templateUrl:'part/edit.html',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/:memberSq'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($rootScope,$scope,$routeParams,$location,PointLog,$modal,$routeParams){
	    	$scope.searchForm={gubun:'',kind:''};
	    	/*$rootScope.loadCodeTbl(['pointLog.kind','pointLog.gubun','pointLog.A','pointLog.B'],function(){
	    		$.each(  $scope.table.fnGetData(), function( index, ele ){
	    			$scope.table.fnUpdate(ele,index );
				});
	    		
	    	});*/
	    	
	    	
	    	
			/*$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/member/'+aData.member_code+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});*/
			
			$scope.onNew=function(){
				$location.path('/'+$routeParams.memberSq+'/new');
			}
			$scope.onView=function(items){
				//$scope.onBid=function(){
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
    				startDate: '2015-07-11',
    				endDate: '2015-08-09'
    						}, 
    			$scope.cb
	    	);
			
	        $scope.cb(moment(), moment());
	        $scope.searchItem={}
	        $scope.kinds=[];
	        $scope.$watch(
	                "searchForm.gubun",
	                function( newValue, oldValue ){
	                	console.log(newValue,oldValue);
	                	$scope.kinds=[];
						if(newValue){
							
							//console.log('ssss');
							$rootScope.loadCodeTbl(['pointLog.'+newValue],function(){
								console.log('ddd');
								$scope.kinds=$rootScope.codetbl['pointLog.'+newValue];
							});
						}
	                }
	         );
	        $scope.onSearch=function(){
	        	$scope.table.api().ajax.reload();
	        }; 
	        
	        $scope.onSave=function(){
				//$scope.onBid=function(){
					var modalInstance = $modal.open({
					      animation: true,
					      templateUrl: 'part/save.html',
					      controller: 'SaveController',
					      size: undefined,
					      resolve: {
						        item: function () {
						          return $routeParams;
						        }
						  }
					      
					});

				    modalInstance.result.then(function (item) {  
				    	$scope.table.api().ajax.reload();
				    }, function () {
				      	
				    });
				}
	        $scope.onUse=function(){
				//$scope.onBid=function(){
					var modalInstance = $modal.open({
					      animation: true,
					      templateUrl: 'part/use.html',
					      controller: 'UseController',
					      size: undefined,
					      resolve: {
						        item: function () {
						          return $routeParams;
						        }
						  }
					      
					});

				    modalInstance.result.then(function (item) {  
				       
				    	$scope.table.api().ajax.reload();
				    }, function () {
				      	
				    });
				}
	        $scope.table = $('#table').dataTable( {
	    		fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    // Row click
	    		    /*$(nRow).on('click', function() {
	    		      //console.log('Row Clicked. Look I have access to all params, thank You closures.', this, aData, iDisplayIndex, iDisplayIndexFull);
	    		    });
	    		 
	    		    // Cell click
	    		    $(nRow).on( 'click', 'td', function () {
	    		    	
	    		    	var columnIndex = $(this).index(); 
	    		    	console.log(columnIndex);
	    		    	if(columnIndex==0){
	    		    		//detailDashboard(1);
	    		    	}else if(columnIndex==1){
	    		    		//detailMember(1);
	    		    	}else if(columnIndex==2){
	    		    		//detailPoint(1);
	    		    		$scope.onView(aData);
	    		    	}
	    		    	
	    		    } );*/
	    		  },
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다."
	    	    },
	    	    "bLengthChange": false, // hide show entries
    			"paging": true,
    			"bInfo": false,
    			"bSort":false,
    			"bFilter": false,
    			"sort":[],
		        "ajax": {
		        	url:'/ad/admin/pointLog', // 록록전체
		        	data:function(d){
		        		d.memberSq = $routeParams.memberSq;
		        		d.startDate = $scope.searchForm.startDate;
		        		d.endDate = $scope.searchForm.endDate;
		        		d.gubun = $scope.searchForm.gubun;
		        		d.kind=$scope.searchForm.kind;
		        	},
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
					{"targets": 0,"data": "regDate"},
					{"targets": 1,"data": "point"},
					{"targets": 2,"data": "gubunName","render": function ( data, type, full, meta ) {
		                return $rootScope.getCodeDesc('pointLog.gubun',full.gubun);
		            },"orderable": false},
		            {"targets": 3,"data": "kindName","render": function ( data, type, full, meta ) {
		                return $rootScope.getCodeDesc('pointLog.'+full.gubun,full.kind);
		            },"orderable": false},
		            {"targets": 4,"data": "description","render": function ( data, type, full, meta ) {
		                
		            	if(data==null) return "";
		            	return data;
		                
		            },"orderable": false}
		         ]
	    	
			});
	        $rootScope.loadCodeTbl(['pointLog.gubun','pointLog.A','pointLog.B'],function(){
	    		$.each(  $scope.table.fnGetData(), function( index, ele ){
	    			$scope.table.fnUpdate(ele,index );
				});
	    		
	    	});
		});
	   
	    
	    
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,PointLog,$modal){
	    	
			/*$scope.item = Member.get({memberSq:$routeParams.memberSq} , function (res){
				
				$scope.item =res.data; 
			});*/
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
	    appControllers.controller('NewController',function($scope,$routeParams,$location,PointLog,$modal){
	    	//$scope.item=new Member();
			$scope.addItem = function(){
				$scope.item.$save(function(res){
					if(res.success){
						$location.path('/'+$routeParams.memberSq+'/new');
					}else{
						alert(res.msg);
					}
				});
			}
			 
		});
	    appControllers.controller('SaveController',function($http,$rootScope,$scope,$routeParams,item,$location,PointLog,Member,$modal,$modalInstance){
	    	
	    	
	    	//console.log(item);
	    	//$rootScope.loadCodeTbl(['pointLog.A'],function(){
	    		
	    	//});
	    	$scope.item={memberSq:item.memberSq,gubun:'A',kind:'C',point:10000};
	    	Member.get(item,function(res){
	    		$scope.item.companyName=res.data.companyName;
	    		$scope.item.userid=res.data.userid;
	    	});
	    	$scope.cancel = function () {
				$modalInstance.dismiss('cancel');
			};
			$scope.dataSave=function(){
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				$http.post('/ad/admin/pointSave',$scope.item).success(function(res) {
					if(res.success){
						$modalInstance.close(true);
					}else{
						alert(res.msg);
					}
		    	});
			}
			
			
		});
		appControllers.controller('UseController',function($http,$rootScope,$scope,$routeParams,item,$location,PointLog,Member,$modal,$modalInstance){
	    	
	    	
	    	//console.log(item);
	    	//$rootScope.loadCodeTbl(['pointLog.A'],function(){
	    		
	    	//});
	    	$scope.item={memberSq:item.memberSq,gubun:'B',kind:'C',point:10000};
	    	Member.get(item,function(res){
	    		$scope.item.companyName=res.data.companyName;
	    		$scope.item.userid=res.data.userid;
	    	});
	    	$scope.cancel = function () {
				$modalInstance.dismiss('cancel');
			};
			$scope.dataSave=function(){
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				$http.post('/ad/admin/pointUse',$scope.item).success(function(res) {
					if(res.success){
						$modalInstance.close(true);
					}else{
						alert(res.msg);
					}
		    	});
			}
			
			
		});
	    appControllers.controller('EditController',function($scope,$routeParams,$location,PointLog,$modal){
			//$scope.item = Member.get({member_code:$routeParams.member_code} );
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
		
	    appServices.factory('PointLog',function($resource){
			
			return $resource('/ad/admin/pointLog/:pointLogSq', { member_code: '@pointLogSq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
		
		appServices.factory('Member',function($resource){
			
			return $resource('/ad/admin/member/:memberSq', { memberSq: '@memberSq' }, {
				update:{ method:'PUT'}
			  });
		});
	    
		
		
   
	</script>
	<script type='text/ng-template' id='part/list.html'>

	<div class="panel panel-default">
		
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
					</div>
  					<div class="form-group">
						
						
						<select ng-model="searchForm.gubun" ng-options="code.key as code.description for code in codetbl['pointLog.gubun']">
							<option value=''>구분</option>
						</select>
						<select ng-model="searchForm.kind" ng-options="code.key as code.description for code in kinds">
							<option value=''>전체</option>
						</select>
						
						
  					</div>
					
  					
  					
  					<button type=button" class="btn btn-default" ng-click="onSearch()">검색</button>
				</form>
			</div>
			<div style="float:right">
				<button type="button" class="btn btn-danger btn-sm" ng-click='onSave()'>
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 포인트적립
				</button>
				<button type="button" class="btn btn-danger btn-sm" ng-click='onUse()'>
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 포인트삭감
				</button>
				<button type="button" class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span> 다운로드
				</button>
			</div>

				<table id="table" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>날짜</th>
							<th>포인트</th>
							<th>유형</th>
							<th>대상</th>
							<th>비고</th>
							
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
      			{{item.regDate}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">키워드</label>
    		<div class="col-sm-10">
      			ㅇㅇㅇㅇ-ㅇㅇㅇㅇ<br>
ㅇㅇㅇㅇ-ㅇㅇㅇㅇ<br>
ㅇㅇㅇㅇ-ㅇㅇㅇㅇ
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">제목</label>
    		<div class="col-sm-10">
      			{{item.title}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">링크</label>
    		<div class="col-sm-10">
      			{{ittle.link}}
    		</div>
  		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">광고사진</label>
    		<div class="col-sm-10">
      			<img ng-src='{{newItem.photo_url}}' width="60" height="60"/>
    		</div>
			
		</div>

		<div class="form-group">
    		<label class="col-sm-2 control-label">비고</label>
    		<div class="col-sm-10">
      			{{item.description}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">구분</label>
    		<div class="col-sm-10">
      			{{title.kind}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">결과처리</label>
    		<div class="col-sm-10">
      			<select ng-model="item.result" ng-options="code.key as code.description for code in codetbl['adm_req.result']">
				</select>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">반려사유</label>
    		<div class="col-sm-10">
      			<textarea cols=40 rows=5>{{item.why}}</textarea>
    		</div>
  		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary">확인</button>
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
<script type='text/ng-template' id='part/save.html'>
		
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">포인트적립</h4>
</div>

<div class="panel-body">
	<form class="form-horizontal" name="myForm"  novalidate>
 
  		
		<div class="form-group">
    		<label class="col-sm-2 control-label">업체명</label>
    		<div class="col-sm-10">
      			{{item.companyName}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">아이디</label>
    		<div class="col-sm-10">
      			{{item.userid}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">적립포인트</label>
    		<div class="col-sm-10">
      			<input type="number" class="form-control" ng-model="item.point">
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">적립유형</label>
    		<div class="col-sm-10">
      			<select ng-model="item.kind" ng-options="code.key as code.description for code in codetbl['pointLog.A']">
				</select>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">비고</label>
    		<div class="col-sm-10">
      			<textarea cols=40 rows=5 ng-model="item.description"></textarea>
    		</div>
  		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary" ng-click="dataSave()">확인</button>
</div>

		

	</script>
	<script type='text/ng-template' id='part/use.html'>
		
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">포인트삭감</h4>
</div>

<div class="panel-body">
	<form class="form-horizontal" name="myForm"  novalidate>
 
  		
		<div class="form-group">
    		<label class="col-sm-2 control-label">업체명</label>
    		<div class="col-sm-10">
      			{{item.companyName}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">아이디</label>
    		<div class="col-sm-10">
      			{{item.userid}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">삭감포인트</label>
    		<div class="col-sm-10">
      			<input type="number" class="form-control" ng-model="item.point">
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">삭감유형</label>
    		<div class="col-sm-10">
      			<select ng-model="item.kind" ng-options="code.key as code.description for code in codetbl['pointLog.B']">
				</select>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">비고</label>
    		<div class="col-sm-10">
      			<textarea cols=40 rows=5 ng-model="item.description"></textarea>
    		</div>
  		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary" ng-click="dataSave()">확인</button>
</div>
		

	</script>
</body>

</html>

