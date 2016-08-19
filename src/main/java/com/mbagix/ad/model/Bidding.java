package com.mbagix.ad.model;

import java.util.Date;
/**
 * 입찰  모델 
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

public class Bidding {
	/**
	 * 입찰번호  
	 */
	private Integer biddingSq;
	/**
	 * 광고물번호 
	 */
	private Integer admSq;
	/**
	 * 1차키워드번호 
	 */
	private Integer kw1Sq;
	/**
	 * 2차키워드번호 
	 */
	private Integer kw2Sq;
	/**
	 * 회원번호 
	 */
	private Integer memberSq;
	/**
	 * 포인트 
	 */
	private Integer point;
	/**
	 * 등록일 
	 */
	private Date regDate;
	/**
	 * 변경일 
	 */
	private Date modDate;
	
	public Bidding(){
		
	}

	public Integer getBiddingSq() {
		return biddingSq;
	}

	public void setBiddingSq(Integer biddingSq) {
		this.biddingSq = biddingSq;
	}

	public Integer getAdmSq() {
		return admSq;
	}

	public void setAdmSq(Integer admSq) {
		this.admSq = admSq;
	}

	public Integer getKw1Sq() {
		return kw1Sq;
	}

	public void setKw1Sq(Integer kw1Sq) {
		this.kw1Sq = kw1Sq;
	}

	public Integer getKw2Sq() {
		return kw2Sq;
	}

	public void setKw2Sq(Integer kw2Sq) {
		this.kw2Sq = kw2Sq;
	}

	public Integer getMemberSq() {
		return memberSq;
	}

	public void setMemberSq(Integer memberSq) {
		this.memberSq = memberSq;
	}

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
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
