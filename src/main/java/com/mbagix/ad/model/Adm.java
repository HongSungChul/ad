package com.mbagix.ad.model;

import java.util.Date;
/**
 * 광고물 모델 
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

public class Adm {

	/**
	 * 광고물번
	 */
	private Integer admSq;
	/**
	 * 대표명 
	 */
	private String alias;
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
	 * 회원번호 
	 */
	private Integer memberSq;
	/**
	 * 등록일 
	 */
	private Date regDate;
	/**
	 * 수정일 
	 */
	private Date modDate;
	public Adm(){
		
	}
	public Integer getAdmSq() {
		return admSq;
	}
	public void setAdmSq(Integer admSq) {
		this.admSq = admSq;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
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
