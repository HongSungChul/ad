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
		    $rootScope.title="충전내역";
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
       		  	when('/point_log',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/point_log/:member_code/view',{ //view
	 		  		templateUrl:'part/view.html',
	 		  		controller:'ViewController'
	 		  	}).
	 		  	when('/point_log/new',{ //new
	 		  		templateUrl:'part/new.html',
	 		  		controller:'NewController'
	 		  	}).
	 		  	when('/point_log/:member_code/edit',{ //view
	 		  		templateUrl:'part/edit.html',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/point_log'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($rootScope,$scope,$routeParams,$location,Member,$modal,PageInfo){
	    	$rootScope.loadCodeTbl(['pointLog.gubun'],function(){
	    		
	    	});
	    	$scope.table = $('#table').dataTable( {
	    		fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
	    		    
	    		  },
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다."
	    	    },
    			"paging": false,
    			"bInfo": false,
    			"bSort":true,
    			"bFilter": false,
    			/*"aaSorting": [[3, 'asc']],
		        "ajax": {
		        	url:'/ad/member/member?page='+PageInfo.data.currentPage, // 록록전체
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
		        "columnDefs": [ 
		            {"targets": 0,"data": "hp"},
		            {"targets": 1,"data": "name"}, 
		            {"targets": 2,"data": "email"},
		            {"targets": 3,"data": "point"},
		            {"targets": 4,"data": "regDate"}
		         ]*/
	    	
			});
	    	
			/*$('#table tbody').on( 'click', 'tr', function () {
			    event.preventDefault();
			    var aData = $scope.table.fnGetData(this);
			    var gUrl = '/member/'+aData.member_code+'/view';
			    $location.path(gUrl);
			    $scope.$apply();
			    
			});*/
			$scope.onNew=function(){
				$location.path('/member/new');
			}
			$scope.onCancel=function(items){
				//$scope.onBid=function(){
					var modalInstance = $modal.open({
					      animation: true,
					      templateUrl: 'part/cancel.html',
					      controller: 'CancelController',
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
			$scope.cb = function(start, end) {
	    		$('#daterange span').html(start.format('YYYY MM DD') + ' ~ ' + end.format('YYYY MM DD'));
	        }
	        $scope.cb(moment(), moment());
	        $scope.searchItem={}
	        $scope.kinds=[];
	        $scope.$watch(
	                "searchItem.gubun",
	                function( newValue, oldValue ){
	                	$scope.kinds=[];
						if(newValue){
							$rootScope.loadCodeTbl(['pointLog.'+newValue],function(){
								$scope.kinds=$rootScope.codetbl['pointLog.'+newValue];
							});
						}
	                }
	         );
		});
	   
	    
	    appControllers.controller('CancelController',function($scope,$routeParams,$location,Member,$modal){
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
	    appControllers.controller('ViewController',function($scope,$routeParams,$location,Member,$modal){
	    	
			$scope.item = Member.get({member_code:$routeParams.member_code} , function (res){
				
				$scope.item =res.data; 
			});
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
						$location.path('/member');
					}else{
						alert(res.msg);
					}
				});
			}
			 
		});
	    appControllers.controller('EditController',function($scope,$routeParams,$location,Member,$modal){
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
		
	    appServices.factory('Member',function($resource){
			
			return $resource('/ad/member/member/:member_code', { member_code: '@member_code' }, {
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
		
		
		<div class="panel-body">
			<div class="alert alert-info" role="alert">
				<form class="form-inline" role="form">
					<div class="form-group">
						<div id="daterange" class="pull-right" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; wi dth: 100%">
    						<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
    						<span></span> <b class="caret"></b>
						</div>
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
							<th>날짜</th>
							<th>금액</th>
							<th>유형</th>
							<th>취소여부</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2001-02-02</td>
							<td>10,000</td>
							<td>카드</td>
							<td>NO</td>
							<td></td>
						</tr>
						<tr>
							<td>2001-02-02</td>
							<td>10,000</td>
							<td>무통장</td>
							<td>NO</td>
							<td></td>
						</tr>
						<tr>
							<td>2001-02-02</td>
							<td>10,000</td>
							<td>카드</td>
							<td>YES</td>
							<td>환불 요청</td>
						</tr>						
					</tbody>
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
<script type='text/ng-template' id='part/cancel.html'>
		
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">충전내역취소</h4>
</div>

<div class="panel-body">
	<form class="form-horizontal">
 
  		
		<div class="form-group">
    		<label class="col-sm-2 control-label">업체명</label>
    		<div class="col-sm-10">
      			{{item.title}}
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">아이디</label>
    		<div class="col-sm-10">
      			{{ittle.link}}
    		</div>
  		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">충전일시</label>
    		<div class="col-sm-10">
      			{{}}
    		</div>
			
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">유형</label>
    		<div class="col-sm-10">
      			{{}}
    		</div>
			
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">충전코드</label>
    		<div class="col-sm-10">
      			{{}}
    		</div>
			
		</div>

		<div class="form-group">
    		<label class="col-sm-2 control-label">비고</label>
    		<div class="col-sm-10">
      			{{item.description}}
    		</div>
  		</div>
		
		<div class="form-group">
    		<label class="col-sm-2 control-label">취소사유</label>
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
</body>

</html>

