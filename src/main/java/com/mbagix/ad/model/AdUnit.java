package com.mbagix.ad.model;

import java.util.Date;
/**
 * 광고단위 모델 
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

public class AdUnit {

	/**
	 * 광고단위번호 
	 */
	private Integer adUnitSq;
	/**
	 * 서비스번호 
	 */
	private Integer serviceSq;
	/**
	 * 이름 
	 */
	private String name;
	/**
	 * 회원번호 
	 */
	private Integer memberSq;
	/*
	 * 등록일 
	 */
	private Date regDate;
	/*
	 * 번경일 
	 */
	private Date modDate;
	public AdUnit(){
		
	}
	public Integer getAdUnitSq() {
		return adUnitSq;
	}
	public void setAdUnitSq(Integer adUnitSq) {
		this.adUnitSq = adUnitSq;
	}
	public Integer getServiceSq() {
		return serviceSq;
	}
	public void setServiceSq(Integer serviceSq) {
		this.serviceSq = serviceSq;
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
