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
       		  	when('/',{ //view
	 		  		templateUrl:'part/list.html',
	 		  		controller:'ListController'
	 		  }).
	 		  otherwise({
	 		  		redirectTo:'/'
	 		  });
		       		  
		}]);
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($scope,$http,$routeParams,$location,$modal){
	    	
			
	    	$('#main_content').show();
	    	
	    	$http.get('/ad/advertiser/stat').success(function(response) {
	    	    if(response.success){
	    	    	$scope.data = response.data;
	    	    }
	    	    
	    	});
	    	
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
		
		
   
	</script>	
		
	<script type="text/ng-template" id='part/list.html'>


        <div id="main_content" style="display:none">
            
   
   
   <div class="wrapper wrapper-content">
        <div class="row">
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-success pull-right">전체</span>
                                <h5>광고물(집행)</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">{{data.admCnt}}({{data.advertisingCnt}})</h1>
                                <div class="stat-percent font-bold text-success">0% <i class="fa fa-bolt"></i></div>
                                <small>등록건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-info pull-right">전체</span>
                                <h5>입찰키워드(1차/2차)</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">{{data.kwCntInfo.kw1Cnt}}/{{data.kwCntInfo.kw2Cnt}}</h1>
                                <div class="stat-percent font-bold text-info">0% <i class="fa fa-level-up"></i></div>
                                <small>등록건수</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">현재</span>
                                <h5>포인트 잔액</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">{{data.memberInfo.point}}</h1>
                                <div class="stat-percent font-bold text-navy">0% <i class="fa fa-level-up"></i></div>
                                <small>충전</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">전체</span>
                                <h5>집행금액</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">{{data.recentMonthUseSum}}</h1>
                                <div class="stat-percent font-bold text-danger">0% <i class="fa fa-level-down"></i></div>
                                <small>이번달</small>
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
                                            <small>이달집행금액</small>
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
   
   
   
   
        </div>
        <!-- /#page-wrapper -->
</script>
		
	<script type='text/ng-template' id='part/list1.html'>
	
	<div class="panel panel-default">
	<div class="panel-heading">
		<h4>
			광고현황
	
				
		</h4>
	</div>
<!--
	<div class="alert alert-info" role="alert">
		노출수 :1,000 회 클릭수 : 1,304회 광금집행금액
	</div>
-->
	<div class="panel-body">
		<blockquote>
			<p>전체요약정보</p>
		</blockquote>
		<div class="table-responsive"> 
	        <table class="table table-bordered">
	            <thead>
	                <tr>
	                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>광고집행현황</th>
	                    <th>전체광고물</th>
	                    <td>${admCnt}</td>
	                    <th>광고집행광고물</th>
	                    <td>${advertisingCnt}</td>
	                    
	                </tr>
	                <tr>
	                    <th>입찰키워드(1차/2차)</th>
	                    <td>${kwCntInfo.kw1Cnt}/${kwCntInfo.kw2Cnt}</td>
	                    <th>광고클릭수(전일)</th>
	                    <td>100</td>
	                </tr>
	                
	                
	                <tr>
	                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>재정</th>
	                    <th class='info'>포인트 잔액</th>
	                    <td>${memberInfo.point}</td>
	                    <th>이달충전금액</th>
	                    <td>${recentMonthSaveSum}</td>
	                </tr>
	                <tr>
	                    <th>이달 집행금액</th>
	                    <th>${recentMonthUseSum}원</th>
	                    <th>전일 집행금액</th>
	                    <th>${yesterdayUseSum}원</th>
	                </tr>
	            </thead>
	            
	        </table>
	    </div>
	</div>
</div>
	</script>
	

</body>

</html>

