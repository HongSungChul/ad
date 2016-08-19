<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>


    <title>로그인</title>
    <script>
    	adList= ${adList};
    	requestSq= ${param.requestSq};
    	adUnitSq="${param.adUnitSq}";
    	function showImage(idx){
    		/*var childs = document.getElementById("bbImages").getElementsByTagName('li');
    		//console.log(childs.length);
    		for(i=0; i<childs.length; i++){
    			//console.log(childs[i]);
    			if(i==idx){
    				childs[i].style.display='';
    			}else{
    				childs[i].style.display='none';
    			}
    		}*/
    	}
    	
    </script>
</head>

<body>
	<c:if test="${ !empty adList }">
    <div id="bb_area" style="width:300px; height:300px; border:1px solid gray;">
    	<div style="background-color:gray;text-align:right">
    		'${param.query}' 에 대한 검색결과
    	</div>
    	<div style="backgro und-color:blue;display:inline-block;vertical-align:top;">
    		<ul style="padding:0xp; margin:0px;" id="kw2Names"></ul>
    	</div>
    	<script>
   		for(var i=0 ;i<adList.length; i++){
   			var li = document.createElement("li");
   			li.style='list-style-type: circle;';
   			li.onclick = (function(i) {
   			      var currentI = i;
   			      
   			      return function() { 
   			          onClickLink(currentI );
   			      }
   			})(adList[i]);
   			li.innerText=adList[i].kw2Name;
   			document.getElementById("kw2Names").appendChild(li);
   		}
    	function onClickLink(ainfo){
    		
    		var ads = document.querySelectorAll(".bb_ad");
    		
    		for(var i=0; i<ainfo.adList.length; i++){
    			var iwidth=180;
    			var iheight=180;
    			if(i!=0){
    				iwidth=80;
    				iheight=80;
    			}
    			//console.log(ads[i]);
    			ads[i].innerHTML='<img  src="http://125.209.200.159'+ainfo.adList[i].imgUri+'"  width="'+iwidth+'" height="'+iheight+'"/>';
    			//console.log('<img  src="http://125.209.200.159'+ainfo.adList[i].imgUri+'"  width="'+iwidth+'" height="'+iheight+'"/>');
    			ads[i].setAttribute('href','/ad/api/click?url='+encodeURIComponent(ainfo.adList[i].link)+'&admSq='+ainfo.adList[i].admSq+'&kw1Sq='+ainfo.adList[i].kw1Sq+'&kw2Sq='+ainfo.adList[i].kw2Sq+'&adUnitSq='+adUnitSq+'&requestSq='+requestSq);
    			
    			//console.log(ads[i]);
    			//console.log('dddddd');
    			
    		}
    		addViewLog(ainfo);
    		//console.log(ads);
    	}
    	function addViewLog(ainfo){
    		if (window.XMLHttpRequest)
    		  {// code for IE7+, Firefox, Chrome, Opera, Safari
    		  xmlhttp=new XMLHttpRequest();
    		  }
    		else
    		  {// code for IE6, IE5
    		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    		  }
    		
    		/*var  adUrls="http://brandbox.kr/ad/api/view?admSq="+ainfo.admSq+"&kw1Sq="+ainfo.kw1Sq+"&kw2Sq="+ainfo.kw2Sq;
    		for(var i=0; i<ainfo.adList.length; i++){
    			adUrls+="&adUnitSq1="+ainfo.adList[i].adUnitSq;
    		}*/
    		/*headers: { 
    		    'Accept': 'application/json',
    		    'Content-Type': 'application/json' 
    		}*/
    		//console.log(xmlhttp);
    		ainfo['adUnitSq']=adUnitSq;
    		ainfo['requestSq']=requestSq;
    		xmlhttp.open("POST","http://brandbox.kr/ad/api/view",true);
    		xmlhttp.setRequestHeader("Accept","application/json");
    		xmlhttp.setRequestHeader("Content-Type","application/json");
    		xmlhttp.send(JSON.stringify(ainfo));
    		//xmlhttp.send((ainfo));
    	}
    		
    	
    	</script>
    	<div style="backgroun d-color:red;display:inline-block">
    		<ul id="bbImages" style="margin:0px; padding:0px;">
    			<li style="padding:0xp;list-style-type:none">
    				<a  target="_new" class="bb_ad"></a>
    			</li>
    			<li style="padding:0xp;list-style-type:none;">
    				<a  target="_new" class="bb_ad"></a>
    				<a  target="_new" class="bb_ad"></a>
    			</li>
    			
    		</ul>
    		
    		
    	</div>
    	<script>onClickLink(adList[0]);</script>
    </div>
    
	</c:if>
</body>

</html>
