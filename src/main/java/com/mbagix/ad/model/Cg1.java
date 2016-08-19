package com.mbagix.ad.model;

import java.util.Date;
/**
 * 카테고리1 모델 
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

public class Cg1 {
	/**
	 * 1차카테고리번호 
	 */
	private Integer cg1Sq;
	/**
	 * 이름 
	 */
	private String name;
	/**
	 * 정렬순서 
	 */
	private Integer sortOrder;
	/**
	 * 등록일 
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
	public Cg1(){
		
	}
	public Integer getCg1Sq() {
		return cg1Sq;
	}
	public void setCg1Sq(Integer cg1Sq) {
		this.cg1Sq = cg1Sq;
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
