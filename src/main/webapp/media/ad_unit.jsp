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

    <title>매체사 어드민 페이지</title>
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
       		  	when('/',{ // list
       		  		templateUrl:'part/list.html',
       		  		controller:'ListController'
       		  	}).
	       		when('/:adUnitSq/view',{ //view
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
	 		  	when('/adUnit/new/2',{ //new
	 		  		templateUrl:'part/new2.html',
	 		  		controller:'New2Controller'
	 		  	}).
	 		  	when('/new/3',{ //new
	 		  		templateUrl:'part/new3.html',
	 		  		controller:'New3Controller'
	 		  	}).
	 		  	when('/:adUnitSq/edit',{ //view
	 		  		template:'',
	 		  		controller:'EditController'
	 		  	}).
	 		  	otherwise({
	 		  		redirectTo:'/'
	 		  	});
       		  
       }]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    appControllers.controller('ListController',function($timeout,$rootScope,$scope,$compile,$routeParams,$location,AdUnit,$modal,$templateCache){
	    	
	    	$rootScope.loadCodeTbl(['adType']);
	    	
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
	    		    		//detailDashboard(aData.memberSq);
	    		    	}else if(columnIndex==1){
	    		    		//detailMember(aData.memberSq);
	    		    	}else if(columnIndex==3){
	    		    		$scope.onClipboard(aData);
	    		    	}else if(columnIndex==2){
	    		    		$location.path('/'+aData.adUnitSq+'/view');
	    		    		$scope.$apply();
	    		    		//$scope.onDelete(aData);
	    		    	}
	    		    	
	    		    } );
	    		  },
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
		        	url:'/ad/media/adUnit', // 록록전체
		        	dataSrc: function ( json ) {
		        		return json.data;
		        	}
		        },
    			"columnDefs": [ 
    				            
					{"targets": 0,"data": "regDate"},
					{"targets": 1,"data": "serviceName"},
					{"targets": 2,"data": "name"},
					
					{"targets": 3,"data": "btn","render": function ( data, type, full, meta ) {
						return "<button class='btn btn-primary'>복사</button>";
					}}
		            
		         ]
			});
	    	$scope.onNew=function(){
				$location.path('/new');
			}
			$scope.onClipboard=function(sdata){
				//function copyToClipboard(element) {
					
					var scriptCode=$scope.getAdScriptCode(sdata);
					console.log(scriptCode);
				    var $temp = $("<textarea>")
				    $("body").append($temp);
				    $temp.val(scriptCode).select();
				    document.execCommand("copy");
				    $temp.remove();
				    alert('클립보드에 복사하였습니다.');
				//}
	    		//console.log(sdata);
	    		//window.clipboardData.setData('Text',"aaaaa");
	    	}
			$scope.getAdScriptCode=function(sdata){
				
				var template=$templateCache.get((sdata.adType=='A'?'part/clipboard_a.html':'part/clipboard_b.html'));
				 template=template.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
				/*
				brandboxAdClient = "{{item.adClient}}";
			    brandboxAdUnit = "{{item.adUnit}}";
			    brandboxAdWidth = {{item.adWidth}};
			    brandboxAdHeight = {{item.adHeight}};
			    */
			    //console.log(sdata);
			    if(sdata.adType=='A'){
			    	return template.replace('{{item.adClient}}','a1.0')
			    	.replace('{{item.adUnit}}',''+sdata.adUnitSq)
			    	.replace('{{item.adWidth}}','1000')
			    	.replace('{{item.adHeight}}','280');
			    }else{
			    	return template.replace('{{item.adClient}}','b1.0')
			    	.replace('{{item.adUnit}}',''+sdata.adUnitSq)
			    	.replace('{{item.adWidth}}','1000')
			    	.replace('{{item.adHeight}}','280');
			    }
			   //return template;
						
				
			}
			
		});
	   
	    
	    appControllers.controller('ServiceController',function($http,$rootScope,$scope,$routeParams,$location,$modal,item,$modalInstance,Service,Cg1,Cg2){
			//$scope.search_name="";
			
			$scope.service={point:0,adType:'A'};
			$scope.cancel = function () {
			    
				$modalInstance.dismiss('cancel');
			};
			$scope.dataSave=function(){
				//console.log(bid);
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				$scope.service.categoryList = [$scope.cg11,$scope.cg21,$scope.cg31];
				Service.save($scope.service,function(res){
					if(res.success){
						$modalInstance.close(true);
					}else{
						alert(res.msg);
					}
				});
			}
			$scope.$watch(
                "cg1",
                function( newValue, oldValue ){
                	if(!$.isEmptyObject(newValue))
               		Cg2.query({cg1Sq:newValue.cg1Sq},function(res){
								$scope.cg11List = res.data;
					});
                }
        	);
			$scope.$watch(
	                "cg2",
	                function( newValue, oldValue ){
	                	if(!$.isEmptyObject(newValue))
	               		Cg2.query({cg1Sq:newValue.cg1Sq},function(res){
									$scope.cg21List = res.data;
						});
	                }
	        	);
			$scope.$watch(
	                "cg3",
	                function( newValue, oldValue ){
	                	if(!$.isEmptyObject(newValue))
	               		Cg2.query({cg1Sq:newValue.cg1Sq},function(res){
									$scope.cg31List = res.data;
						});
	                }
	        	);
			Cg1.query({},function(res){
				if(res.success){
					$scope.cg1List = res.data;
				}
			});
			
		});
	    appControllers.controller('ViewController',function($rootScope,$scope,$templateCache,$routeParams,$location,AdUnit,$modal){
	    	
	    	//alert(11111);
	    	//$('#loading').loadingOverlay({loadingText: '로딩중'});
	    	//$scope.item={adUnitSq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
	    	AdUnit.get({adUnitSq:$routeParams.adUnitSq} , function (res){
				if(res.success){	
					$scope.item =res.data;
					$scope.item.scriptCode=$scope.getAdScriptCode($scope.item);
					$scope.item.agentCode=$scope.getAgentScriptCode($scope.item);
				}
				//$('#loading').loadingOverlay('remove');
			});
			
			$scope.doDelete=function(){
				bootbox.confirm("정말로 삭제하시겠습니까?", function(result) {
					if(result){
						AdUnit.delete({adUnitSq:$routeParams.adUnitSq},function(response){
							if(response.success){
								$location.path('/');
		    				  }else{
		    					alert(response.msg);
		    				  }
							
						});
					}
				});
			}
			$scope.getAgentScriptCode=function(sdata){
				var template=$templateCache.get('part/agent.html');
				 template=template.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
				 return template.replace('{{item.agentClient}}','c1.0');
				
			}
			$scope.getAdScriptCode=function(sdata){
				
				var template=$templateCache.get((sdata.adType=='A'?'part/clipboard_a.html':'part/clipboard_b.html'));
				 template=template.replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
				/*
				brandboxAdClient = "{{item.adClient}}";
			    brandboxAdUnit = "{{item.adUnit}}";
			    brandboxAdWidth = {{item.adWidth}};
			    brandboxAdHeight = {{item.adHeight}};
			    */
			    //console.log(sdata);
				 if(sdata.adType=='A'){
				    	return template.replace('{{item.adClient}}','a1.0')
				    	.replace('{{item.adUnit}}',''+sdata.adUnitSq)
				    	.replace('{{item.adWidth}}','1000')
				    	.replace('{{item.adHeight}}','280');
				    }else{
				    	return template.replace('{{item.adClient}}','b1.0')
				    	.replace('{{item.adUnit}}',''+sdata.adUnitSq)
				    	.replace('{{item.adWidth}}','1000')
				    	.replace('{{item.adHeight}}','280');
				    }
			    
			   //return template;
						
				
			}
			 
	    	
		});
	    appControllers.controller('NewController',function($rootScope,$scope,$routeParams,$location,AdUnit,Service,$modal){
	    	
	    	
		    $rootScope.newItem = {viewType:'A',adType:'A'};
		    
		    $location.path('/new/1').replace();
			
	    });
		appControllers.controller('New1Controller',function($rootScope,$scope,$routeParams,$location,AdUnit,$modal,Service){
			
			Service.query({},function(res){
				$scope.serviceList = res.data;
			});
	    	
			$scope.subMenuName = "광고정보 선택";
			$scope.onCreateService=function(){
	    		
				var modalInstance = $modal.open({
				      animation: true,
				      templateUrl: 'part/service.html',
				      controller: 'ServiceController',
				      size: undefined,
				      resolve: {
					        item: function () {
					          return {};
					        }
					  }
				      
				});

			    modalInstance.result.then(function (item) {  
			    	Service.query({},function(res){
						$scope.serviceList = res.data;
					});
			       
			    }, function () {
			      	
			    });
			}
			/*$scope.next=function(){
				if($rootScope.newItem.serviceSq==''){
					alert('서비스를 선택해주세요')
					return true;
				}
				if($rootScope.newItem.adType=='A'){
					$location.path('/new/2');
				}else{
					$location.path('/new/3');
				}
			}*/
			$scope.dataSave=function(){
				//console.log(bid);
				if(!$scope.myForm.$valid){
					alert('필드 입력 오류!!!');
					return;
				}
				//$scope.service.categoryList = [$scope.cg11,$scope.cg21,$scope.cg31];
				AdUnit.save($rootScope.newItem,function(res){
					if(res.success){
						//$modalInstance.close(true);
						$location.path('/');
					}else{
						alert(res.msg);
					}
				});
			}
			 
		});
		appControllers.controller('New2Controller',function($rootScope,$scope,$routeParams,$location,AdUnit,$modal){
				
			$scope.next=function(){
				$location.path('/new/3');
			} 
		});
		
		appControllers.controller('New3Controller',function($rootScope,$scope,$routeParams,$location,AdUnit,$modal){
			
			$scope.dataSave=function(){
				$location.path('/');
			} 
		});
	   
		
		
	    appControllers.controller('EditController',function($rootScope,$scope,$routeParams,$location,AdUnit,$modal){
	    	
	    	//console.log('dddd');
			$rootScope.newItem={adUnitSq:1,regDate:'2015.0.10',photo_url:'http://www.mamiyaleaf.com/images/samples/credo_80/Credo_Barcelona_0320_TH.jpg',title:'타이틀:~~~~',description:'설명:~~~',link:'~~~'};
			$location.path('/new/1').replace();
			
		});
		
	    var appServices = angular.module('appServices',[]);
		
		appServices.factory('AdUnit',function($resource){
			
			return $resource('/ad/media/adUnit/:adUnitSq', { adUnitSq: '@adUnitSq' }, {
				update:{ method:'PUT'},
				query: { method:'GET', cache: false, isArray:false }
			  });
		});
		appServices.factory('Service',function($resource){
			
			return $resource('/ad/media/service/:serviceSq', { serviceSq: '@serviceSq' }, {
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
	<script type="text/ng-template" id="part/clipboard_a.html">
&lt;script type="text/javascript"&gt;
    brandboxAdClient = "{{item.adClient}}";
    brandboxAdUnit = "{{item.adUnit}}";
    brandboxAdWidth = {{item.adWidth}};
    brandboxAdHeight = {{item.adHeight}};
    brandboxKeyword="?";<!-- ? 에 검색어를 입력합니다. -->
&lt;/script&gt;
&lt;script type="text/javascript" src="http://brandbox.kr/ad/api/ad.js"&gt;&lt;/script&gt;
	</script>
	<script type="text/ng-template" id="part/clipboard_b.html">
&lt;script type="text/javascript"&gt;
    brandboxAdClient = "{{item.adClient}}";
    brandboxAdUnit = "{{item.adUnit}}";
    brandboxAdWidth = {{item.adWidth}};
    brandboxAdHeight = {{item.adHeight}};
    
&lt;/script&gt;
&lt;script type="text/javascript" src="http://brandbox.kr/ad/api/ad.js"&gt;&lt;/script&gt;
	</script>
	
	<script type="text/ng-template" id="part/agent.html">
&lt;script type="text/javascript"&gt;
    brandboxAdClient = "{{item.agentClient}}";
    
&lt;/script&gt;
&lt;script type="text/javascript" src="http://brandbox.kr/ad/api/agent.js"&gt;&lt;/script&gt;
	</script>
	<script type='text/ng-template' id='part/view.html'>
<div class="col-lg-12">
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
							<td>서비스명</td>
							<td>{{item.serviceName}}</td>

						</tr>
						<tr>
							<td>광고단위명</td>
							<td>{{item.name}}</td>

						</tr>
						
						<tr>
							<td>AD 타입</td>
							<td>{{getCodeDesc('adType',item.adType)}}</td>

						</tr>
						<tr>
							<td>광고코드</td>
							<td>
								<pre>
									{{item.scriptCode}}
								</pre>
								
							</td>

						</tr>
							
						<tr>
							<td>등록일</td>
							<td>{{item.regDate}}</td>
						</tr>
	   			</tbody>
  			</table>
			<p>
  				<a class="btn btn-primary" ng-click="onDelete()">삭제</a>
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
					
					[이미지형]
				</li>
				<li style='padding:5px' name='f'>
					<input type=radio>
					
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
					
					[풀사이즈]
				</li>
				<li style='padding:5px;display:inline'>
					<input type=radio name='f'>
					
					[하프사이즈]
				</li>
<li style='padding:5px;display:inline'>
					<input type=radio name='f'>
					
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
					<a class="btn btn-default btn-sm" href="#/">## 조회화면으로</a>
				</div>
			</h4>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<form class="form-horizontal" name="myForm" novalidate>
				<div class="form-group">
    				<label class="col-sm-2 control-label">광고단위명</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" ng-model="newItem.name" required>
    				</div>
  				</div>
 				<div class="form-group">
    				<label class="col-sm-2 control-label">서비스</label>
    				<div class="col-sm-2">
      					<select ng-model="newItem.serviceSq" ng-options="code.serviceSq as code.name for code in serviceList" requried>
							<option value=''>선택</option>
						</select>
    				</div>
					<div class="col-sm-2"><button class='btn btn-primary' ng-click="onCreateService()">서비스만들기</button></div>
  				</div>
				<div class="form-group">
    				<label class="col-sm-2 control-label">광고유형</label>
    				<div class="col-sm-2">
      					<select ng-model="newItem.adType" ng-options="code.key as code.description for code in codetbl['adType']">
							<option value=''>선택</option>
						</select>
    				</div>
					
  				</div>
				<div class="form-group">
					<div class="col-sm-12" style="padding-left:50px">
    				<ul>

						<li style='padding:5px'>
							<input type=radio ng-model="newItem.viewType" value="A">
								
								[이미지형]
						</li>
						<li style='padding:5px'>
							<input type=radio ng-model="newItem.viewType" value="B">
							
							[리스트형]
						</li>
					</ul>
					</div>
  				</div>
  				
			</form>
			<button type="button" class="btn btn-danger btn-block" ng-click="dataSave()">저장완료</button>
		</div>
	</div>
</div>
		
	</script>
<script type='text/ng-template' id='part/service.html'>
<div class="modal-header" >
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title" id="myModalLabel1">서비스만들기</h4>
</div>
<div class="modal-body">
	<form class="form-horizontal" name="myForm" novalidate>

 		<div class="form-group">
    		<label class="col-sm-2 control-label">서비스명</label>
    		<div class="col-sm-10">
      			<input type="text" class="form-control" ng-model="service.name" required>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">도메인</label>
    		<div class="col-sm-10">
      			<input type="text" class="form-control" ng-model="service.domain" required>
    		</div>
  		</div>
		<div class="form-group">
    		<label class="col-sm-2 control-label">AD 타입</label>
    		<div class="col-sm-10">
      			<input type='radio' ng-model="service.adType" value="A">검색 <input type='radio' ng-model="service.adType" value="B">매칭
    		</div>
  		</div>
  
		<div class="form-group" ng-show="service.adType=='B'">
    		<label class="col-sm-2 control-label">카테고리1</label>
    		<div class="col-sm-10">
      			<select ng-model="cg1" ng-options="item.name for item in cg1List">
					<option value=''>1차카테고리</option>
				</select>
				<select ng-model="cg11" ng-options="item.name for item in cg11List">
					<option value=''>2차카테고리</option>
				</select>
    		</div>
  		</div>
		<div class="form-group" ng-show="service.adType=='B'">
    		<label class="col-sm-2 control-label">카테고리2</label>
    		<div class="col-sm-10">
      			<select ng-model="cg2" ng-options="item.name for item in cg1List">
					<option value=''>1차카테고리</option>
				</select>
				<select ng-model="cg21" ng-options="item.name for item in cg21List">
					<option value=''>2차카테고리</option>
				</select>
    		</div>
  		</div>
		<div class="form-group" ng-show="service.adType=='B'">
    		<label class="col-sm-2 control-label">카테고리3</label>
    		<div class="col-sm-10">
      			<select ng-model="cg3" ng-options="item.name for item in cg1List">
					<option value=''>1차카테고리</option>
				</select>
				<select ng-model="cg31" ng-options="item.name for item in cg31List">
					<option value=''>2차카테고리</option>
				</select>
    		</div>
  		</div>
 
	</form>
	
</div>

<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()">취소</button>
	<button type="button" class="btn btn-primary" ng-click="dataSave()">만들기</button>
</div>
</script>
</body>

</html>

