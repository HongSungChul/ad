package com.mbagix.ad.service;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.AdmMapper;
import com.mbagix.ad.mapper.PointMapper;
import com.mbagix.ad.mapper.ReportMapper;
import com.mbagix.ad.util.HongUtil;


/**
 * 리포트 관련 서비스
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
@Service(value = "reportService")
public class ReportService {
	
	@Resource(name = "reportMapper")
    private ReportMapper reportMapper;
	
	@Resource(name = "pointMapper")
    private PointMapper pointMapper;	
	
	@Resource(name = "admMapper")
    private AdmMapper admMapper;
	
	public List<Map> getAllDailyAc(Map<String,Object> condition){
		return reportMapper.getAllDailyAc(condition);
	}
	public List<Map> getDailyAcGroupByDate(Map<String,Object> condition){
		return reportMapper.getDailyAcGroupByDate(condition);
	}
	public List<Map> getDailyAcGroupByAdm(Map<String,Object> condition){
		return reportMapper.getDailyAcGroupByAdm(condition);
	}
    public Integer getTotalDailyAc(Map<String,Object> map){
    	return reportMapper.getTotalDailyAc(map);
    }
    public List<Map> getAllDailyAcByCollDate(Map<String,Object> condition){
    	return reportMapper.getAllDailyAcByCollDate(condition);
    }
    public Integer getTotalDailyAcByCollDate(Map<String,Object> map){
    	return reportMapper.getTotalDailyAcByCollDate(map);
    }
    public void addDailyAc(Map pointLog){
    	 reportMapper.addDailyAc(pointLog);
    }
    public Map getDailyAc(Map<String,Object> condition){
    	return reportMapper.getDailyAc(condition);
    }
    public void updateDailyAc(Map<String,Object> condition){
    	reportMapper.updateDailyAc(condition);
    }
    
    public List<Map> getAllDailyMc(Map<String,Object> condition){
    	return reportMapper.getAllDailyMc(condition);
    }
    public Integer getTotalDailyMc(Map<String,Object> map){
    	return reportMapper.getTotalDailyMc(map);
    }
    public List<Map> getAllDailyMcByCollDate(Map<String,Object> condition){
    	return reportMapper.getAllDailyMcByCollDate(condition);
    }
    public Integer getTotalDailyMcByCollDate(Map<String,Object> map){
    	return reportMapper.getTotalDailyMcByCollDate(map);
    }
    public void addDailyMc(Map pointLog){
    	 reportMapper.addDailyMc(pointLog);
    }
    public Map getDailyMc(Map<String,Object> condition){
    	return reportMapper.getDailyMc(condition);
    }
    public void updateDailyMc(Map<String,Object> condition){
    	 reportMapper.updateDailyMc(condition);
    }
    
    
    public List<Map> getAllDailyKw(Map<String,Object> condition){
    	return reportMapper.getAllDailyKw(condition);
    }
    public Integer getTotalDailyKw(Map<String,Object> map){
    	return reportMapper.getTotalDailyKw(map);
    }
    //public List<Map> getAllDailyMcByCollDate(Map<String,Object> condition);
    //public Integer getTotalDailyMcByCollDate(Map<String,Object> map);
    public void addDailyKw(Map pointLog){
    	 reportMapper.addDailyKw(pointLog);
    }
    public Map getDailyKw(Map<String,Object> condition){
    	return reportMapper.getDailyKw(condition);
    }
    public void updateDailyKw(Map<String,Object> condition){
    	 reportMapper.updateDailyKw(condition);
    }
    
    
    public List<Map> getDailyMcGroupByDate(Map<String,Object> condition){
    	return reportMapper.getDailyMcGroupByDate(condition);
    }
    public List<Map> getAllMonthAc(Map<String,Object> condition){
    	return reportMapper.getAllMonthAc(condition);
    }
    public List<Map> getMonthAcGroupByDate(Map<String,Object> condition){
    	return reportMapper.getMonthAcGroupByDate(condition);
    }
    public Integer getTotalMonthAc(Map<String,Object> map){
    	return reportMapper.getTotalMonthAc(map);
    }
    public void addMonthAc(Map pointLog){
    	reportMapper.addMonthAc(pointLog);
    }
    public Map getMonthAc(Map<String,Object> condition){
    	return reportMapper.getMonthAc(condition);
    }
    public void updateMonthAc(Map<String,Object> condition){
    	 reportMapper.updateMonthAc(condition);
    }
    
    public List<Map> getAllMonthMc(Map<String,Object> condition){
    	return reportMapper.getAllMonthMc(condition);
    }
    public Integer getTotalMonthMc(Map<String,Object> map){
    	return reportMapper.getTotalMonthMc(map);
    }
    public void addMonthMc(Map pointLog){
    	 reportMapper.addMonthMc(pointLog);
    }
    public Map getMonthMc(Map<String,Object> condition){
    	return reportMapper.getMonthMc(condition);
    }
    public void updateMonthMc(Map<String,Object> condition){
    	reportMapper.updateMonthMc(condition);
    }
    
    private void reportDailyAcAdm(Map user,String collDate,Map adm) throws Exception{
    	
    	//Calendar cal = Calendar.getInstance();
		/*
		 * `memberSq`,
		`collDate`,
		`clickCnt`,
		`validCnt`,
		`invalidCnt`,
		`reqCnt`,
		`viewCnt`,
		`avgPrice`,
		`sales`,
		`admSq`,
		`regDate`,
		`prevPoint`, -myPoint
		`point` -0
		 */
		Map dailyAc  = new HashMap();
		dailyAc.put("memberSq",user.get("memberSq"));
		dailyAc.put("admSq", adm.get("admSq"));
		dailyAc.put("collDate",collDate);//광고집행
		dailyAc.put("invalidCnt",0); // 무시
		
		reportMapper.deleteDailyAc(dailyAc);
		
		Map dav = reportMapper.getDailyAcByView(dailyAc);
		Map dac = reportMapper.getDailyAcByClick(dailyAc);
		if(dav==null){
			if(dac==null){
				dailyAc.put("clickCnt",0);
				dailyAc.put("validCnt",0);
				dailyAc.put("reqCnt",0);
				dailyAc.put("avgPrice",0);
				dailyAc.put("sales",0);
				dailyAc.put("viewCnt",0);
			}else{
				dailyAc.put("viewCnt",0);
				HongUtil.merge(dailyAc, dac);
			}
		}else{
			if(dac==null){
				dailyAc.put("clickCnt",0);
				dailyAc.put("validCnt",0);
				dailyAc.put("reqCnt",0);
				dailyAc.put("avgPrice",0);
				dailyAc.put("sales",0);
				
				HongUtil.merge(dailyAc, dav);
			}else{
				HongUtil.merge(dailyAc, dav);
				HongUtil.merge(dailyAc, dac);
			}
		}
		/*if(dac==null){
			
			dailyAc.put("clickCnt",0);
			dailyAc.put("validCnt",0);
			dailyAc.put("reqCnt",0);
			dailyAc.put("avgPrice",0);
			dailyAc.put("sales",0);
			dailyAc.put("invalidCnt",0);
			dailyAc.put("viewCnt",0);
		}else{
			HongUtil.merge(dailyAc, dac);
		}*/
		
		dailyAc.put("point",user.get("point"));
		//System.err.println(dailyAc);
		reportMapper.addDailyAc(dailyAc);
		//
		
		
		
    }
	public void reportDailyAc(Map user,String regDate) throws Exception{
		
		
		//Map dailyAc  = new HashMap();
		//dailyAc.put("memberSq",user.get("memberSq"));
		
		List<Map> admList=admMapper.queryAdmByMember((Integer)user.get("memberSq"));
		for(Map adm:admList){
			try{
				reportDailyAcAdm(user,regDate,adm);
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		
	}
	public void reportDailyMc(Map user,String regDate) throws Exception{
		
		
		//Map dailyAc  = new HashMap();
		//dailyAc.put("memberSq",user.get("memberSq"));
	
		List<Map> adUnitList=admMapper.queryAdUnitByMember((Integer)user.get("memberSq"));
		for(Map adUnit:adUnitList){
			try{
				reportDailyMcAdUnit(user,regDate,adUnit);
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
		//pointService.addPointLog(pointLog);
		//pointService.moveToAdPoint(user);
	}
	private void reportDailyMcAdUnit(Map user,String collDate,Map adUnit) throws Exception{
    	
    	
		Map dailyMc  = new HashMap();
		dailyMc.put("memberSq",user.get("memberSq"));
		dailyMc.put("adUnitSq", adUnit.get("adUnitSq"));
		dailyMc.put("serviceSq", adUnit.get("serviceSq"));
		dailyMc.put("collDate",collDate);//광고집행
		dailyMc.put("invalidCnt",0); // 무시
		
		reportMapper.deleteDailyMc(dailyMc);
		
		Map dav = reportMapper.getDailyMcByView(dailyMc);
		Map dac = reportMapper.getDailyMcByClick(dailyMc);
		if(dav==null){
			if(dac==null){
				dailyMc.put("clickCnt",0);
				dailyMc.put("validCnt",0);
				dailyMc.put("reqCnt",0);
				dailyMc.put("avgPrice",0);
				dailyMc.put("sales",0);
				dailyMc.put("viewCnt",0);
			}else{
				dailyMc.put("viewCnt",0);
				HongUtil.merge(dailyMc, dac);
			}
		}else{
			if(dac==null){
				dailyMc.put("clickCnt",0);
				dailyMc.put("validCnt",0);
				dailyMc.put("reqCnt",0);
				dailyMc.put("avgPrice",0);
				dailyMc.put("sales",0);
				
				HongUtil.merge(dailyMc, dav);
			}else{
				HongUtil.merge(dailyMc, dav);
				HongUtil.merge(dailyMc, dac);
			}
		}
		
		
		reportMapper.addDailyMc(dailyMc);
		//
		
		
		
    }
	
	public void reportDailyKw(Map kw1,String collDate) throws Exception{
		
		
		//Map dailyAc  = new HashMap();
		//dailyAc.put("memberSq",user.get("memberSq"));
	
		Map dailyKw  = new HashMap();
		//dailyKw.put("memberSq",user.get("memberSq"));
		dailyKw.put("kw1Sq", kw1.get("kw1Sq"));
		dailyKw.put("kw1Name", kw1.get("name"));
		dailyKw.put("collDate",collDate);//광고집행
		dailyKw.put("invalidCnt",0); // 무시
		
		dailyKw.put("advertiserCnt", reportMapper.getAdvertiserCountByKw(dailyKw));
		reportMapper.deleteDailyKw(dailyKw);
		
		Map dav = reportMapper.getDailyKwByView(dailyKw);
		Map dac = reportMapper.getDailyKwByClick(dailyKw);
		if(dav==null){
			if(dac==null){
				dailyKw.put("clickCnt",0);
				dailyKw.put("validCnt",0);
				dailyKw.put("reqCnt",0);
				dailyKw.put("avgPrice",0);
				dailyKw.put("sales",0);
				dailyKw.put("viewCnt",0);
			}else{
				dailyKw.put("viewCnt",0);
				HongUtil.merge(dailyKw, dac);
			}
		}else{
			if(dac==null){
				dailyKw.put("clickCnt",0);
				dailyKw.put("validCnt",0);
				dailyKw.put("reqCnt",0);
				dailyKw.put("avgPrice",0);
				dailyKw.put("sales",0);
				
				HongUtil.merge(dailyKw, dav);
			}else{
				HongUtil.merge(dailyKw, dav);
				HongUtil.merge(dailyKw, dac);
			}
		}
		
		
		reportMapper.addDailyKw(dailyKw);
		
	}
	
}
