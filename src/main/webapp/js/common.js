
function memberInfo(){
	
	location.href="member.jsp?#/view/"+USERINFO.memberSq;
}
function detailAdDashboard(memberSq){
	window.open('md_report_period.jsp?memberSq='+memberSq,'GoogleWindow', 'width=800, height=600');
}
function detailMdUnit(memberSq){
	window.open('md_ad_unit.jsp?memberSq='+memberSq,'GoogleWindow', 'width=800, height=600');
}
function detailMdMember(memberSq){
	window.open('md_member.jsp?memberSq='+memebrSq+'#/'+memberSq+'/view','GoogleWindow', 'width=800, height=600');
}

function detailDashboard(memberSq){
	window.open('at_report_ad.jsp?memberSq='+memberSq,'GoogleWindow', 'width=800, height=600');
}
function detailMember(memberSq){
	window.open('at_member.jsp?memberSq='+memberSq+'#/'+memberSq+'/view','GoogleWindow', 'width=800, height=600');
}
function detailPoint(memberSq){
	window.open('at_point.jsp?memberSq='+memebrSq+'#/'+memberSq,'GoogleWindow', 'width=800, height=600');
}
function detailMdDaily(memberSq){
	window.open('md_daily_mc.jsp?memberSq='+memebrSq+'#/memberSq='+memberSq,'GoogleWindow', 'width=800, height=600');
}
function detailAcDaily(memberSq){
	window.open('at_daily_ac.jsp?memberSq='+memebrSq+'#/memberSq='+memberSq,'GoogleWindow', 'width=800, height=600');
}