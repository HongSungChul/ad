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
import com.mbagix.ad.service.MemberService;
import com.mbagix.ad.service.PointService;
import com.mbagix.ad.service.ReportService;

/**
 * 광고주 정산
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
public class  ReportDailyAc {
	private static final String[] CONTEXT = {"spring/application-property.xml","spring/application-database.xml", "spring/application-config.xml"};
	
	@Resource
	private AdmService admService;
	
	
	@Resource
	private MemberService memberService;
	
	
	@Resource
	private PointService pointService;
	
	
	@Resource
	private ReportService reportService;
	
	@Value("${foo.no}")
	private String fooNo;
	
   public static void main(String[] args) {
   	//File f = new File("aa");
   	//System.out.println(">>>>>>>>>>"+f.getAbsolutePath());
   	
   	((ReportDailyAc) new ClassPathXmlApplicationContext(CONTEXT).getBean("reportDailyAc")).job(args);
   	
   	
   }
   
   
   //user={"profile_url":"http://graph.facebook.com/100005108318339/picture?type\u003dsmall","name":"홍성철","media":"A"}
   //member_code=30
   public void job(String siteCodes[]) {
   	
   	
   	System.out.println ("Start job ..");
   	try{
   		Calendar cal = Calendar.getInstance();
   		//cal.add(Calendar.DATE, -1);
   		String regDate = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
   		Map where = new HashMap();
		where.put("kind", "A");
		where.put("status", "A");
		//where.put("memberSq", 9);
		List<Map> ulist = memberService.getAllMember(where); // 광고주만 검색
		for(Map user:ulist){
			try{
				reportService.reportDailyAc(user,regDate);
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
   public void moveToAdPoint(){ 
   	Map where = new HashMap();
		where.put("kind", "A");
		where.put("status", "A");
		where.put("memberSq", 9);
		List<Map> ulist = memberService.getAllMember(where);
		for(Map user:ulist){
				pointService.moveToAdPoint(user);
		}
   }
   public void flushAdvertising(Integer kw1Sq,Integer kw2Sq) throws Exception{
   	admService.flushAdvertiser(kw1Sq, kw2Sq);
   }
}
