package com.mbagix.ad.runner;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.KeywordService;
import com.mbagix.ad.service.MemberService;
import com.mbagix.ad.service.PointService;
import com.mbagix.ad.service.ReportService;

/**
 * 광고주 정산 키워드 배치잡
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
public class  ReportDailyKw {
	private static final String[] CONTEXT = {"spring/application-property.xml","spring/application-database.xml", "spring/application-config.xml"};
	
	@Resource
	private AdmService admService;
	
	
	@Resource
	private MemberService memberService;
	
	
	@Resource
	private PointService pointService;
	
	
	@Resource
	private ReportService reportService;
	
	@Resource
	private KeywordService keywordService;
	
	
	@Value("${foo.no}")
	private String fooNo;
	
   public static void main(String[] args) {
   	//File f = new File("aa");
   	//System.out.println(">>>>>>>>>>"+f.getAbsolutePath());
   	
   	((ReportDailyKw) new ClassPathXmlApplicationContext(CONTEXT).getBean("reportDailyKw")).job(args);
   	
   	
   }
   
   
   //user={"profile_url":"http://graph.facebook.com/100005108318339/picture?type\u003dsmall","name":"홍성철","media":"A"}
   //member_code=30
   public void job(String siteCodes[]) {
   	
   	
   	System.out.println ("Start job ..");
   	try{
   		Calendar cal = Calendar.getInstance();
   		cal.add(Calendar.DATE, -1);
   		String regDate = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
   		Map where = new HashMap();
		where.put("status", "A"); //  활성인거 다 가져온다.
		//where.put("memberSq", 9);
		List<Map> kwlist = keywordService.getAllKw1(where); // 1차키워드
		for(Map kw1:kwlist){
			try{
				reportService.reportDailyKw(kw1,"2015-09-02");
			}catch(Exception exx){
				exx.printStackTrace();
			}
		}
   		// 1. 
   	}catch(Exception ex){
   		ex.printStackTrace();
   	}
   	System.out.println ("Complete ..");
   }
  
}
