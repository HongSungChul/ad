package com.mbagix.ad.model;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 사용자 모델 
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

public class Member {
	/**
	 * 회원번호 
	 */
	  private Integer memberSq;
	  
	  /**
	   * 회원아이디 
	   */
	  private String userid;
	  /**
	   * 패스워드 
	   */
	  private String passwd ;
	  /**
	   * 회원유형 
	   */
	  private String kind;
	  /**
	   * 전화번호 
	   */
	  private String phone;
	  /**
	   * 이메일 
	   */
	  private String email;
	  /**
	   * 회사명 
	   */
	  private String companyName;
	  /**
	   * 포인트 
	   */
	  private BigDecimal point;
	  /**
	   * 등록일 
	   */
	  private Date regDate;
	  /**
	   * 수정일 
	   */
	  private Date modDate;
	  /**
	   * 수익율 
	   */
	  private Integer profit;
	  /**
	   * 이름 
	   */
	  private String name;
	  /**
	   * 상태 
	   */
	  private String status;
	  /**
	   * 휴대폰번호 
	   */
	  private String hp;
	  /**
	   * 광고포인트 
	   */
	  private BigDecimal adPoint;
	  
	  public Member(){
		  
	  }

	public Integer getMemberSq() {
		return memberSq;
	}

	public void setMemberSq(Integer memberSq) {
		this.memberSq = memberSq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public BigDecimal getPoint() {
		return point;
	}

	public void setPoint(BigDecimal point) {
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

	public Integer getProfit() {
		return profit;
	}

	public void setProfit(Integer profit) {
		this.profit = profit;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public BigDecimal getAdPoint() {
		return adPoint;
	}

	public void setAdPoint(BigDecimal adPoint) {
		this.adPoint = adPoint;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
			  

}
