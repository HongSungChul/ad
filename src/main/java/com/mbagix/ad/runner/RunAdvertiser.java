package com.mbagix.ad.runner;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.MemberService;


/**
 * 광고주 테스트 잡
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
public class  RunAdvertiser {
	private static final String[] CONTEXT = {"spring/application-property.xml","spring/application-database.xml", "spring/application-config.xml"};
	
	@Resource
	private AdmService admService;
	
	
	@Resource
	private MemberService memberService;
	
	@Value("${foo.no}")
	private String fooNo;
	
    public static void main(String[] args) {
    	//File f = new File("aa");
    	//System.out.println(">>>>>>>>>>"+f.getAbsolutePath());
    	
    	((RunAdvertiser) new ClassPathXmlApplicationContext(CONTEXT).getBean("runAdvertiser")).job(args);
    	
    	
    }
    
    
    //user={"profile_url":"http://graph.facebook.com/100005108318339/picture?type\u003dsmall","name":"홍성철","media":"A"}
    //member_code=30
    public void job(String siteCodes[]) {
    	
    	
    	System.out.println ("Start job ..");
    	try{
    		Map where = new HashMap();
    		where.put("kind", "A");
    		where.put("status", "A");
    		List<Map> ulist = memberService.getAllMember(where);
    		for(Map user:ulist){
    			
    		}
    		// 1. 
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    	System.out.println ("Complete ..");
    }
    public void startCalculate(Map adUser) throws Exception{
    	//admService.flushAdvertiser((Integer)map.get("kw1Sq"), (Integer)map.get("kw2Sq"));
    }
}
