package com.mbagix.ad.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonInclude;
/**
 * json 결과  
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


public class JsonResult<T> {
	/**
	 * 다음페이지 토큰 
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private String nextPageToken;
	
	/**
	 * 이전페이지 토큰 
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private String prevPageToken;
	
	/**
	 * 페이지 정보 
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private Map pageInfo;

	/**
	 * 총갯수 
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private Integer total;
	
	/**
	 * 메세지 
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private String msg;

	/**
	 * 성공여부 
	 */
	private boolean isSuccess = true;
	
	/**
	 * 리턴결과 데이타
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	private T data;
	
	
	
	public Integer getTotal(){
		return total;
	}
	public void setTotal(Integer t){
		total=t;
	}
	public String getMsg(){
		return msg;
	}
	public void setMsg(String m){
		this.msg=m;
	}
	public String getNextPageToken() {
		return nextPageToken;
	}
	public void setNextPageToken(String nextPageToken) {
		this.nextPageToken = nextPageToken;
	}
	public String getPrevPageToken() {
		return prevPageToken;
	}
	public void setPrevPageToken(String prevPageToken) {
		this.prevPageToken = prevPageToken;
	}
	public Map getPageInfo() {
		return pageInfo;
	}
	public void setPageInfo(Map pageInfo) {
		this.pageInfo = pageInfo;
	}
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public T getData() {
		return data;
	}
	public JsonResult(){
		
	}
	public void setData(T items){
		this.data= items;
	}
	public void setTotalResults(Integer totalResults){
		if(pageInfo==null){
			pageInfo = new HashMap();
		}
		pageInfo.put("totalResults",totalResults);
	}
	public void setResultsPerPage(Integer resultsPerPage){
		if(pageInfo==null){
			pageInfo = new HashMap();
		}
		pageInfo.put("resultsPerPage",resultsPerPage);
	}
}
