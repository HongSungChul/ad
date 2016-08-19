package com.mbagix.ad.model;

import java.util.Date;

/**
 * 광고정보 모델 
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
public class AdInfo {
	/**
	 * 광고정보 번호
	 */
	private Integer adInfoSq;
	/**
	 * 회원번호 
	 */
	private Integer memberSq;
	/**
	 * 이미지 유알아이 
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
	 * 등록
	 */
	private Date regDate;
	/**
	 * 수정
	 */
	private Date modDate;
	public AdInfo(){
		
	}
	public Integer getAdInfoSq() {
		return adInfoSq;
	}
	public void setAdInfoSq(Integer adInfoSq) {
		this.adInfoSq = adInfoSq;
	}
	public Integer getMemberSq() {
		return memberSq;
	}
	public void setMemberSq(Integer memberSq) {
		this.memberSq = memberSq;
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
