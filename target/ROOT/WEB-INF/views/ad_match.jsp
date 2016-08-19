<%@ page language="java" contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    	
 <!--    
(function(){
	var adList= ${adList};
    requestSq= "${param.requestSq}";
    adUnitSq="${param.adUnitSq}";
	var new_onclick = function(obj,idx){
		
  		var itembox = document.querySelectorAll(".tabItemBox");
  		
  		var tabbox = document.querySelectorAll(".tabMenu > li");
  		
  		
  		for(i=0; i<tabbox.length; i++){
  			if(obj.dataset.index==i){
  				tabbox[i].className = "on";
  				tabbox[i].style.fontWeight='bold';
  				itembox[i].style.display='inline';
  				addViewLog(adList[i]);
  			}else{
  				tabbox[i].className = "off";
  				tabbox[i].style.fontWeight='normal';
  				itembox[i].style.display='none';
  			}
  		}
  		//addViewLog(adList[idx]);
  		
  	};
  	
	function adCreateTag(tagName,items){
		var obj = document.createElement(tagName);
		for(var vkey in items) {
  			obj.setAttribute(vkey,items[vkey]);
		}
		return obj;
	}
	function adCreateItem(adItem){
		var tab = adCreateTag('li',{});
		var adLink = 'http://brandbox.kr/ad/api/click?url='+encodeURIComponent(adItem.link)+'&admSq='+adItem.admSq+'&kw1Sq='+adItem.kw1Sq+'&kw2Sq='+adItem.kw2Sq+'&adUnitSq='+adUnitSq+'&requestSq='+requestSq;
		tab.innerHTML='<a href="'+adLink+'" target="_blank">'+
				'<img src="http://brandbox.kr/'+adItem.imgUri+'" width=150 height=150>'+
				'		<div>'+
				'			<span class="title">'+adItem.title+'</span>'+
				'		</div>'+
				'	</a>';
		return tab;			
	}
	function adCreateTab(name){
		
	}
	function addAd(adTabContiner,adBox){
		for(i=0; i<adList.length; i++){
			
			var tab = adCreateTag('li',{'class':i==0?'on':'off','data-index':i});
			tab.innerHTML='<span>'+adList[i].kw2Name+'</span>';
			if (tab.addEventListener) {
			    tab.addEventListener('mouseover', function() {new_onclick(this,i)}, false);
				    
			} else { // IE
			    tab.attachEvent('onmouseover', function() {new_onclick(this,i)});
			    
			}
			adTabContiner.appendChild(tab);
			
			var itemContainer = adCreateTag('ul',{'class':'tabItemBox product list-inline','data-index':'0','style':i==0?'inline':'display:none'});
		
			var adItems = adList[i].adList;
			
			for(j=0; j<adItems.length; j++){
				itemContainer.appendChild(adCreateItem(adItems[j]));
			}
			
			adBox.appendChild(itemContainer);
				
		}
		if(adList.length>0){
			addViewLog(adList[0]);
		}
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
    		
    		
    		ainfo['adUnitSq']=adUnitSq;
    		ainfo['requestSq']=requestSq;
    		console.log(ainfo);
    		console.log(JSON.stringify(ainfo));
    		xmlhttp.open("POST","http://brandbox.kr/ad/api/view",true);
    		xmlhttp.setRequestHeader("Accept","application/json");
    		xmlhttp.setRequestHeader("Content-Type","application/json");
    		xmlhttp.send(JSON.stringify(ainfo));
    		
    }
	function adInit(){
		
		var container = adCreateTag('div',{'class':'searchListWrap' ,'style':'overflow:scroll'});
		var box = adCreateTag('div',{'class':'promotionBanner','style':'width:'+(adList.length*200)+'px'});
		
		var tabContainer = adCreateTag('ul',{'class':'tabMenu'}); // tabMenu
		
		box.appendChild(tabContainer);
		container.appendChild(box);
		var brandboxArea = document.getElementById('brandbox_area');
		
		brandboxArea.style.width=brandboxAdWidth+'px';
		brandboxArea.style.height=brandboxAdHeight+'px';
		brandboxArea.style.overflow='hidden';
		brandboxArea.appendChild(container);
		
		
		addAd(tabContainer,box);
		
	}
	adInit();
})();

 -->