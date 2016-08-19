package com.mbagix.ad.model;
/**
 * 광고 모델 
 *
 * <pre>
 * <b>History:</b>
 *    작성자, 1.1, 2016.3.9 초기작성
 * </pre>
 *
 * @author 홍성철
 * @version 1.2
 */

public class Advertising {
	/**
	 * 광고물 번호 
	 */
	private Integer admSq;
	/*
	 * 키워드1 번호 
	 */
	private Integer kw1Sq;
	/**
	 * 키워드2 번호 
	 */
	private Integer kw2Sq;
	/**
	 * 포인트 
	 */
	private Integer point;
	/**
	 * 회원번호 
	 */
	private Integer memberSq;
	/**
	 * 정렬순서 
	 */
	private Integer sortOrder;
	/**
	 * 이미지 유알아이 
	 */
	private String imgUri;
	/**
	 * 제목 
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
	 * 1차 키워드명
	 */
	private String kw1Name;
	/**
	 * 등록일 
	 */
	private String regDate;
	/**
	 * 변경일 
	 */
	private String modDate;
	/**
	 * 2차키워드명 
	 */
	private String kw2Name;
	
	public Advertising(){
		
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

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public Integer getMemberSq() {
		return memberSq;
	}

	public void setMemberSq(Integer memberSq) {
		this.memberSq = memberSq;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
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

	public String getKw1Name() {
		return kw1Name;
	}

	public void setKw1Name(String kw1Name) {
		this.kw1Name = kw1Name;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getKw2Name() {
		return kw2Name;
	}

	public void setKw2Name(String kw2Name) {
		this.kw2Name = kw2Name;
	}
	
}
