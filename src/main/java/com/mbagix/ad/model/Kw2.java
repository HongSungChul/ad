package com.mbagix.ad.model;

import java.util.Date;
/**
 * 키워드2 모델 
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

public class Kw2 {

	/**
	 * 2차키워드번호 
	 */
	private Integer kw2Sq;
	/**
	 * 1차키워드번호 
	 */
	private Integer kw1Sq;
	/**
	 * 이름 
	 */
	private String name;
	/**
	 * 정렬순서 
	 */
	private Integer sortOrder;
	/**
	 * 등록
	 */
	private Date regDate;
	/**
	 * 변경일 
	 */
	private Date modDate;
	/**
	 * 상태 
	 */
	private String status;
	
	public Kw2(){
		
	}

	public Integer getKw2Sq() {
		return kw2Sq;
	}

	public void setKw2Sq(Integer kw2Sq) {
		this.kw2Sq = kw2Sq;
	}

	public Integer getKw1Sq() {
		return kw1Sq;
	}

	public void setKw1Sq(Integer kw1Sq) {
		this.kw1Sq = kw1Sq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
