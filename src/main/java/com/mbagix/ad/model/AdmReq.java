package com.mbagix.ad.model;

import java.util.Date;
/**
 * 광고물요청 모델 
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

public class AdmReq {

	/**
	 * 광고물번호 
	 */
	private Integer admReqSq;
	/**
	 * 이미지유알아이 
	 */
	private String imgUri;
	/**
	 * 타이틀 
	 */
	private String title;
	/**
	 * 설명 
	 */
	private String description;
	/**
	 * 링크 
	 */
	private String link;
	/**
	 * 종류 
	 */
	private String kind;
	/**
	 * 결과
	 */
	private String result;
	/**
	 * 반려사유 
	 */
	private String backWhy;
	/*
	 * 회원번호
	 */
	private Integer memberSq;
	/*
	 * 등록일 
	 */
	private Date regDate;
	/**
	 * 수정일 
	 */
	private Date modDate;
	private Integer admSq;
	
	public AdmReq(){
		
	}

	public Integer getAdmReqSq() {
		return admReqSq;
	}

	public void setAdmReqSq(Integer admReqSq) {
		this.admReqSq = admReqSq;
	}

	public String getImgUri() {
		return imgUri;
	}

	public void setImgUri(String imgUri) {
		this.imgUri = imgUri;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getBackWhy() {
		return backWhy;
	}

	public void setBackWhy(String backWhy) {
		this.backWhy = backWhy;
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

	public Integer getAdmSq() {
		return admSq;
	}

	public void setAdmSq(Integer admSq) {
		this.admSq = admSq;
	}
	
	
}
