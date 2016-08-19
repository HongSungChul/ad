<%@ page language="java" contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
//document.write('<div id="brandbox_area"></div>');
/*
 function callbackFunc(){
 	var fileref=document.createElement("link")
    fileref.setAttribute("rel", "stylesheet")
    fileref.setAttribute("type", "text/css")
    //fileref.setAttribute("href", "http://125.209.200.159:8080/ad/api/ad.css")
    fileref.setAttribute("href", "http://125.209.200.159:8080/ad/api/ad.css")
     document.getElementsByTagName("head")[0].appendChild(fileref)
 }
(function(url, callback){

    var script = document.createElement("script")
    script.type = "text/javascript";

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
})('http://brandbox.kr/ad/api/adSearch.js?query='+brandboxKeyword+'&adUnitSq='+brandboxAdUnit,callbackFunc);
*/

var jsonp = {
    callbackCounter: 0,
 
    fetch: function(url, callback) {
        var fn = 'JSONPCallback_' + this.callbackCounter++;
        window[fn] = this.evalJSONP(callback);
        url = url.replace('=JSONPCallback', '=' + fn);
 
        var scriptTag = document.createElement('SCRIPT');
        scriptTag.src = url;
        document.getElementsByTagName('HEAD')[0].appendChild(scriptTag);
    },
 
    evalJSONP: function(callback) {
        return function(data) {
            var validJSON = false;
        if (typeof data == "string") {
            try {validJSON = JSON.parse(data);} catch (e) {
                /*invalid JSON*/}
        } else {
            validJSON = JSON.parse(JSON.stringify(data));
                window.console && console.warn(
                'response data was not a JSON string');
            }
            if (validJSON) {
                callback(validJSON);
            } else {
                throw("JSONP call returned invalid or empty JSON");
            }
        }
    }
}
//console.log(document.location.host);
//console.log("referer"+document.referrer);
var parser = document.createElement('a');
parser.href = document.referrer;
//console.log(parser.host);

//console.log(document.location.host);
var bbkwd="";
if(brandboxKeyword!=undefined) bbkwd=brandboxKeyword;
var reddits = "http://brandbox.kr/ad/api/ad_confirm?callback=JSONPCallback&query="+bbkwd+"&adUnitSq="+brandboxAdUnit+"&adClient="+brandboxAdClient;
if(parser.host!=document.location.host){
	reddits+="&originHost="+encodeURIComponent(parser.host);
}
jsonp.fetch(reddits , function(data) {
	//console.log(data);
	
	if(data.num>0){
		bxarea= document.getElementById('brandbox_area');
		
		if(brandboxAdClient.charAt(0)=='a') {//검색광고 
			bxarea.innerHTML='<div><iframe id="brandbox_ads_frame" name="brandbox_ads_frame" width="'+brandboxAdWidth+'&requestSq='+data.requestSq+'&adClient='+brandboxAdClient+'" height="'+brandboxAdHeight+'" frameborder="0" src="http://brandbox.kr/ad/api/adSearch.htm?query='+brandboxKeyword+'&adUnitSq='+brandboxAdUnit+'&adWidth='+brandboxAdWidth+'&adHeight='+brandboxAdHeight+'&adClient='+brandboxAdClient+'" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no" allowfullscreen="true"></iframe></div>';
		}else{ // 매칭광고 
			bxarea.innerHTML='<div><iframe id="brandbox_ads_frame" name="brandbox_ads_frame" width="'+brandboxAdWidth+'" height="'+brandboxAdHeight+'" frameborder="0" src="http://brandbox.kr/ad/api/adMatch.htm?adUnitSq='+brandboxAdUnit+'&adWidth='+brandboxAdWidth+'&adHeight='+brandboxAdHeight+'&adClient='+brandboxAdClient+'&requestSq='+data.requestSq+'" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no" allowfullscreen="true"></iframe></div>';
		}
	
	}
});

 
 

/*if(brandboxAdClient.charAt(0)=='a')
	document.write('<div><iframe id="brandbox_ads_frame" name="brandbox_ads_frame" width="'+brandboxAdWidth+'" height="'+brandboxAdHeight+'" frameborder="0" src="http://brandbox.kr/ad/api/adSearch.htm?query='+brandboxKeyword+'&adUnitSq='+brandboxAdUnit+'&adWidth='+brandboxAdWidth+'&adHeight='+brandboxAdHeight+'&adClient='+brandboxAdClient+'" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no" allowfullscreen="true"></iframe></div>');
else 
	document.write('<div><iframe id="brandbox_ads_frame" name="brandbox_ads_frame" width="'+brandboxAdWidth+'" height="'+brandboxAdHeight+'" frameborder="0" src="http://brandbox.kr/ad/api/adMatch.htm?adUnitSq='+brandboxAdUnit+'&adWidth='+brandboxAdWidth+'&adHeight='+brandboxAdHeight+'&adClient='+brandboxAdClient+'" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no" allowfullscreen="true"></iframe></div>');

*/
/*(function(){
	adList= ${adList};
	adUnitSq="${param.adUnitSq}";
	document.write('<div id="bb_area" style="width:300px; height:300px; border:1px solid gray;"><div>');
	
})();
*/
