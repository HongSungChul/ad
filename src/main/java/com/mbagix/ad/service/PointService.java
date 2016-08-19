package com.mbagix.ad.service;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.AdmMapper;
import com.mbagix.ad.mapper.PointMapper;


/**
 * 포인트 관련  서비스
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
@Service(value = "pointService")
public class PointService {
	@Resource(name = "pointMapper")
    private PointMapper pointMapper;	
	
	@Resource(name = "admMapper")
    private AdmMapper admMapper;
	
	public Integer getTotalPointLog(Map<String,Object> map){
		return pointMapper.getTotalPointLog(map);
	}
	public List<Map> getAllPointLog(Map<String,Object> map) {
		
		return pointMapper.getAllPointLog(map);
	}
	public BigDecimal getSumPointLog(Map<String,Object> map) {
		
		return pointMapper.getSumPointLog(map);
	}
	
	public Map getPointLog(Map<String,Object> map) {
		
		return pointMapper.getPointLog(map);
	}
	
	
	public void addPointLog(Map pointLog) {
		pointMapper.addPointLog(pointLog);
	}
	public void addPoint(Map point){
		
	}
	
	public void pointSave(Map<String,Object> point) {
		//Map ap = new HashMap();
		//ap.put("memberSq",point.get("memberSq"));
		//pointMapper.
		
		pointMapper.addPoint(point);
		pointMapper.addPointLog(point);
	}
	public void pointUse(Map point) {
		pointMapper.usePoint(point);
		pointMapper.addPointLog(point);
	}
	public void moveToAdPoint(Map point){
		pointMapper.moveToAdPoint(point);
	}
	public void calcAdvertiser(Map user,String regDate) throws Exception{
		
		Calendar cal = Calendar.getInstance();
		
		Map pointLog  = new HashMap();
		pointLog.put("memberSq",user.get("memberSq"));
		pointLog.put("gubun", "B");//출금
		pointLog.put("kind","B");//광고집행
		pointLog.put("description", "광고집행");
		
		pointLog.put("regDate",regDate);
		// user // 사용자정보
		
		
		Map userPointLog = pointMapper.getPointLog(pointLog); // point로그정보
		
		BigDecimal myPoint = (BigDecimal)user.get("point");
		Integer curCalcPoint= 0; // 최근누적포인트  
		if(userPointLog!=null){
			curCalcPoint = (Integer)userPointLog.get("point");
		}
		
		Map param = new HashMap();
		param.put("memberSq", user.get("memberSq"));
		param.put("regDate", regDate);
		
		BigDecimal calcPoint = admMapper.getPointByDate(param); // 현재누적포인트  
		
		if(calcPoint==null) calcPoint = new BigDecimal(0);
		BigDecimal subPoint=calcPoint.subtract(new BigDecimal(curCalcPoint)); // 증감포인트
		
		if(myPoint.subtract(subPoint).signum()==-1){
			subPoint = myPoint;
			//calPoint = calPoint.sub
			//myPoint= new BigDecimal(0);
		}else{
			//myPoint=myPoint.subtract(subPoint);
		}
		
		param.put("point", subPoint);
		pointMapper.usePoint(param); //포인트삭감
		
		BigDecimal usePoint = subPoint.add(new BigDecimal(curCalcPoint));
		
		if(userPointLog==null){// 포인트로그 추가
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
			pointLog.put("regDate",format.parse(regDate));
			pointLog.put("point", usePoint);
			pointMapper.addPointLog(pointLog);
		}else{
			Map param1 = new HashMap();
			param1.put("point",usePoint );
			param1.put("description", "광고집행");
			param1.put("pointLogSq", userPointLog.get("pointLogSq"));
			pointMapper.updatePointLog(param1);
		}
		pointMapper.moveToAdPoint(user);
		//pointService.addPointLog(pointLog);
		//pointService.moveToAdPoint(user);
	}
	
}
