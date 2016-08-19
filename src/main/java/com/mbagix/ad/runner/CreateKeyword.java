package com.mbagix.ad.runner;
/*
 * 광고주 정산
 */

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.snu.ids.ha.index.Keyword;
import org.snu.ids.ha.index.KeywordExtractor;
import org.snu.ids.ha.index.KeywordList;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.AnalService;
import com.mbagix.ad.service.MemberService;
import com.mbagix.ad.service.PointService;
import com.mbagix.ad.service.ReportService;

/**
 * 키워드 생성
 *
 * <pre>
 * <b>History:</b>
 *    작성자, 1.1, 2016.3.9 초기작성
 * </pre>
 *
 * @author 홍성철
 * @version 1.2
 * @see    None
 */
@Component
public class  CreateKeyword {
	private static final String[] CONTEXT = {"spring/application-property.xml","spring/application-database.xml", "spring/application-config.xml"};
	
	
	@Resource
	private MemberService memberService;
	
	
	@Resource
	private PointService pointService;
	
	@Resource
	private AnalService analService;
	
	
	@Resource
	private ReportService reportService;
	
	@Value("${foo.no}")
	private String fooNo;
	
   public static void main(String[] args) {
   	//File f = new File("aa");
   	//System.out.println(">>>>>>>>>>"+f.getAbsolutePath());
   	
   	((CreateKeyword) new ClassPathXmlApplicationContext(CONTEXT).getBean("createKeyword")).job(args);
   	
   	
   }
   
   
   //user={"profile_url":"http://graph.facebook.com/100005108318339/picture?type\u003dsmall","name":"홍성철","media":"A"}
   //member_code=30
   public void job(String siteCodes[]) {
   	
   	
   	System.out.println ("Start job ..");
   	try{
   		Calendar cal = Calendar.getInstance();
   		//cal.add(Calendar.DATE, -1);
   		String regDate = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
   		//analService.createKeyword("ABCD151015162409235", 10);
   		List<Map> list = analService.getAllAdUid(new HashMap());
   		for(Map data:list){
   			
   			System.err.println(data);
   			if(data!=null)
   				analService.createKeyword((String)data.get("adUid"), 10);
   		}
   		// 1. 
   	}catch(Exception ex){
   		ex.printStackTrace();
   	}
   	System.out.println ("Complete ..");
   }
   public void test1() throws Exception {

		//Socket socket = new Socket("",40);
		//InputStream input = socket.getInputStream();
		
		// string to extract keywords
		//String strToExtrtKwrd = null;
		String strToExtrtKwrd = "세종 말뭉치는 질과 양 모든 면에서 매우 우수한 말뭉치이기는 하지만, 컴퓨터 프로그래밍 능력이 없는 사람은 이를 활용하기가 어렵다. 또한, 컴퓨터 프로그래밍에 익숙하다고 하더라도, 말뭉치의 구조를 파악하고 말뭉치를 처리할 수 있는 형태로 가공하는 과정이 필요하기 때문에 말뭉치를 활용하는데 어려움이 있다. 따라서 ‘꼬꼬마’팀에서는 세종 말뭉치를 다양한 용도로 활용할 수 있도록 1) 말뭉치를 구조화 하여 데이터베이스에 저장하고, 2) 저장된 말뭉치로부터 다양한 통계 데이터를 생성하고, 3)저장된 말뭉치 및 생성된 통계 정보를 다양한 방법으로 조회할 수 있는 시스템을 구현하였다."+

"꼬꼬마 세종 말뭉치 활용 시스템의 기능은 크게 말뭉치 통계 정보 조회, 말뭉치 검색, 그리고 한국어 쓰기 학습의 세 가지로 구분된다. 말뭉치 통계 정보 조회 기능은 구축된 말뭉치에서 품사, 형태소, 문어 및 구어 등의 다양한 기준에 의한 출현 빈도를 추출하여 조회할 수 있게 하는 기능이며, 말뭉치 검색은 형태소를 기준으로 형태소가 쓰인 문장을 조회하고 이에 대한 품사 부착, 의미 분석, 구문 분석 결과를 확인하는 기능이다. 한국어 쓰기 학습 기능은 한국어를 공부하는 학생이나 교수자가 사용할 수 있는 기능으로, 단어가 포함된 용례나 양식에 따른 용례를 조회할 수 있다.";


		// init KeywordExtractor
		KeywordExtractor ke = new KeywordExtractor();

		// extract keywords
		KeywordList kl = ke.extractKeyword(strToExtrtKwrd, true);

		// print result
		for( int i = 0; i < kl.size(); i++ ) {
			Keyword kwrd = kl.get(i);
			System.out.println(kwrd.getString() + "\t" + kwrd.getCnt()+"\t"+kwrd.getTag());
			
		}
	}
}
