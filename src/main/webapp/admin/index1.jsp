<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--
* INSPINIA - Responsive Admin Theme
* Version 2.3
*
-->
<script>
<%
	ObjectMapper mapper = new ObjectMapper();
 	
 %>
 USERINFO=<%=mapper.writeValueAsString(session.getAttribute("userInfo"))%>;
 if(USERINFO==null){
	 location.replace("login.jsp");
 }
</script>
<!DOCTYPE html>
<html lang="ko" ng-app="app" ng-controller="ListController">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Page title set in pageTitle directive -->
    <title page-title></title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Font awesome -->
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Main Inspinia CSS files -->
    <link href="css/animate.css" rel="stylesheet">
    <link id="loadBefore" href="css/style.css" rel="stylesheet">


</head>

<!-- ControllerAs syntax -->
<!-- Main controller with serveral data used in Inspinia theme on diferent view -->
<body landing-scrollspy id="page-top">

<!-- Main view  -->
   <!-- Wrapper-->
<div id="wrapper">

    <!-- Navigation -->
    <div ng-include="'views/common/navigation.htm'"></div>

    <!-- Page wraper -->
    <!-- ng-class with current state name give you the ability to extended customization your view -->
    <div id="page-wrapper" class="gray-bg">

        <!-- Page wrapper -->
        <div ng-include="'views/common/topnavbar.htm'"></div>

        <!-- Main view  -->
        <!-- Page Content -->
        <div>
            <div class="container-fluid">
                <div class="row">
                    
                        <h1 class="page-header">광고현황</h1>
                    
                    <!-- /.col-lg-12 -->
                </div>
                
                <!-- /.row -->
                <div class="row">
	                
	                <div ng -view>
	                
	                
						<div class="panel panel-default">
							
							<div class="panel-body">
								<blockquote>
									<p>전체요약정보</p>
								</blockquote>
								<div class="table-responsive"> 
							        <table class="table table-bordered">
							            <thead>
							                <tr>
							                    <th rowspan=4 class='success text-center' style='vertical-align:middle'>광고집행현황</th>
							                    <th>전체광고물(이달신규)</th>
							                    <td>000(100)</td>
							                    <th>광고집행광고물*</th>
							                    <td>100</td>
							                    
							                </tr>
							                <tr>
							                    <th>입찰키워드(1차/2차)*</th>
							                    <td>0000/100</td>
							                    <th>1차키워드요청수*</th>
							                    <td>100</td>
							                </tr>
							                <tr>
							                    <th>광고노출수*</th>
							                    <td>000</td>
							                    <th>광고클릭수*</th>
							                    <td>000</td>
							                </tr>
							                <tr>
							                    <th>평균CPC*</th>
							                    <td>000</td>
							                    <th>클릭율*</th>
							                    <td>000</td>
							                </tr>
							                
							                <tr>
							                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>재정</th>
							                    <th class='info'>포인트 잔액</th>
							                    <td>0000</td>
							                    <th>이달충전금액</th>
							                    <td>1122</td>
							                </tr>
							                <tr>
							                    <th>이달 매출액</th>
							                    <th>110원</th>
							                    <th>전일 매출액</th>
							                    <th>1110원</th>
							                </tr>
							                <tr>
							                    <th rowspan=2 class='success text-center' style='vertical-align:middle'>심사요청</th>
							                    <th class='info'>신규요청</th>
							                    <td><a href="adm_req.jsp?adm_req#/adm_req">11</a></td>
							                    <th>변경요청</th>
							                    <td><a href="adm_req.jsp?adm_req#/adm_req">11</a></td>
							                </tr>
							            </thead>
							            
							        </table>
							    </div>
							    <!-- 
							    <blockquote>
									<p>신규 광고주 정보</p>
								</blockquote>
								<div class="table-responsive"> 
							        <table class="table table-bordered">
							            <thead>
							                <tr>
							                    <th>순위</th>
							                    <th>업체명(담당자)</th>
							                    <td>1차키워드</td>
							                    <th>평균 CPC</th>
							                    <td>일평균 클릭수</td>
							                    <td>일평균 광고집행액</td>
							                    <td>예치금 잔액</td>
							                </tr>
							            </thead>
							            
							        </table>
							    </div>
							    
							    <blockquote>
									<p>광고주 매출 현황</p>
								</blockquote>
								<div class="table-responsive"> 
							        <table class="table table-bordered">
							            <thead>
							                <tr>
							                    <th>순위</th>
							                    <th>업체명(담당자)</th>
							                    <td>1차키워드</td>
							                    <th>평균 CPC</th>
							                    <td>일평균 클릭수</td>
							                    <td>일평균 광고집행액</td>
							                    <td>예치금 잔액</td>
							                </tr>
							            </thead>
							            
							        </table>
							    </div>
							     -->
							</div>
						</div>
					
	                </div>
                    
                </div>    
                    
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

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
    
    <!-- Custom Theme JavaScript -->
    <script src="/ad/js/sb-admin-2.js"></script>
    <script src="/ad/js/jquery.dataTables.min.js"></script>
    <script src="/ad/js/bootbox.min.js"></script>
	<script src="/ad/js/bootstrap-treeview.js"></script>
	<script src="/ad/js/common.js"></script>

