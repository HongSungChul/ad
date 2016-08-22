# 브랜드 박스


## 목차 

- [설치](#설치)
- [개발환경](#개발환경)
- [기능정의](#기능정의)
- [프로세스](#프로세스)
- [ERD](#ERD)
- [API](#API)
- [Todo](#todo)

## 설치


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

3. mysql

```sh

#mysql
#create database brandbox

CREATE USER 'brandbox'@'localhost' IDENTIFIED BY 'qmfosemqkrtm';
GRANT ALL PRIVILEGES ON * . * TO 'qmfosemqkrtm'@'localhost';


grant all privileges on brandbox.* to brandbox@'%' identified by 'qmfosemqkrtm' with grant option;

ALTER DATABASE brandbox CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci'

```
[브랜드박스 스키마 생성](./documents/brandbox.sql)

[브랜드박스 초기데이타 생성](./documents/brandbox_data.sql)

4. 자바

```sh
#yum list java*jdk-devel => 버젼확인 
#yum install java-1.8.0-openjdk-devel.x86_64 => 설치
#rpm -qa java*jdk-devel => 설치확인
```
5. 배치잡 
```sh
광고주 정산

매체정산

광고집행
```

## 개발환경

```sh
	
1. 이클립스(mars)

2. 스프링 프레임워크 

3. dependencies

	<dependencies>
		<dependency>
		    <groupId>com.cubrid</groupId>
		    <artifactId>cubrid_jdbc</artifactId>
		    <version>9.2.0.0155</version>
		    <scope>system</scope>
		    <systemPath>${project.lib.path}/lucene-analyzers-common-4.10.3.jar</systemPath>
		</dependency>
		<dependency>
		    <groupId>com.cubrid</groupId>
		    <artifactId>cubrid_jdbc1</artifactId>
		    <version>9.2.0.01551</version>
		    <scope>system</scope>
		    <systemPath>${project.lib.path}/lucene-core-4.10.3.jar</systemPath>
		</dependency>
		<dependency>
		    <groupId>com.cubrid</groupId>
		    <artifactId>cubrid_jdbc2</artifactId>
		    <version>9.2.0.01551</version>
		    <scope>system</scope>
		    <systemPath>${project.lib.path}/org.snu.ids.ha.jar</systemPath>
		</dependency>
		<!-- Spring -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>${org.springframework-version}</version>
			<exclusions>
				<!-- Exclude Commons Logging in favor of SLF4j -->
				<exclusion>
					<groupId>commons-logging</groupId>
					<artifactId>commons-logging</artifactId>
				 </exclusion>
			</exclusions>
			
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>
				
		<dependency>
	    	<groupId>org.mybatis</groupId>
	    	<artifactId>mybatis-spring</artifactId>
	    	<version>1.0.2</version>
	    	<type>jar</type>
	    	<scope>compile</scope>
	    </dependency>
	    <dependency>
	    	<groupId>mysql</groupId>
	    	<artifactId>mysql-connector-java</artifactId>
	    	<version>5.1.18</version>
	    	<type>jar</type>
	    	<scope>compile</scope>
	    </dependency>
		<dependency>
	    	<groupId>commons-dbcp</groupId>
	    	<artifactId>commons-dbcp</artifactId>
	    	<version>1.4</version>
	    	<type>jar</type>
	    	<scope>compile</scope>
	    </dependency>
	    <dependency>
	    	<groupId>commons-lang</groupId>
	    	<artifactId>commons-lang</artifactId>
	    	<version>2.6</version>
	    </dependency>
	    <dependency>
	    	<groupId>org.apache.httpcomponents</groupId>
	    	<artifactId>httpclient</artifactId>
	    	<version>4.4.1</version>
	    </dependency>
	    <dependency>
	    	<groupId>org.jsoup</groupId>
	    	<artifactId>jsoup</artifactId>
	    	<version>1.8.1</version>
	    </dependency>
	        
		<!-- json request -->        
        <dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-core</artifactId>
		    <version>2.5.4</version>
		</dependency>
		 
		<dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-databind</artifactId>
		    <version>2.5.4</version>
		</dependency>
		
		<dependency>
			<groupId>org.codehaus.jackson</groupId>
			<artifactId>jackson-mapper-asl</artifactId>
			<version>1.9.13</version>
		</dependency>
		
		<dependency>
			<groupId>org.codehaus.jackson</groupId>
			<artifactId>jackson-core-asl</artifactId>
			<version>1.9.13</version>
		</dependency>
		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.3.1</version>
		</dependency>	
		
		<dependency>
		    <groupId>org.imgscalr</groupId>
		    <artifactId>imgscalr-lib</artifactId>
		    <version>4.2</version>
		    <type>jar</type>
		    <scope>compile</scope>
		</dependency>
		<!-- AspectJ -->
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjrt</artifactId>
			<version>${org.aspectj-version}</version>
		</dependency>	
		<dependency>
			<groupId>joda-time</groupId>
			<artifactId>joda-time</artifactId>
			<version>2.1</version>
		</dependency>	
		
		<!-- Logging -->
		<dependency>
			<groupId>ch.qos.logback</groupId>
			<artifactId>logback-classic</artifactId>
			<version>${logback.version}</version>
			<scope>runtime</scope>
			
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>${org.slf4j-version}</version>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>jcl-over-slf4j</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-log4j12</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>
		
		<dependency>
		
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.15</version>
			<exclusions>
				<exclusion>
					<groupId>javax.mail</groupId>
					<artifactId>mail</artifactId>
				</exclusion>
				<exclusion>
					<groupId>javax.jms</groupId>
					<artifactId>jms</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jdmk</groupId>
					<artifactId>jmxtools</artifactId>
				</exclusion>
				<exclusion>
					<groupId>com.sun.jmx</groupId>
					<artifactId>jmxri</artifactId>
				</exclusion>
			</exclusions>
			<scope>runtime</scope>
		</dependency>

		<!-- @Inject -->
		<dependency>
			<groupId>javax.inject</groupId>
			<artifactId>javax.inject</artifactId>
			<version>1</version>
		</dependency>
				
		<!-- Servlet -->
		<dependency>
			 <groupId>javax.servlet</groupId>
	        <artifactId>javax.servlet-api</artifactId>
	        <version>3.1.0</version>
		</dependency>
		<dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>jsp-api</artifactId>
			<version>2.1</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>
	
		<!-- Test -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.7</version>
			<scope>test</scope>
		</dependency>  
		<dependency>
		    <groupId>org.apache.commons</groupId>
		    <artifactId>commons-csv</artifactId>
		    <version>1.1</version>
		</dependency>      
	</dependencies>
```	


## 기능정의 
```sh 
1. 관리자 


-@카테고리 - 1차키워드를 분류화 해서 매체사에서 선택함 -  (서치 /매칭 ) 광고형태

  
-@1차키워드 수집 
	$유형 -(브랜드/분류) 
	$최소입찰금액 등록. EX)100원
	$상태 - 활성/비활성 (default: 비활성)  
		- 비활성시 광고집행에는 영향을 미치지 않으나 광고주가 키워드선택해서 광고물 신청에서는 보이지 않는다.
-@2차키워드 등록 
	$정렬순서
		-소트가능하다
		-언제든지 변경 가능  
	$상태 - 활성/비활성 (default:비활성)
		- 비활성시 광고집행에는 영향을 미치지 않으나 광고주가 키워드선택해서 광고물신청에서는 보이지 않는다.
		
-@광고목업 등록
    $사이즈 형태(100*300,100*200) 만 제공   

-광고주의 광고정보승인
	0. 수정/등록 으로 구분된다.
	2.1차/2차,광고물 정보조회하여 광고에 적합여부 판단하여 승인해준다.
	3.반려시에 반려사유 입력하여 반려한다.
	4.결과처리결과 이메일로 알려준다.(이메일 템플릿 필요)
	
	승인시 입찰할수 있는 광고물 대상이 된다.
	
		
-@광고집행 방법

	주기적(?)으로 실행한다.
	@입찰을 대상으로 하여 @광고집행 만들어 낸다.
	낙찰금액은 3순위내 꼴찌 가격으로 3위까지 선발한다(광고집행 프로세스가 다시돌지 않는 이상 낙찰금액을 그대로 유지한다.)
	 
	$광고집행을 취소시 $입찰정보 , $광고정보삭제 삭제한다.
	광고집행 레코드 상태는 요청/승인/반려/중단
	실시간으로 광고집행을 취소시 $낙찰가격은 변경되지 않는다.
	 
-매체사 정산 
   
   매체사 관리어 어느선까지 할것인가 ?
   @매체일일광고매출 주식적으로  실행하여 입력해준다.
      @노출로그와 @클릭로그를 대상으로해서 @매체일일광고매출 에 기록한다.
   월별검색하여 검색 엑셀로 다운로드 기능제공한다.
    
-광고주 정산
   날짜 | 소진금액 보여준다.
   
2. 매체사 

- 회원등록 
	회원정보(아이디,패스워드 이메일,연락처,매체적립포인트)-필수 
	회사정보 - 선택  
	결제정보 - 선택(금액수령시 필요)  	
- 매체등록
	도메인(구별자) 
- 광고단위 등록 
	등록한 매체 선택
	사이즈 형태(100*300,100*200) 
	광고코드 생성
	<script src='http://도메인/[매체코드]/[키워드]'></script>
-레포트
	매체별 일별 노출수,클릭수,수익을 보여준다.
-정산
	클릭로그,노출로그로 매매 매체일일광고매출에 입력한다.

-메뉴정리 
		
		

3 광고주
 
-회원등록 
	회원정보(아이디,패스워드 이메일,연락처,광고주결제포인트,광고주 + 포인트)-필수
	회사정보 - 선택  
	
-결제 
  -결제목록
  	현금(카드,이체,핸드폰)  결제시 로그 기록된다.
  - 포인트적립로그
  	현금, 이벤트, 관리자 일괄 적립시에 기록
  - 포인트사용로그
  	관리자, 환급, 광고집행시에 기록된다.
-광고정보 등록 
	-광고정보 
   	  이미지 (200*200)?
   	  제목 , 설명 ,링크정보 입력한다.
   	  어느때라도 수정,삭제,가능 
-광고물등록 승인 요청
	-광고정보승인요청
		신규,변경 신청가능핟. 
   		1차/2차 키워드(중복선택가능하도록), 광고정보 선택하고,  승인 요청한다.
   		1차/2차 키워드에 이미승인된 광고정보가 있으면 변경만 가능하다.
   		제목을 대표이름으로 표시한다. 수정가능하도록. 대표이름 중복은 안된다.
   		 
-광고정보 수정 요청
	-승인광고변경요청에 추가하여 관리자한테 승인요청한다. 
		   	  
-입찰 
	-승인된광고정보 선택하여 입찰화면으로 이동 
	-현재 1차/2차에 입찰한 타사의 금액순으로 보여준다
	-가격입력하여 입찰한다.	
	-나의입찰된순위가 반영되어 표시된다.
	-등록된 나의 입찰을 취소시 즉시 광고집행에서 제외된다.
	-광고집행은 입찰정보로 바탕으로 만들어진다.
	 
-관리자페이지 
	계정관리
	광고정보관리
	광고물관리
		광고타이트,키워드,금액/순위, 광고상태, 
	예치금
	통계
		
	
4. 매체사의 일반사용자 (광고노츨)

	-한번등록한 매체유형은 바꿀수 없다.
	- 
	

광고노출과정 

	-매체사가 할당한 광고단위코드(ex)<script src='http://도메인명/[광고단위코드]/[키워드]'></script>) 를 페이지에 삽입한다.
	-광고단위코드,키워드를가지고 @광고집행에서 광고를 선택한다.
	-키워드 매핑이 안되어 있을경우 -- 아예보여주지 않는다. - 로그도 필요없음.
	-브랜드/분류 가 중복등록시 랜덤하게 선택한다.
	-광고집행건이 없는 2차키워드는 보여주지 않는다.
	-광고집행가격은 3순위 가격으로 결정한다.
	-배너광고 형태는 없다.
	
	-키워드를 안넘겨주는경우는 매체대표키워드중 랜덩하게 하나 뽑아서 대신한다.
	-노출로그에 해당하는 1,2차키워드,광고단위일련번호(매체),광고승인일련번호(광고주),아이피,레퍼러 정보를 기록한다.
	-광고클릭시 클릭로그에 기록한다. 오천원 이하에서는 광고집행에서 빠진다.
	
	-광고유형을 고려해야한다.
	

5. 대행사
	- 관리자가 생성한다.
	- 광고주들의 실적 보기 기능만 가능하다.
	- 광고주가 대행사 아이디 입력하여 가입하도록.
	-

5. 프런트 페이지
	- 매체사/광고주 구분하여 가입 따로  받는다.
	- 매채사 가입시에 입력필드 ?
	- 광고주 입력시 입력필드 ?
	- 대행사 필요하다.
	- 관리자 페이지는 따로간다.
	- 페이지,메뉴구성(기획 필요)

6. 코드정리

	$포인트유형 
		-예치금
		-보너스 
		
	@포인트사용내역.$사용유형 
		-광고물크릭	

	@포인트적립내역.$적립유형
		-충전
		-관리자적립
	@1차키워드.$유형 
		-브랜드
		-분류
	@1차키워드.$상태
		-활성
		-비활성
	@2차키워드.$상태
		-활성
		-비활성
					
	@회원.$유형
		-매체
		-광고주
		-대행사
	@광고물신청내역.$상태
		-신규
		-변경
	@광고물신청내역.$결과
		-요청중
		-심사중
		-승인
		-반려 		
 	@광고주충전내역.$충전유형
 		-카드
 		-핸드폰
 	@서비스.$광고유형
 		-서치
 		-매칭
 	

// 키워드 ?
// 알람 테이블 생성 - 예치금부족시 알림()

광고 ON - 광고물이 집행상태에 있을때
광고 OFF -광고가 집행할수 없을때

광고중지 - 광고집행에서 데이타를 빼고
	   - 입찰정보가 없어지고
	   - 대상은 ON 상태에 있는 광고

광고삭제 -대상은 OFF  된거만 삭제 가능하고,,
		집행이 되어 있은면 취고하고,,
		입찰이 되어 있으면 취소하고,
		광고물을 삭제,
		상태를 삭제로 바꿈
		
노출수,클릭수, 광고비용  - 오늘자 최근거를 보여준다.

광고순위 1-3 숫자 , 등외-후보
입찰상태 - 입찰,입찰전,

입찰- 무조건 입찰버튼은 있다.
 	
입찰은 광고물 기준으로 입찰한다.



광고집행정보 

전일 광고비 
이달의 광고비 - 전날기준
포인트 잔액 - 현재 잔액

```
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
   	  
   	  @서비스.$광고휴형이 서치일경우 <script src='http://도메인명/[광고단위코드]/[키워드]'><script>
   	  @서비스.$광고휴형이 매칭일경우 <script src='http://도메인명/[광고단위코드]'><script>
   
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


## ERD

erd 이미지는  [ERD](./documents/brandbox.pdf) 에서 참조

erd 원본은  [ERD](./documents/brandbox.mwb) 에서 참조  
  
## API 

[API](https://htmlpreview.github.io/?https://github.com/HongSungChul/ad/blob/master/doc/index.html)

## Todo

	* mysql를 몽고디비로 포팅 



