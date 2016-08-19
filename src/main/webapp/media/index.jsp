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
	    
	    appControllers.controller('ListController',function($http,$timeout,$scope,$routeParams,$location,AdInfo,$modal,PageInfo){
	    	/*$scope.table = $('#table').dataTable( {
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
	    	*/
	    	$('#main_content').show();
	    	$http.get('/ad/media/stat').success(function(response) {
	    	    if(response.success){
	    	    	$scope.data = response.data;
	    	    }
	    	    
	    	});
	    	
	    	
	    	
			
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


        <div id="main_content" style="display:none">
            
   
   
   <div class="wrapper wrapper-content">
        <div class="row">
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">이번달</span>
                                <h5>노출수</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-success">0% <i class="fa fa-bolt"></i></div>
                                <small>건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">이번달</span>
                                <h5>클릭수</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-info">0% <i class="fa fa-level-up"></i></div>
                                <small>건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">이번달</span>
                                <h5>도달율</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-navy">0% <i class="fa fa-level-up"></i></div>
                                <small>충전</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">이번달</span>
                                <h5>수익</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">0</h1>
                                <div class="stat-percent font-bold text-danger">0% <i class="fa fa-level-down"></i></div>
                                <small>금액</small>
                            </div>
                        </div>
            </div>
        </div>
        <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>유입트래픽</h5>
                                <div class="pull-right">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-xs btn-white active">Today</button>
                                        <button type="button" class="btn btn-xs btn-white">Monthly</button>
                                        <button type="button" class="btn btn-xs btn-white">Annual</button>
                                    </div>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div class="row">
                                <div class="col-lg-9">
                                    <div class="flot-chart">
                                        <div class="flot-chart-content" id="flot-dashboard-chart" style="padding: 0px; position: relative;"><canvas class="flot-base" width="1494" height="400" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 747px; height: 200px;"></canvas><div class="flot-text" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; font-size: smaller; color: rgb(84, 84, 84);"><div class="flot-x-axis flot-x1-axis xAxis x1Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 74px; text-align: center;">Jan 03</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 142px; text-align: center;">Jan 06</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 211px; text-align: center;">Jan 09</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 279px; text-align: center;">Jan 12</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 347px; text-align: center;">Jan 15</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 415px; text-align: center;">Jan 18</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 483px; text-align: center;">Jan 21</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 551px; text-align: center;">Jan 24</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 619px; text-align: center;">Jan 27</div><div class="flot-tick-label tickLabel" style="position: absolute; max-width: 52px; top: 185px; left: 687px; text-align: center;">Jan 30</div></div><div class="flot-y-axis flot-y1-axis yAxis y1Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; top: 173px; left: 19px; text-align: right;">0</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 132px; left: 7px; text-align: right;">250</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 92px; left: 7px; text-align: right;">500</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 52px; left: 7px; text-align: right;">750</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 12px; left: 1px; text-align: right;">1000</div></div><div class="flot-y-axis flot-y2-axis yAxis y2Axis" style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 0px; display: block;"><div class="flot-tick-label tickLabel" style="position: absolute; top: 173px; left: 735px;">0</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 144px; left: 735px;">5</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 115px; left: 735px;">10</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 87px; left: 735px;">15</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 58px; left: 735px;">20</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 29px; left: 735px;">25</div><div class="flot-tick-label tickLabel" style="position: absolute; top: 1px; left: 735px;">30</div></div></div><canvas class="flot-overlay" width="1494" height="400" style="direction: ltr; position: absolute; left: 0px; top: 0px; width: 747px; height: 200px;"></canvas><div class="legend"><div style="position: absolute; width: 111px; height: 30px; top: 13px; left: 35px; opacity: 0.85; background-color: rgb(255, 255, 255);"> </div><table style="position:absolute;top:13px;left:35px;;font-size:smaller;color:#545454"><tbody><tr><td class="legendColorBox"><div style="border:1px solid #000000;padding:1px"><div style="width:4px;height:0;border:5px solid #1ab394;overflow:hidden"></div></div></td><td class="legendLabel">사용자</td></tr><tr><td class="legendColorBox"><div style="border:1px solid #000000;padding:1px"><div style="width:4px;height:0;border:5px solid #1C84C6;overflow:hidden"></div></div></td><td class="legendLabel">집행금액</td></tr></tbody></table></div></div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <ul class="stat-list">
                                        <li>
                                            <h2 class="no-margins">0</h2>
                                            <small>오늘 방문자</small>
                                            <div class="stat-percent">48% <i class="fa fa-level-up text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 48%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        <li>
                                            <h2 class="no-margins ">0</h2>
                                            <small>최근 월간 방문자</small>
                                            <div class="stat-percent">60% <i class="fa fa-level-down text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 60%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        <li>
                                            <h2 class="no-margins ">0</h2>
                                            <small>이달수입금액</small>
                                            <div class="stat-percent">0% <i class="fa fa-bolt text-navy"></i></div>
                                            <div class="progress progress-mini">
                                                <div style="width: 22%;" class="progress-bar"></div>
                                            </div>
                                        </li>
                                        </ul>
                                    </div>
                                </div>
                                </div>

                            </div>
                        </div>
                    </div>


                
                </div>
   
   <!--
   <table id="table" class="table" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>생성일</th>
							<th>서비스명</th>
							<th>광고단위명</th>
							<th>스크립트복사</th>
						</tr>
					</thead>
					

				</table> -->
   
        </div>
        <!-- /#page-wrapper -->
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