<!--
 You need to include this script on any page that has a Google Map.
 When using Google Maps on your own site you MUST signup for your own API key at:
 https://developers.google.com/maps/documentation/javascript/tutorial#api_key
 After your sign up replace the key in the URL below..
-->



<script>
	
		function detail(){
			window.open('at_main.jsp','GoogleWindow', 'width=800, height=600');
		}
	</script>
	<script>
	
	
		
		
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
		
	    var appControllers = angular.module('appControllers', []);	 
	    
	    
	      
	    
	    appControllers.controller('ListController',function($scope,$routeParams,$location,$modal){
	    	
			
	    	//console.log($routeParams.member_sq);
	    	$scope.table = $('#table').dataTable( {
	    		"initComplete": function(settings, json) {
	    		},
	    		"language": {
	    	        "emptyTable":     "관련된 데이타가 없습니다.",
	    	        "sSearch": "검색어:"
	    	    },
	    	    "sScrollY": "300px",
	    	    "bLengthChange": false, // hide show entries
	    	    "bFilter": false,
    			"paging": false,
    			"bInfo": false,
    			"order": [],
    			"bSort":true,
    			
    			"data":[{ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:1200},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:234},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:100},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:100},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:200},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:40},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:30},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:24},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:34},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:33},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:11},
    			        {ad_info_sq:1,regDate:'2015.0.10',view_count:20,click_count:20,click_ratio:'10.4%',cpc:'100원',amount:44}
    			        ]
	    	    ,
    			"columnDefs": [ 
					
		            {"targets": 0,"data": "regDate"},
		            {"targets": 1,"data": "view_count"},
		            {"targets": 2,"data": "click_count"},
		            {"targets": 3,"data": "click_ratio"},
		            {"targets": 4,"data": "cpc"},
		            {"targets": 5,"data": "amount"}
		         ],
		         "fnFooterCallback" : function(nRow, aaData, iStart, iEnd,aiDisplay) {
		        	      var iTotalNuma = 0;
		        	      var iTotalNumb = 0;
		        	      var iTotalNumc = 0;
		        	      if (aaData.length > 0) {
		        	       for ( var i = 0; i < aaData.length; i++) {
		        	        iTotalNuma += aaData[i].view_count;
		        	        iTotalNumb += aaData[i].click_count;
		        	        iTotalNumc += aaData[i].amount;
		        	       }
		        	      }
		        	      /*
		        	       * render the total row in table footer
		        	       */
		        	      var nCells = nRow.getElementsByTagName('th');
		        	      nCells[1].innerHTML = iTotalNuma;
		        	      nCells[2].innerHTML = iTotalNumb;
		        	      nCells[3].innerHTML = iTotalNumb/iTotalNuma;
		        	      nCells[5].innerHTML = iTotalNumc;

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
		
		
	
	

</body>
</html>
