<%@ page language="java" contentType="text/css; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


.searchListWrap {
    border: 1px solid #e1e1e1;background-color: #fff;padding-top: 0px;margin-bottom: 0px;
}
.promotionBanner {
    margin: 0 1px 0px;overflow: hidden;
}

.tabMenu {
    margin-top:5px;height: 31px;margin-bottom: 10px;border-bottom: 1px solid #222;
}
.tabMenu li.on {
    height: 31px;border-color: #222;background-color: #fff;z-index: 2;
}

.tabMenu li {
    list-style-type: none; float: left;width: 177px;height: 30px;margin-left: -1px;border: 1px solid #ddd;border-bottom: 0;text-align: center;position: relative;z-index: 1;
}

.tabMenu li span {
    display: block;padding-top: 7px;
}

.tabMenu li.on span {
    font-weight:bold;
}

.tabItemBox li {
    float: left;width: 150px;margin-left: 22px;text-align: center;overflow:hidden;
}
.tabItemBox li div span {
    display: inline-block;width: 100%;
}
.tabItemBox li div span.title {
    height: 28px;overflow: hidden;font: 12px dotum,"돋움",sans-serif;color: #666;
}
.tabItemBox li div span.price {
    margin-bottom: 2px;font-weight: bold;color: #e25741;
}