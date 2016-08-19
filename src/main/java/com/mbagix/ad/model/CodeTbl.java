package com.mbagix.ad.model;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
/**
 * 코드테이블 모델 
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

public class CodeTbl {
	/**
	 * 그룹코드 
	 */
	private String gCode;
	/**
	 * 키 
	 */
	private String key;
	/**
	 * 정렬순서 
	 */
	private Integer sortOrder;
	/**
	 * 설명 
	 */
	private String description;
	public CodeTbl(){
		 
	}
	public String getgCode() {
		return gCode;
	}



	public void setgCode(String gCode) {
		this.gCode = gCode;
	}



	public String getKey() {
		return key;
	}



	public void setKey(String key) {
		this.key = key;
	}



	public Integer getSortOrder() {
		return sortOrder;
	}



	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
}
