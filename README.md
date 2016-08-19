# 브랜드 박스


## 목차 

- [설치](#설치)
- [소개](#소개)
- [프로세스](#프로세스)
- [Todo](#todo)

## Install


1.  os

	centos-release-6-6.el6.centos.12.2.x86_64
2.  톰켓
	 
-- 톰켓 다운로드

```sh
#cd /opt
#mkdir tomcat
#wget http://mirror.apache-kr.org/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.zip
```


-- 컨넥터 다운로드

```sh 
#wget http://apache.tt.co.kr/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.40-src.tar.gz
# gunzip  tomcat-connectors-1.2.40-src.tar.gz
# tar -xvf tomcat-connectors-1.2.40-src.tar

#cd /opt/tomcat/tomcat-connectors-1.2.40-src/native

#sh ./buildconf.sh
#yum install autoconf
#yum install autoconf
#yum install libtool
#sh ./configure --with-apxs=/usr/sbin/apxs
#make && make install

# find / -name "mod_jk.so"
		>/opt/tomcat/tomcat-connectors-1.2.40-src/native/apache-2.0/mod_jk.so
		
# vi /etc/httpd/conf/httpd.conf	
        
Include conf.d/*.conf
Include /opt/tomcat/tomcat-connectors-1.2.40-src/conf/httpd-jk.conf ==>추가
 

 ## vi /opt/tomcat/tomcat-connectors-1.2.40-src/conf/httpd-jk.conf 
    
    	LoadModule jk_module modules/mod_jk.so

		JkWorkersFile /opt/tomcat/tomcat-connectors-1.2.40-src/conf/workers.properties
		
		JkMountFile /opt/tomcat/tomcat-connectors-1.2.40-src/conf/uriworkermap.properties
		
		JkLogFile /opt/tomcat/apache-tomcat-8.0.15/logs/mod_jk.log
		
		JkLogLevel info
		
		JkLogstampFormat "[%a %b %d %H:%M:%S %Y]"
		
		JkOptions +ForwardKeySize +ForwardURICompat -ForwardDirectories
		
		JkRequestLogFormat "%w %V %T"
		
	#mv workers.properties workers.properties.origin
	mv workers.properties.minimal workders.properties
	# vi uriworkermap.properties
	
		/wikibox/*=lb >추가 
	# vi /etc/init.d/tomcat
	#!/bin/sh
		# description: Tomcat Start Stop Restart
		# processname: tomcat
		# chkconfig: 234 20 80
		#JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.51-1.b16.el6_7.x86_64/
		#export JAVA_HOME
		#PATH=$JAVA_HOME/bin:$PATH
		#export PATH
		#Source function library.
		. /etc/rc.d/init.d/functions
		source /etc/profile
		export TOMCAT_HOME=/opt/tomcat/apache-tomcat-8.0.24
		# See how we were called.
		case "$1" in
		start)
		echo -n "Starting tomcat EXPERIMENTAL: "
		daemon $TOMCAT_HOME/bin/startup.sh
		echo
		;;
		stop)
		echo -n "Shutting down tomcat EXPERIMENTAL: "
		daemon $TOMCAT_HOME/bin/shutdown.sh
		echo
		;;
		restart)
		$0 stop
		$0 start
		;;
		*)
		echo "Usage: $0 {start|stop|restart}"
		exit 1
		esac
		exit 0
	#chmod +x /opt/tomcat/apache-tomcat-8.0.24/bin/startup.sh
	#chmod 755 /etc/init.d/tomcat
  	#chkconfig --add tomcat
  	#service tomcat restart
  	 
```

3.  mysql

```sh

#mysql
#create database brandbox

CREATE USER 'brandbox'@'localhost' IDENTIFIED BY 'qmfosemqkrtm';
GRANT ALL PRIVILEGES ON * . * TO 'qmfosemqkrtm'@'localhost';


grant all privileges on brandbox.* to brandbox@'%' identified by 'qmfosemqkrtm' with grant option;

ALTER DATABASE brandbox CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'

```
[브랜드박스 스키마 생성](./brandbox.sql)

[브랜드박스 초기데이타 생성](./brandbox_data.sql)

4.  자바

```sh
#yum list java*jdk-devel => 버젼확인 
#yum install java-1.8.0-openjdk-devel.x86_64 => 설치
#rpm -qa java*jdk-devel => 설치확인
```
5.   배치잡 

광고주 정산

매체정산

광고집행

## 소개 

브랜드 박스 소개

## 프로세스 
```sh
   1. 카테고리 등록 
   		1차카테고리,2차카테고리 - 카테고리명, 소트순서, 등록일
   2. 1차키워드 등록 
      - 카테고리 선택,1차키워드명,소트순서,최소입차액,상태(활성/비활성),키워드유형(브랜드/분류),수정일 입력
      * 상태- 활성/비활성 구분은 
      		비활성 - 광고주가 광고신청시 표시 안됨
      			 - 광고에 2차키워드 표시 안됨 
      
   3. 2차키워드 등록
      -1차키워드 선택 , 소트순서,상태(활성/비활성)  입력.
      *비활성 - 광고주가 광고신청시 표시 안됨
      			 - 광고에 2차키워드 표시 안됨 
   4. 회원소속을 '매체'로 가입
      회원아이디(*),패스워드(*), 회원소속(매체/광고주/대행사)(*),사업자번호,연락처(*),이메일(*),상호,예치금(*),보너스(*),등록일 로 가입
   5. @서비스 생성 
      적립포인트,서비스명,회원번호,도메인,광고유형(서치/매칭) 입력.
      
      광고유형일경우 @카테고리 정열순으로 보여주면 1개 이상 선택하도록. @서비스카테고리에 입력됨  
      
   6. 광고단위 생성
   	  서비스일련번호 선택,광고크기(2가지),이름,회원코드,등록일,수정일로 입력
   	  
   	  @서비스.$광고휴형이 서치일경우 <script src='http://brandbox.co.kr/[광고단위코드]/[키워드]'><script>
   	  @서비스.$광고휴형이 매칭일경우 <script src='http://brandbox.co.kr/[광고단위코드]'><script>
   
   7. 광고주 가입(회원소속을 '광고주' 로)
      회원아이디(*),패스워드(*), 회원소속(매체/광고주/대행사)(*),사업자번호,연락처(*),이메일(*),상호,예치금(*),보너스(*),등록일 로 가입
      
   8. 광고주대상 아이디에게 관리자가 포너스 포인트 적입해준다.   	   
   	   @포인트적립내역에 포인트, 출처(보너스),적리유형(관리자),회원번호,설명, 등록일  입력,
   	   @회원.$보너스 에 적립되는 보너스만큼 +
   	   
   9. 광고주가 카드로 충전한다.
   	   @충전내역에 ,예치금, 충전유형(카드),설명,등록일 입력.
   	   @회원.$예치금에 충전되는 예치금 적립(10% 부가가치세 포함되는 금액)
   	   @포인트 적립내역에 포인트, 출처(예치금),적립유형(충전),회원번호,설명, 등록일  입력
   10. 광고정보 등록.
   	회원코드,이미지,제목,설명,링크 등록,
   
   11. 광고물 생성 
   		내가 등록한 @광고정보 선택하면 이미지 ,제목,설명,링크가 선택된다.
   		2차키워드 선택(중복선택 1 이상),요청유형(요청중),회원코드  입력한다.
   		
   12. 관리자 광고물 신청내역 심사하여 반려/승인
   		광고물 신청내역에 수정/신청 한 내역조회한다.
   		광고물 신청한내역 조회하여 승인시
   			-@광고물(별칭은 제목을 대체), @광고물키워드 테이블에 입력
   			 -@알림 입력
   		광고물 변경 승인시 
   			-@광고물(이미지,제목,설명,링크) 수정
   			-@알림 입력 	
   
   13. 광고물 수정요청.
   		내 광고물 내역에서 수정요청함.
   14. 입찰하기
   		광고물의 포함된 키워드를 선택하여 입찰한다.
   			광고물일련번호,1차키워드일련번호,2차키워드일련번호, 회원코드, 금액을 @입찰 에 입력
   15. 입찰취소
   16. 광고집행 
   		- 시스템이 프로세스에 의해 결정
   		- 2차키워드 3순위내를 @광고집행(광고물일련번호,1차키워드일련번호,2차키워드일련번호, 회원코드,낙찰금액,정렬순서,이미지,제목,설명,링크등록일 )에 등록
   		 
   17. 매체 회원이 광고스크립트코드를 소스안에 삽입.
   
   18. 매체회원의 광고서버에 광고요청 
   		- @서비스.$광고유형 '서치' 일 경우
   			if [키워드]
   				 if(@광고물.$1차키워드명==[키워드])
   				 	노출순서는 광고주수,최고입찰가,입찰일 순으로 2차키워드 노출
   				 	@광고집행.$정렬순서는 위의 순으로 만들어 낸다. 
   				 else
   				 	광고없음
   			else
   				광고없음	 
   					 
   		-@서비스.$광고유형 '매칭' 일 경우
   			@서비스카테고리.$1차키워드 를 가져온다.
   			@광고집행과 조인하여 광고키워드중 5개를 가져와서 1개를 랜덤하게 1차키워드선택하여 광고를 보여준다.
   			
		-광고노출시에
			@노출로그에 
				1차키워드일련번호,2차키워드일련번호,광고단위일련번호,광고물일련번호,아이피,레퍼러,등록일 입력한다ㅣ.
		-광고릭시에 
			@클릭로그에
				1차키워드일련번호,2차키워드일련번호,광고단위일련번호,광고물일련번호,낙찰금액,아이피,레퍼러,등록일 입력한다ㅣ
			@포인트사용내역에 
				포인트는 @회원.$예치금을 먼저 소진. 없으면 @회원.$보너스 소진.
				그래도 없으면 ,광고중지(광고집행 내역에서 삭제하고 후보를 올린다.) 
				
				포인트(낙참금액),사용유형(광고물크릭),포인트출처(*),회원번호,설명,등록일 입력  
	19. 매체 회원인 경우 매출조회
		1. 광고단위별 날짜, 노출수, 클릭수 , 매출금액 을 보여줌.			 	
		2. 서비스별 날짜, 노출수,클릭수,매출금액을 보여줌.
	   	3. 전체 날짜 ,노출수 ,클릭수 매출금액을 보여줌.
	   	
	20 관리자의 매체매출조회
		1. 회원별 날짜, 노출수 클릭수 매출금액을 보여줌,
		2. 회원 서비스별 노출수,클리수, 매출금액을 보여줌.
		3. 회원 광고단위별,날짜,노출수 클릭수 매출금액 보여줌.
	21 관리자의 매체 정산
		1. 회원별 날짜검색 지원하여 총 매출금액 보여줌
	
	22. 광고주에게 소진내역조회.
	
		1. 일별 1,2차키워드 조회수,노출수, 매출금액을 보여줌
		2. 광고물별 일별, 조회수,노출수, 매출금액을 보여줌
			   	

```

## Todo

* mysql를 몽고디비로 포팅 



