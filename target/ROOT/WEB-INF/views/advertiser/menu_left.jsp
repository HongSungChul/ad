<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                       
                        
                        
                         <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i>광고신청<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="ad_info.jsp?#ad_info">광고정보등록</a>
                                </li>
                                <li>
                                    <a href="adm_req.jsp?#adm_req">광고신청</a>
                                </li>
                              
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                         <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i>광고관리<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="adm.jsp?#adm">광고물</a>
                                </li>
                                <li>
                                    <a href="bidding.jsp?#bidding">입찰현황</a>
                                </li>
                                <li>
                                    <a href="advertising.jsp?#advertising">집행현황</a>
                                </li>
                              
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        
                         
                         <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i> 포인트관리<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="fill_log.jsp?#fill_log">충전내역</a>
                                </li>
                                <li>
                                    <a href="point_log.jsp?#point_log">포인트적립내역</a>
                                </li>
                              
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li><a href="report.jsp?#/"><i class="fa fa-table fa-fw"></i> 보고서</a></li>
                        
                        <li><a href="member.jsp?#/view/<c:out value="${sessionScope.userInfo.memberSq}"/>"><i class="fa fa-table fa-fw"></i> 회원정보</a></li>
                          
                       
                        
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        