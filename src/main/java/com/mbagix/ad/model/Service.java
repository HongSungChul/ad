package com.mbagix.ad.model;

import java.math.BigDecimal;
import java.util.Date;
/**
 * 서비스 모델 
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

public class Service {

	/**
	 * 서비스번호 
	 */
	private Integer serviceSq;
	/**
	 * 포인트 
	 */
	private BigDecimal point;
	/**
	 * 이름 
	 */
	private String name;
	/**
	 * 회원번호 
	 */
	private Integer memberSq;
	/**
	 * 도메인 
	 */
	private String domain;
	/**
	 * 광고타입 
	 */
	private String adType;
	/**
	 * 등록일 
	 */
	private Date regDate;
	
	/**
	 * 변경일 
	 */
	private Date modDate;
	public Service(){
		
	}
	public Integer getServiceSq() {
		return serviceSq;
	}
	public void setServiceSq(Integer serviceSq) {
		this.serviceSq = serviceSq;
	}
	public BigDecimal getPoint() {
		return point;
	}
	public void setPoint(BigDecimal point) {
		this.point = point;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getMemberSq() {
		return memberSq;
	}
	public void setMemberSq(Integer memberSq) {
		this.memberSq = memberSq;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getAdType() {
		return adType;
	}
	public void setAdType(String adType) {
		this.adType = adType;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getModDate() {
		return modDate;
	}
	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}
	
	
}
