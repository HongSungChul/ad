/*
 * Created on 2004. 3. 30.
 *
 */
package com.mbagix.ad.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Locale;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;


/**
 * 스트링 연산
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

public class Convert {
	
	public static void main(String[] a) throws Exception {
		
		

		
	}
	public static String getTimeString(long seconds){
		//long diff = System.currentTimeMillis()-time;
		
		long diff =seconds*1000;
		long diffSeconds = diff / 1000 % 60;
		long diffMinutes = diff / (60 * 1000) % 60;
		long diffHours = diff / (60 * 60 * 1000) % 24;
		long diffDays = diff / (24 * 60 * 60 * 1000);
		
		long diffWeeks = diff / (24 * 60 * 60 * 1000 * 7);
		
		long diffMonths = diff / (24 * 60 * 60 * 1000 * 30);
		
		long diffYears = diff / (24 * 60 * 60 * 1000 * 365);

		//if(diffYears>0) return diffYears+"??????";
		if(diffMonths>0) return diffMonths+"?????? "+diffDays+"?????? "+diffHours+"???????????? "+diffMinutes+"?????? "+diffSeconds+"??????";
		//if(diffWeeks>0) return diffWeeks+"????????????";
		if(diffDays>0) return diffDays+"?????? "+diffHours+"???????????? "+diffMinutes+"?????? "+diffSeconds+"??????";
		if(diffHours>0) return diffHours+"???????????? "+diffMinutes+"?????? "+diffSeconds+"??????";
		if(diffMinutes>0) return diffMinutes+"?????? "+diffSeconds+"??????";
		return diffSeconds+"??????";
	}
	/*
	public  void test(){
		String url="http://popz.saycast.com";
		//String url="http://naver.com";
		//java.net.URL curl  = new java.net.URL(url);
		
		
		DefaultHttpClient seed = new DefaultHttpClient();
		SchemeRegistry registry = new SchemeRegistry();
		registry.register(new Scheme("http", 80,PlainSocketFactory
				.getSocketFactory()));
		
		SingleClientConnManager mgr= new MyClientConnManager(seed.getParams(), registry);// = new MyClientConnManager(seed.getParams(),registry);
		DefaultHttpClient http = new DefaultHttpClient(mgr, seed.getParams());
		HttpGet method = new HttpGet(url);
		method.addHeader("Icy-MetaData", "1");
		//method.setHeader("host", "212.67.9.22");
		
		method.setHeader("User-Agent", "My Flex Radio for Android");
		Header[] headers = method.getAllHeaders();
		//Log.v(headers.length);
		for (Header header : headers) {
			System.out.println("header.."+header.getName()+":"+ header.getValue());
			
		}
		
		HttpResponse response = null;
		//Log.v(LOG_TAG,url);
		try {
			//Log.d(LOG_TAG, "starting download");
			System.out.println("1");
			response = http.execute(method);
			System.out.println("2");
			headers = response.getAllHeaders();
			String metaint = null;
			for (Header header : headers) {
				System.out.println(header.getName()+":"+ Convert.toString(header.getValue()));
				if (header.getName().contains("icy-metaint")) {
					metaint = header.getValue();
					//metaDataOffset = Integer.parseInt(header.getValue());
				}
			}
			BufferedInputStream bInputStream = new BufferedInputStream(response
					.getEntity().getContent());
			int c;
			if(true) return;
			while((c=bInputStream.read())!=-1){
				System.out.print((char)c);
			}
			
			//Log.d(LOG_TAG, "downloaded");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	private class IcyLineParser extends BasicLineParser {
		private static final String ICY_PROTOCOL_NAME = "ICY";

		private IcyLineParser() {
			super();
		}

		@Override
		public boolean hasProtocolVersion(CharArrayBuffer buffer,
				ParserCursor cursor) {
			boolean superFound = super.hasProtocolVersion(buffer, cursor);
			if (superFound) {
				return true;
			}
			int index = cursor.getPos();

			final int protolength = ICY_PROTOCOL_NAME.length();

			if (buffer.length() < protolength)
				return false; // not long enough for "HTTP/1.1"

			if (index < 0) {
				// end of line, no tolerance for trailing whitespace
				// this works only for single-digit major and minor version
				index = buffer.length() - protolength;
			} else if (index == 0) {
				// beginning of line, tolerate leading whitespace
				while ((index < buffer.length())
						&& HTTP.isWhitespace(buffer.charAt(index))) {
					index++;
				}
			} // else within line, don't tolerate whitespace

			if (index + protolength > buffer.length())
				return false;

			return buffer.substring(index, index + protolength).equals(
					ICY_PROTOCOL_NAME);
		}

		@Override
		public Header parseHeader(CharArrayBuffer buffer) throws org.apache.http.ParseException {
			return super.parseHeader(buffer);
		}

		@Override
		public ProtocolVersion parseProtocolVersion(CharArrayBuffer buffer,
				ParserCursor cursor) throws org.apache.http.ParseException {

			if (buffer == null) {
				throw new IllegalArgumentException(
						"Char array buffer may not be null");
			}
			if (cursor == null) {
				throw new IllegalArgumentException(
						"Parser cursor may not be null");
			}

			final int protolength = ICY_PROTOCOL_NAME.length();

			int indexFrom = cursor.getPos();
			int indexTo = cursor.getUpperBound();

			skipWhitespace(buffer, cursor);

			int i = cursor.getPos();

			// long enough for "HTTP/1.1"?
			if (i + protolength + 4 > indexTo) {
				throw new org.apache.http.ParseException("Not a valid protocol version: "
						+ buffer.substring(indexFrom, indexTo));
			}

			// check the protocol name and slash
			if (!buffer.substring(i, i + protolength).equals(ICY_PROTOCOL_NAME)) {
				return super.parseProtocolVersion(buffer, cursor);
			}

			cursor.updatePos(i + protolength);

			return createProtocolVersion(1, 0);
		}

		@Override
		public RequestLine parseRequestLine(CharArrayBuffer buffer,
				ParserCursor cursor) throws org.apache.http.ParseException {
			return super.parseRequestLine(buffer, cursor);
		}

		@Override
		public StatusLine parseStatusLine(CharArrayBuffer buffer,
				ParserCursor cursor) throws org.apache.http.ParseException {
			StatusLine superLine = super.parseStatusLine(buffer, cursor);
			return superLine;
		}
	}
	class MyClientConnection extends DefaultClientConnection {
		@Override
		protected HttpMessageParser createResponseParser(
				final SessionInputBuffer buffer,
				final HttpResponseFactory responseFactory,
				final HttpParams params) {
			return new DefaultResponseParser(buffer, new IcyLineParser(),
					responseFactory, params);
		}
	}

	class MyClientConnectionOperator extends DefaultClientConnectionOperator {
		public MyClientConnectionOperator(final SchemeRegistry sr) {
			super(sr);
		}

		@Override
		public OperatedClientConnection createConnection() {
			return new MyClientConnection();
		}
	}

	public class MyClientConnManager extends SingleClientConnManager {
		private MyClientConnManager(HttpParams params, SchemeRegistry schreg) {
			super(params, schreg);
		}

		@Override
		protected ClientConnectionOperator createConnectionOperator(
				final SchemeRegistry sr) {
			return new MyClientConnectionOperator(sr);
		}
	}
	*/
	
	public static String getImageUrl(String url){
		String u = url.toLowerCase().trim();
		if(u.startsWith("http://")){
			return url;
		}
		return "/lupstar_upload/image.jsp?file_key="+url;
	}
	final static String digits="ABCDEFGHIJKLMNOPQR0123456789STUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	public static String toObjectString(Object obj){
		if(obj==null) return "";
		return obj.toString();
	}
	
	public static String getdecTo62(String s){
		BigDecimal v = new BigDecimal(s); 
		if(v.signum()==-1) return "";
		
		//char buf[] = new char[33];
		//int charPos = buf.length-1;
		BigDecimal o= new BigDecimal(v.toString());
		BigDecimal radix= new BigDecimal(digits.length());
		StringBuffer sb= new StringBuffer();
		int i=0;
		while(v.signum()!=-1){
			//System.out.print(v+"=");
			BigDecimal remainder = v.remainder(radix); 
			v=v.divide(radix,0,RoundingMode.DOWN  );
			char c=digits.charAt(remainder.intValue());
			sb.insert(0,c);
			//System.out.println(v.toString());
			//System.out.print(":"+o.subtract(new BigDecimal(idx*Math.pow(digits.length(),fromIdx)))+":");
			//System.out.println(v+"+"+remainder+":"+c);
			
			//System.out.println(i+++":"+c+":"+v);
			if(v.compareTo(BigDecimal.ZERO)==0){
				break;
			}
			i++;
		}
		return sb.toString();
		//return new String(buf,charPos+1,(buf.length-1-charPos));
	}
	
	public static String get62Todec(String s){
		//BigDecimal o = new BigDecimal("106811522874011516590");
		BigDecimal ret =new BigDecimal(0);
		int fromIdx=0;
		for(int i=s.length()-1; i>-1; i--){
			int idx = digits.indexOf(s.charAt(i));
			//System.out.print(s.charAt(i)+":"+idx+":");
			if(idx<0) return "";
			
			ret=ret.add(new BigDecimal(""+digits.length()).pow(fromIdx).multiply(new BigDecimal(""+idx)));
			
			//System.out.println("sum:"+ret.toString());
			fromIdx++;
		}
		return ret.toString();
	}
	public static String getBirthYr3(String jumin) throws Exception {
		int juminGubun = 5;
		  String birthStr = jumin.substring(0, 6);
		  
		  int century = Integer.parseInt(jumin.substring(juminGubun+1, juminGubun+2));
		  if(century == 9 || century == 0) {
		   birthStr = "18" + birthStr;
		  } else if(century == 1 || century == 2 || century == 5 || century == 6) {
		   birthStr = "19" + birthStr;
		  } else if(century == 3 || century == 4 || century == 7 || century == 8) {
		   birthStr = "20" + birthStr;
		  }
		  return birthStr.substring(0,4);
	}
	public static int getAge3(String jumin) throws Exception {
		  int juminGubun = 5;
		  String birthStr = jumin.substring(0, 6);
		  
		  int century = Integer.parseInt(jumin.substring(juminGubun+1, juminGubun+2));
		  if(century == 9 || century == 0) {
		   birthStr = "18" + birthStr;
		  } else if(century == 1 || century == 2 || century == 5 || century == 6) {
		   birthStr = "19" + birthStr;
		  } else if(century == 3 || century == 4 || century == 7 || century == 8) {
		   birthStr = "20" + birthStr;
		  }
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
		  Date birthDay = sdf.parse(birthStr);
		  
		  GregorianCalendar today = new GregorianCalendar();
		  GregorianCalendar birth = new GregorianCalendar();
		  birth.setTime(birthDay);
		  
		  int factor = 0;
		  if(today.get(Calendar.DAY_OF_YEAR)<birth.get(Calendar.DAY_OF_YEAR)) {
		   factor = -1;
		  }
		  return today.get(Calendar.YEAR) - birth.get(Calendar.YEAR) + factor;
	 }
		
	/*
	public static String get62Todec(String s){
		float ret=0;
		int fromIdx=0;
		for(int i=s.length()-1; i>-1; i--){
			int idx = digits.indexOf(s.charAt(i));
			if(idx<0) return "";
			ret+=idx*Math.pow(digits.length(),fromIdx);
			if(ret>Long.MAX_VALUE){
				//get62Todec1(s.substring)
			}
			
			fromIdx++;
		}
		//BigInteger bi = new BigInteger(ret);
		DecimalFormat dec = new DecimalFormat("################################");
		return dec.format(ret);
	}*/
	public static String getGrade(long point){
		
		if(point<=0){
			return "01"; //??????????????????
		}else if(point<50000){
			return "02";// ????????????
		}else if(point<100000){
			return "03"; // ????????????
		}else if(point<300000){
			return "04"; //????????????
		}else if(point<500000){
			return "05";//????????????
		}else if(point<1000000){
			return "06";//????????????
		}else if(point<2000000){
			return "07";//????????????
		}else if(point<5000000){
			return "08";//????????????
		}else if(point>=5000000){
			return "09";//????????????
		}
		
		return "01";
		
	}
	public static String getFileContent(String filename){
		StringBuffer sb = new StringBuffer();
		try{
			String str=null;
			FileReader fr = new FileReader(filename);
			BufferedReader br = new BufferedReader(fr);
			while( (str=br.readLine())!=null){
				sb.append(str+"\r\n");
			}	
			br.close();
			fr.close();
			
			
		}catch(Exception ex){
			
		}
		return sb.toString();
	}
	public static void writeFile(String filename, String value){
		try{
			FileWriter fw = new FileWriter(filename); 
			fw.write(value);
			fw.close();
		}catch(Exception ex){
			
		}
	}
	public static String getRandomNumber(int len,int limit){
		Random diceRoller = new Random();
 	   StringBuffer sb= new StringBuffer();
 	   for (int i = 0; i < len; i++) {
 	     int roll = diceRoller.nextInt(limit);
 	     sb.append(roll);
 	   }
 	   return sb.toString();

	}
	public static String getEncript(String value){
		
		if(value==null) return null;
		try{
			Base64 b64 = new Base64();
			String bencode= new String(b64.encode(value.getBytes()));
			String uencode = java.net.URLEncoder.encode(bencode,"euc-kr");
			return uencode;
		}catch(Exception e){
		}
		return null;	
	
	}
	
	public static String getDescript(String value){
		if(value==null) return null;
		try{
			Base64 b64 = new Base64();
			String udecode = java.net.URLDecoder.decode(value,"euc-kr");
			String bdecode = new String(b64.decode(udecode.getBytes()));
			return bdecode;
		}catch(Exception e){
			//e.printStackTrace();
		}
		return null;	
	}
//"key=" + URLEncoder.encode ("573fb438aadd036e032876413339c640") +
	
	/*
	public static String getQueryString(DataInfo data){
		
		StringBuffer url = new StringBuffer();
		try{
			Iterator it = data.keyIterator();
			int i=0;
			while(it.hasNext()){
				String name = (String)it.next();
				String value=data.getString(name);
				if(i!=0){
					url.append("&");
				}
				url.append(name+"="+java.net.URLEncoder.encode(value,"euc-kr"));
				i++;
			}
		}catch(Exception ex){
			
		}
		return url.toString();
	}
	*/
	public static String toString(String st,String o_c,String t_c){	
		if(st==null) return "";	
		try {
			return new String(st.getBytes(o_c),t_c);
		}catch(Exception e) {
			return st;
		}
	}
	public static String toString(String st){	
		if(st==null) return "";	
		try {
			return new String(st.getBytes("8859_1"),"euc-kr");
		}catch(Exception e) {
			return st;
		}
	}
	
	public static String convertGet(String st){
		try {
			return new String(st.getBytes("8859_1"),"EUC_KR");
		}catch(Exception e) {
			return st;
		}
	}
	
	public static String convert(String st){
		try {
			return new String(st.getBytes("EUC_KR"),"8859_1");
		}catch(Exception e) {
			return st;
		}
	}

	public static String convertKSC(String st){
		try {
			return new String(st.getBytes("8859_1"),"KSC5601");
		}catch(Exception e) {
			return st;
		}
	}
	 
/**
 * ?????????????????? ????????????????????????( ...?????? ??????????????????) String?????? ?????????????????? Return ?????? ????????????.
 * @param data
 * @param len ?????????????????? ??????????????????
 */
	
	public static String getString(String data, int len){
		 if(data.length()<=len){
			 return data;
		 }else{
			 StringBuffer sb = new StringBuffer(data.substring(0,len));  
			 sb.append("...");
			 return sb.toString();
		 }
	}

	public static String getSubString(String data, int len){
		if(data==null||data.equals(""))return "";
		
		String temp;
		int index = data.indexOf("\n");
		if(index<0)temp = data;
		else temp = data.substring(0,index-1);
			
		int templength = temp.length();
		if(len > templength) return temp;
		else return temp.substring(0,len)+"...";		
	}
	
	public static String getSubStringKr(String data,int len) {
		try {
			String temp;
			int index = data.indexOf("\n");
			if(index<0)temp = data;
			else temp = data.substring(0,index-1);
	
			int templength = temp.length();
			
			int ln = 0;
			for(int i=0;i<templength;i++) {
				if(temp.charAt(i)<256) {
					ln = ln + 1;
				}else {
					ln = ln + 2;
				}
				if(ln > len) {
					return temp.substring(0,i-3)+"...";
				}
			}
			return temp;
	   }catch(Exception e) {
			   return "";
	   }	
   }		

	public static String getConnectString(int typeconnect){
		if(typeconnect<1){
			return "??????????????????";
		}else{
			return "????????????";
		}
	}
	
	

/**
 * ?????????????????? ???????????????????????? ?????????????????? Return ?????? ????????????.<br>
 * ?????????????????? 71(??????????????????)?????? 1900?????? ?????????????????? ????????????????????????.<br>
 * @param birthyear
 */
	public static int getAge(int birthyear){
		if(birthyear<0)return 0;
		if(birthyear<100){
			birthyear += 1900;
		}
		java.util.Calendar c = java.util.Calendar.getInstance();
		return  c.get(java.util.Calendar.YEAR) - birthyear + 1;
	}

	public static int getBirthyear(int age){
		if(age<0 )return 0;
		java.util.Calendar c = java.util.Calendar.getInstance();
		return  c.get(java.util.Calendar.YEAR) - age + 1;
	}
	public static boolean isAdult(String reso_no){
		int age = getFullAge(reso_no);
		if(age<19){
			return false;
		}
		return true;
	}
	public static int getFullAge(String reso_no){
		
		//Calendar cal= Calendar.getInstance ();
		//int nyear = cal.get(Calendar.YEAR);
		String year = "19"+reso_no.substring(0,2);
		
		
		String month = reso_no.substring(2,4);
		String day = reso_no.substring(4,6);
		int age = getFullAge(Integer.parseInt(year),Integer.parseInt(month),Integer.parseInt(day));
		if(age>=100){
			age = getFullAge(Integer.parseInt("20"+reso_no.substring(0,2)),Integer.parseInt(month),Integer.parseInt(day));
		}
		return age;
	}
	public static int getFullAge(int year,int month,int day){
		Calendar cal= Calendar.getInstance ();
	    //int year = 1974;
	    //int month = 7;
	    //int day = 13;
	    cal.set(Calendar.YEAR, year);
	    cal.set(Calendar.MONTH, month-1);
	    cal.set(Calendar.DATE, day);
	    
	    Calendar now = Calendar.getInstance ();
	    
	    int age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
	    if (  (cal.get(Calendar.MONTH) > now.get(Calendar.MONTH))
	            || (    cal.get(Calendar.MONTH) == now.get(Calendar.MONTH) 
	                    && cal.get(Calendar.DAY_OF_MONTH) > now.get(Calendar.DAY_OF_MONTH)   )   
	    ){
	        age--;
	    }
    	return age;
	}
/**
 * Mysql Query ?????????????????? Escape????????????(\,') ???????????? ????????????????????????.<br>
 * \ ?????? '?????????????????? \?????? ?????????????????? ????????????.
*/		
	public static String convertMysql(String s){
		if(s == null) return "";
		StringBuffer b = new StringBuffer();
		for(int i = 0; i < s.length(); i++){
			char c = s.charAt(i);
			if(c == '\\' || c == '\'') b.append('\\');
			b.append(c);
		}
		return b.toString();
	}

/**
 * Mssql Query ?????????????????? Escape ????????????(') ???????????? ????????????????????????.<br>
 * '?????????????????? '?????? ?????????????????? ????????????.
*/		
	public static String convertMssql(String s){
		if(s == null) return "";
		StringBuffer b = new StringBuffer();
		for(int i = 0; i < s.length(); i++){
			char c = s.charAt(i);
			if(c == '\'' || c == '\"') b.append(c);
			b.append(c);
		}
		return b.toString();
	}

/**
 * Query ?????????????????? Escape ????????????(",') ???????????? ????????????????????????.<br>
 * ",'?????????????????? " "(????????????)???????????? ????????????????????????.
*/		
	public static String convertQuery(String s){
		if(s == null) return "";
		StringBuffer b = new StringBuffer();
		for(int i = 0; i < s.length(); i++)
		{
			char c = s.charAt(i);
			if(c == '\"' || c == '\'') continue;
			else b.append(c);
		}
		return b.toString();
	}
	
/**
 * String?????? CR?????? < br >?????? ?????????????????? ????????????????????????.
 */		
	public static String convertCRToBR(String s)
	{
		if(s==null) return "";
		StringBuffer sb = new StringBuffer(s);
		StringBuffer temp = new StringBuffer();
		for(int i=0;i<sb.length();i++) {
			char c = sb.charAt(i);
			if(c=='\n') {
				temp.append("<br>");
				continue;
			}
			if(c=='\r') continue;
			temp.append(c);
		}
		
		return temp.toString();
	}

/**
 * String?????? < br >?????? CR?????? ?????????????????? ????????????????????????.
 */		
	public static String convertBRToCR(String s){
		if(s==null||s.equals("")) return "";
		String sb = s;
		String tmp;
		StringBuffer temp = new StringBuffer();
		int index = 1;
		while(index>-1) {
			index = sb.indexOf("<br>");
			if(index>-1) {
				tmp = sb.substring(0,index);
				sb = sb.substring(index+4);
				temp.append(tmp);
				temp.append('\n');
				continue;
			}
		}
		temp.append(sb);
		return temp.toString();
	}

/**
 * ???????????????????????? ???????????????????????? ???????????? ?????????????????????????????? ?????????????????? ????????????????????????.???????????????????????? ???????????? ?????????????????? ?????????????????? ????????????????????????.<br>
*/		
	public static int convertId(String id)	{
		if(id==null||id.equals("")) return 0;
		String nid = "";
		try{
			nid = new String(id.getBytes("KSC5601"));
		}catch(Exception e){
			return 0;
		}
		
		for(int i=0;i<id.length();i++){
			if(id.charAt(i)!=nid.charAt(i)){
				return i;
			}
		}
		return -1;
	}

/**
 * String?????? ?????????????????????????????? ????????????????????????.<br>
*/		
	public static int getLength(String str)	{
		if(str==null||str.equals("")) return 0;
		try{
			byte[] btstr = str.getBytes();
			if(btstr==null)return 0;
			
			return btstr.length;
			
		}catch(Exception e){
			return 0;
		}
	}

	public static String getCodeString(String str){
		if(str==null)return String.valueOf(System.currentTimeMillis());
		
		int codesum = 0;
		for(int i = 0; i < str.length(); i++){
			char c = str.charAt(i);
			codesum += ((int)c)*(i+1);
		}
		return String.valueOf(codesum);
	}
	public static String getQueryString(HttpServletRequest request){
		
		if (request.getMethod().equals("GET")){
			String qs = request.getQueryString();
			if(qs==null)
				return "";
			else	return Convert.toString(request.getQueryString());
		}
		else {
			String param="";
			java.util.Enumeration en = request.getParameterNames();
			//param="?";
			while(en.hasMoreElements()){
				String k1= (String)en.nextElement();
				String v1 = Convert.toString(request.getParameter(k1));
				param+=k1+"="+v1+"&";
			}
			return param;
		}	
	}
	public static String getFullUrl(HttpServletRequest request){
		
		if (request.getMethod().equals("GET")){
			String qs = request.getQueryString();
			
			String uri = request.getScheme() + "://" +   // "http" + "://
		             request.getServerName() +       // "myhost"
		             ":" +                           // ":"
		             request.getServerPort() +       // "8080"
		             request.getRequestURI() +       // "/people"
		             "?" +                           // "?"
		             request.getQueryString();   
			return uri;
			/*
			if(qs==null)
				return "http://"+request.getServerName()+request.getRequestURI();
			else	return "http://"+request.getServerName()+request.getRequestURI()+"?"+Convert.toString(request.getQueryString());
			*/
		}
		else {
			String param="";
			java.util.Enumeration en = request.getParameterNames();
			param="?";
			while(en.hasMoreElements()){
				String k1= (String)en.nextElement();
				String v1 = Convert.toString(request.getParameter(k1));
				param+=k1+"="+v1+"&";
			}
			return "http://"+request.getServerName()+":"+request.getServerPort() + request.getRequestURI()+param;
		}	 
		
	}

	public static boolean isValid(String str,int length){
		if(str==null||str.equals("")) return true;

		StringBuffer b = new StringBuffer();
		for(int i = 0; i < str.length(); i++){
			char c = str.charAt(i);
			if(c == '\"' || c == '\'')return true;
		}
		
		if(length>0 && getLength(str)>length)return true;
		
		return false;
	}

/**
* String s????????????  a ?????????????????? b?????? ????????????????????????.<br>
*/		
	public static String replaceChar(String s,char a, char b){
		if(s == null) return "";
		return s.replace(a,b);
	}

/**
* String s????????????  a ?????????????????? ????????????????????????.<br>
*/		
	public static String removeChar(String s,char a){
		if(s == null) return "";
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < s.length(); i++)
		{
			char c = s.charAt(i);
			if(c == a)continue;
			else sb.append(c);
		}
		return sb.toString();
	}

/**
 * a???????????????????????? b?????????????????? ????????????????????????.<br>
*/		
	public static String appendChar(String s,char a,char b)	{
		if(s == null) return "";
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < s.length(); i++)
		{
			char c = s.charAt(i);
			if(c == a)sb.append(b);
			sb.append(c);
		}
		return sb.toString();
	}

/**
 * String?????? int?????? ???????????????????????? ????????????????????????.<br>
 * Error?????? 0?????? ????????????????????????.
*/		
	public static int getInt(String str){
		try {
			return Integer.parseInt(str);
		}catch(Exception e) {}
		return 0;
	}

	/**
	 * String?????? long?????? ???????????????????????? ????????????????????????.<br>
	 * Error?????? 0?????? ????????????????????????.
	*/		
		public static long getLong(String str){
			try {
				return Long.parseLong(str);
			}catch(Exception e) {}
			return 0;
		}

/**
 * char?????? int?????? ???????????????????????? ????????????????????????.<br>
*/		
	public static int getInt(char ch){
		try {
			return Integer.parseInt(String.valueOf(ch));
		}catch(Exception e) {}
		return 0;
	}
	
/**
 * java.sql.Date ?????? String?????? ???????????????????????? ????????????????????????.(2002-10-10)<br>
*/		
	public static String getString(java.sql.Date dt){
		return dt.toString();
	}
/**
 * java.util.Date ?????? String?????? ???????????????????????? ????????????????????????.(2002-10-10)<br>
*/		
	public static String getString(java.util.Date dt){
		return dt.toString();
	}

/**
 * int?????? String???????????? ???????????????????????? ????????????????????????.<br>
*/		
	public static String getString(int n){
		return String.valueOf(n);
	}
 
	public final static int DATE = 1;//2003-02-07
	public final static int DATETIME = 2;//2003-02-07 14:44
	public final static int DATE_KR = 3;//2003?????? 02?????? 07??????
	public final static int DATETIME_KR = 4;//2003?????? 02?????? 07?????? 14?????? 44??????

	public static int getYear(){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Seoul"));
		return cal.get(java.util.Calendar.YEAR) ;
	}

	public static int getMonth(){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Seoul"));
		return cal.get(java.util.Calendar.MONTH)+1;
	}
   
	public static int getDay(){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTimeZone(java.util.TimeZone.getTimeZone("Asia/Seoul"));
		return cal.get(java.util.Calendar.DATE);
	}

	public static int MONTH = java.util.Calendar.MONTH;
	public static int DAY = java.util.Calendar.DAY_OF_MONTH;
	public static int YEAR = java.util.Calendar.YEAR;
	
/**
 * ?????? ???????????? ?????????????????? ????????????????????????.<br>
 * ex)
 * Convert.compareDate("20040605", "20040701", Convert.MONTH, 1);
 * 6?????? 5???????????? 7?????? 1???????????? ?????????????????? ???????????? 1???????????? ?????????????????? ?????????????????? true;
 * Convert.compareDate("20040605", "20040701", Convert.DAY, 10);
 * 6?????? 5???????????? 7?????? 1???????????? ?????????????????? ???????????? 10?????? ?????????????????? ?????????????????? false;
 * 
 * @param sdate 20040701
 * @param edate 20040801
 * @param typedate MONTH(??????), DAY(??????, YEAR(??????)
 * @param term ???????????? 1
 * @return ?????? ?????????????????? ?????????????????? ???????????????????????? ?????????????????? true ?????????????????? ?????????????????? false
 */
	public static boolean compareDate(String sdate,String edate, int typedate, int term){
		int nsdate = Convert.getInt(sdate);
		int nedate = Convert.getInt(edate);
		
		return compareDate(nsdate, nedate, typedate, term);
	}

	public static boolean compareDate(int sdate,int edate, int typedate, int term){
		if(sdate>edate){
			sdate ^= edate;
			edate ^= sdate;
			sdate ^= edate;
		}
		
		int y = sdate/10000;
		int m = (sdate-(y*10000))/100;
		int d = sdate-((y*10000)+(m*100));

		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.util.Calendar cal2 = java.util.Calendar.getInstance();
		cal.set(y,m-1,d,0,0,0);

		y = edate/10000;
		m = (edate-(y*10000))/100;
		d = edate-((y*10000)+(m*100));
		cal2.set(y,m-1,d,0,0,0);

		cal.add(typedate,term);

		return cal2.before(cal);
	}

	/**
	 * ?????????????????? ?????????????????? ???????????? ?????????????????? ????????????????????????.<br>
	 * ex)
	 * Convert.compareDate("20040605", Convert.MONTH, 1);
	 * 6?????? 5???????????? ?????????????????? ???????????? 1???????????? ?????????????????? ?????????????????? ????????????????????????.
	 * Convert.compareDate("20040605", Convert.DAY, 10);
	 * 6?????? 5???????????? ?????????????????? ???????????? 10?????? ?????????????????? ?????????????????? ????????????????????????.
	 * 
	 * @param sdate 20040701
	 * @param typedate MONTH(??????), DAY(??????, YEAR(??????)
	 * @param term ???????????? 1, 10, ??????..
	 * @return ?????? ?????????????????? ?????????????????? ???????????????????????? ?????????????????? true ?????????????????? ?????????????????? false
	 */

	public static boolean compareDate(String sdate, int typedate, int term){
		int nsdate = Convert.getInt(sdate);
		
		return compareDate(nsdate, typedate, term);
	}

	public static boolean compareDate(int sdate,int typedate, int term){
		
		int y = sdate/10000;
		int m = (sdate-(y*10000))/100;
		int d = sdate-((y*10000)+(m*100));

		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.util.Calendar cal2 = java.util.Calendar.getInstance();
		cal.set(y,m-1,d);

		cal.add(typedate,term);

		return cal2.before(cal);
	}
	
	public static boolean compareTime(long date,int time){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.util.Calendar caldate = java.util.Calendar.getInstance();
		caldate.setTimeInMillis(date);
		cal.add(java.util.Calendar.HOUR_OF_DAY,time*(-1));

		return cal.before(caldate);
	}
	
	public static boolean isToday(long date){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.util.Calendar caldate = java.util.Calendar.getInstance();
		caldate.setTimeInMillis(date);
		cal.set(cal.get(java.util.Calendar.YEAR),cal.get(java.util.Calendar.MONTH),cal.get(java.util.Calendar.DAY_OF_MONTH),0,0,0);
		return caldate.after(cal);
	}
	
   /**
    * ?????????????????????????????? ?????????????????? ???????????????????????? ???????????????????????? ?????????????????????????????? ????????????????????????.
    * @param format ex) 'yyyyMMddHHmmss' 
    * @return ???????????? ??????????????????
    */
	public static String getDateString(String format) {
		java.text.SimpleDateFormat formatter     = new java.text.SimpleDateFormat (format);
			
		return formatter.format(new java.util.Date());
		
	}
	public static String getRandomId(){
		return ("ABCD"+Convert.getDateString("yyMMddHHmmss")+Convert.getRandomNumber(3, 9));
	}
	public static String getUri(String s){
		return s;
	}
	public static String getNextWeek(String format,long date){
		
		java.text.SimpleDateFormat formatter     = new java.text.SimpleDateFormat (format);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,7-cal.get(java.util.Calendar.DAY_OF_WEEK));
		return formatter.format(cal.getTime());
	
	
	}
	
	public static String getDateString(String format,String date,String retFormat) {

		return getDateString(retFormat,Convert.getDate( date,format));
	}

	public static String getDateString(String format,long date) {
			java.text.SimpleDateFormat formatter     = new java.text.SimpleDateFormat (format);
			
			return formatter.format(new java.util.Date(date));
		}

	public static String getDateAddString(String format,long date,int day) {
		
			java.text.SimpleDateFormat formatter     = new java.text.SimpleDateFormat (format);
			java.util.Calendar cal = java.util.Calendar.getInstance();
			if(date>0){
				cal.setTimeInMillis(date);
			}
			cal.add(Convert.DAY,day);
			
			return formatter.format(cal.getTime());
		}
	public static String getMonthAddString(String format,long date,int month) {
		
		java.text.SimpleDateFormat formatter     = new java.text.SimpleDateFormat (format);
		java.util.Calendar cal = java.util.Calendar.getInstance();
		if(date>0){
			cal.setTimeInMillis(date);
		}
		cal.add(Convert.MONTH,month);
		
		return formatter.format(cal.getTime());
	}

	public static String getYYYYMM(long date){
	
		return 	getDateString("yyyyMM", date);
	}

	public static String getNextYYYYMM(long date){
	
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTimeInMillis(date);
		cal.add(Calendar.MONTH,1);
		cal.getTime();
		return 	getDateString("yyyyMM", cal.getTimeInMillis());
	}

	public static String getPrevYYYYMM(long date){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTimeInMillis(date);
		cal.add(Calendar.MONTH,-1);
		cal.getTime();
		
		return 	getDateString("yyyyMM", cal.getTimeInMillis());
	}
	public static long getDate(String str,String format){
		java.text.SimpleDateFormat simpledateformat = null;
		
		simpledateformat = new java.text.SimpleDateFormat(format);
		Date date = null; 
		
		try {
			date= simpledateformat.parse(str);	
			
		}
		catch (ParseException e) {
			return 0;
		}
		return date.getTime();
	}


/**
 * date long?????? String???????????? ???????????????????????? ????????????????????????.<br>
*/		
	public static String getDateString(long n, int type){
		if( n < 1 ){
			n = System.currentTimeMillis();
		}
		
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.setTime(new  java.util.Date(n));
		
		java.text.SimpleDateFormat simpledateformat = null;
		if(type==DATE)
			simpledateformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		else if(type==DATETIME)
			simpledateformat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		else if(type==DATE_KR)
			simpledateformat = new java.text.SimpleDateFormat("yyyy?????? MM?????? dd??????");
		else
			simpledateformat = new java.text.SimpleDateFormat("yyyy?????? MM?????? dd??????  HH?????? mm??????");
			
		return simpledateformat.format(cal.getTime());
	}
	public static String getMaxDateString(int len){
		String ret="";
		while(len-->0){
			ret+="9";
		}
		return ret;
	}
	public static String getDateString(){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		
		String year = ""+cal.get(java.util.Calendar.YEAR);
		String month = ""+(cal.get(java.util.Calendar.MONTH)+1);
		String day = ""+cal.get(java.util.Calendar.DAY_OF_MONTH);
		
		if(month.length()==1)month="0"+month;
		if(day.length()==1)day="0"+day;
		
		return (year+"-"+month+"-"+day);
	}
	public static String getNumString(int num,int len)
	{
		String output=num+"";
		String zeroSum="";
		for(int i=output.length();i<len;i++)
			zeroSum+="0";
		return zeroSum+output;
	}
	public static String getDateTimeString(){
		java.util.Calendar cal = java.util.Calendar.getInstance();
		
		String year = ""+cal.get(java.util.Calendar.YEAR);
		String month = ""+(cal.get(java.util.Calendar.MONTH)+1);
		String day = ""+cal.get(java.util.Calendar.DAY_OF_MONTH);
		String hour = ""+cal.get(java.util.Calendar.HOUR_OF_DAY);
		String minute = ""+cal.get(java.util.Calendar.MINUTE);
		String second = ""+cal.get(java.util.Calendar.SECOND);
		
		if(month.length()==1)month="0"+month;
		if(day.length()==1)day="0"+day;
		if(hour.length()==1)hour="0"+hour;
		if(minute.length()==1)minute="0"+minute;
		if(second.length()==1)second="0"+second;
		
		return (year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second);
	}        


	public static String szKeyString = "eYbBwOaLtZhAsXuCcVgEjWoDvUfFySpHxTnGiQlJrRmIzPqKkNdM";
	public final static int STRING_LENGTH = 128;

	public static String getUni(String strPlain){
		String ret = "";
		for(int i=0; i< strPlain.length(); i++){
			ret += "!" + (short)strPlain.charAt(i);	
		}
		return ret;
	}
	
	public static String encrypt(String strPlain){
		if( strPlain == null || strPlain.equals("") )
			return null;
		
		//100?????? ???????????? ??????????????????
		if(strPlain.length() > STRING_LENGTH)
			return null;
				
		
		int key, charInt, index, sum=0;
		String encrypt="", strTemp;
		char temp;
			
		//unicode ???????????? ??????????????????.
		strPlain = getUni(strPlain);
		
		
		//random ???????????? ??????????????????.
		//Visual Basic???????????? ?????????????????? ?????????????????? 0???????????? ????????????????????????.
		key = (int)(Math.random() * 52);
		if(key==0) key = 51;
					   
		//System.out.println("key :"+ key);
		
		//key ???????????? ???????????????????????? ?????????????????? ???????????? ????????????????????????.
		//1 ==> 1 + key, 2 = 2 + key..
		for(int i=0; i< strPlain.length(); i++){
			temp = strPlain.charAt(i);
			
			if(temp == '!')	{
				charInt = 11;			
			}else if(temp == '-'){
				charInt = 10;
			}else if(temp >= '0' || temp <= '9'){
				charInt = Integer.parseInt(""+temp);
			}else{
				//System.out.println("error invalid char");
				encrypt = "";
				break;
			}
			sum += charInt;
			index = key + charInt;
			if(index >=52)
				index -= 52;
			
			encrypt += szKeyString.charAt(index);
		}
		
		strTemp = "!"+sum;			
		//System.out.println(strTemp);
		
		//?????????????????? ?????????????????? ???????????????????????? ???????????? ??????????????????
		for(int i=0; i<strTemp.length(); i++){
			temp = strTemp.charAt(i);
			
			if(temp == '!'){
				charInt = 11;			
			}else if(temp == '-'){
				charInt = 10;
			}else if(temp >= '0' || temp <= '9'){
				charInt = Integer.parseInt(""+temp);
			}else{
				//System.out.println("error invalid char");
				encrypt = null;
				break;
			}
			
			index = key + charInt;
			if(index >=52)
				index -= 52;
			
			encrypt += szKeyString.charAt(index);
		}
		return encrypt;
	}
	
	public static String decrypt(String strPass){
		if(strPass == null || strPass.equals(""))
			return null;
		
		//???????????????????????? ???????????????????????? ???????????? ????????????.
		if(strPass.length() > STRING_LENGTH*7+8)
			return null;
		
		//?????????????????? 5???????????? ?????????????????? ????????????
		if(strPass.length() < 5)
			return "error: manipulated";
		
		int key, index, orginIndex;
		int totalSum = 0, thisSum = 0;
		char temp;
		String strTemp = "";
		String decrypt = "";
		
		key = szKeyString.indexOf(""+strPass.charAt(0),0);
		
		//key ???????????? szKeyString?????? ???????????????????????? ?????????????????? 
		if(key == -1)
			return null;
		
		if((key<=10) && (key >= 0)){
			key = (key+52)-11;
		}else if((key >= 11) && (key<=52)){
			key -= 11;
		}else{
			return null;
		}
		
		//System.out.println("key :"+key +"  keyValue :"+ strPass.charAt(0));
		
		//key???????????? ?????? ???????????????????????? ?????????????????? ???????????? ???????????? ???????????? ??????????????????.
		for(int i=0; i<strPass.length(); i++){	
			temp = strPass.charAt(i);
			if(((temp >= 'A') && (temp <='Z')) ||((temp >= 'a') && (temp <='z'))){
				index = szKeyString.indexOf(""+temp, 0);			
				
			}else{
				return null;	
			}
			
			orginIndex = index - key;
			
			if (orginIndex < 0){
				orginIndex = index + 52 -key;	
			}
			
			if ((orginIndex >= 0) && (orginIndex <= 9))	{
				decrypt += orginIndex;	
			}else if(orginIndex == 10){
				decrypt += "-";
			}else if(orginIndex == 11){
				decrypt += "!";
			}else{
				return null;
			}
			
			totalSum += orginIndex;
		}
		
		//?????????????????? !?????? ?????????????????? ?????????????????? ???????????????????????????????????? ???????????? ???????????? ??????????????????.
		index = decrypt.lastIndexOf("!")+1;
		totalSum -= 11;
		
		if(index == decrypt.length())
			return null;
		
		for(int i=index; i<decrypt.length(); i++){
			temp = decrypt.charAt(i);
			if((temp >= '0') && (temp <= '9')){
				totalSum -= Integer.parseInt(""+temp);
				strTemp += temp;
			}else{
				return null; //!???????????? ???????????? ???????????? ?????????????????? ???????????? ???????????????????????? ?????? ?????????????????? ???????????????????????? ??????????????????.
			}
		}
		
		if((totalSum != Integer.parseInt(strTemp)))
			return null;
		else
			decrypt = decrypt.substring(0, index);
		
		
 
		
		java.util.StringTokenizer st = new java.util.StringTokenizer(decrypt, "!");
		strTemp ="";
		int charVal=0;
		while (st.hasMoreTokens())	{
			try{
				charVal = Integer.parseInt(st.nextToken());
			}catch(Exception e){
				return null;
			}
			if((charVal >= -32768) && (charVal <= 32767)) 
				strTemp += (char)charVal;
			else
				return null;	//???????????? ???????????????????????? ?????????????????????????????? 16???????????? ???????????? ???????????? ??????????????????.
		}
		
		return strTemp;
	}

	public static String requestUrl(String url, String param,int type){
		
		if(url==null)return null;
		java.net.URL curl = null;
		
		try{  	
			curl = new java.net.URL(url);
		}catch(java.net.MalformedURLException e){
			return null;
		}

		try {  	  	
			java.net.URLConnection urlConn = curl.openConnection();
			urlConn.setDoOutput(true);
			urlConn.setUseCaches(false);
			urlConn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
					      
			java.io.PrintWriter output = new java.io.PrintWriter(urlConn.getOutputStream());
			String out = param;
			output.print(out);
			output.flush();
			
			java.io.BufferedReader inStream = new java.io.BufferedReader(new java.io.InputStreamReader(urlConn.getInputStream()));
			StringBuffer buf = new StringBuffer();
			int input;
    
			while((input = inStream.read()) > -1){
				buf.append((char)input);
			}
			return buf.toString(); 
			
		}catch(Exception e)	{
			return null;    	
		}
	}
	
	public static String getReadString(InputStream input,String charset){
		
		StringBuffer buf = new StringBuffer();
		java.io.BufferedReader inStream=null;
		int c;
		try{
			inStream = new java.io.BufferedReader(new java.io.InputStreamReader(input,charset));
			while((c = inStream.read()) > -1){
				buf.append((char)c);
			}
		}catch(Exception ex){
			
		}finally{
			try{ inStream.close();}catch(Exception x){}
		}
		return buf.toString(); 
	}
	/**
	 * ???????????? ???????????????????????????????????? 24 ???????????? ???????????? ?????????????????? ???????????? ???????????????????????? ?????????????????? ????????????????????????.
	 * @param time
	 * @return
	 */
	public static boolean isNew(long time){
		if( System.currentTimeMillis()-time >= 1000*60*60*24 ){
			return false;
		}
		return true;
	}
	public static String getHeadImage(int typesex,int isOnline){

		if( isOnline >0){ 
			if(typesex==1){
				return "http://image.skylove.com/intro/ico_man_on.gif";       			
			}else {
				return "http://image.skylove.com/intro/ico_woman_on.gif";       			
			}
		}else {
			if(typesex==1){
				return "http://image.skylove.com/intro/ico_man_off.gif";       			
			}else {
				return "http://image.skylove.com/intro/ico_woman_off.gif";       			
			}
		}
	}
	
	public static String getAstric(String s,int len){
		if(s == null) return "";
		if(s.length()<=len) return s;
		StringBuffer ret = new StringBuffer();
		ret.append(s.substring(0,len));
		for(int i=len; i<s.length(); i++){
			ret.append("*");
		}
		return ret.toString();
		
	}
	public static String toEscapeString (String s){
		if(s== null) return "";
		return s.replaceAll("\"","\\\\\"");
		
		
	}
	public static int getDays(int yyyy,int mm, int dd){
		java.util.Calendar date2 = java.util.Calendar.getInstance();
		java.util.Calendar date1 = java.util.Calendar.getInstance();
		date1.set(yyyy,mm,dd);
		
		//System.out.println(date2.get(Calendar.DAY_OF_YEAR));
		//date2.get(Calendar.DAY_OF_YEAR);
		long time1 = date1.getTimeInMillis() + date1.get(java.util.Calendar.ZONE_OFFSET) + date1.get(Calendar.DST_OFFSET);
		long time2 = date2.getTimeInMillis() + date2.get(Calendar.ZONE_OFFSET) + date2.get(Calendar.DST_OFFSET);
		long days1 = time1/(1000*60*60*24);
		long days2 = time2/(1000*60*60*24);
		long days = days2 - days1;
		
		return (int)days;	
	}
	public static String getDayOfWeek(String yyyymmdd)
	{
		String[] dayOfWeek={"??????","??????","??????","??????","??????","??????","??????"};
        Calendar cal=new GregorianCalendar();
        cal.set(Calendar.YEAR, Integer.parseInt(yyyymmdd.substring(0,4)));
        cal.set(Calendar.MONTH, Integer.parseInt(yyyymmdd.substring(4,6))-1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(yyyymmdd.substring(6,8)));
        String weekday=dayOfWeek[cal.get(Calendar.DAY_OF_WEEK)-1];
        return weekday;
	}
	public static String getHtmlString(String s){
		if(s == null) return "";
		
		StringBuffer ret = new StringBuffer();
		
		for(int i=0; i<s.length(); i++){
			char c =s.charAt(i);
			if(c=='<') ret.append("&lt;");
			else if(c=='>') ret.append("&gt;");
			else if(c=='\n') ret.append("<br>");
			else ret.append(c);
		}
		return ret.toString();
		
	}
	public static String getHideID(String id,int hideLength,boolean enable)
	{
		if(enable==false)
		{
			int len=id.length();
			String dummy="";		
			if(hideLength>id.length()-1)
				hideLength=id.length()-1;
			for(int i=0;i<hideLength;i++)
				dummy+="*";
			id=id.substring(0,len-hideLength)+dummy;
		}
		return id;		
	}
	public static String getDefaultSkinMeeting(){
			
				return "http://image.skylove.com/propose/skin_meeting_s1.gif";
		}
		public static String getDefaultSkin101(){
			
				return "http://image.skylove.com/propose/skin_meeting_s1.gif";
		}
		public static String getDefaultSkinPhoto(){
			return "http://image.skylove.com/propose/skin_photo_s1.gif";
		}
	
		public static String getDefaultSkinMemo(int type){
			if(type==1){
				return "http://image.skylove.com/propose/skin_note_s2.gif";
			}else if(type==2){
				return "http://image.skylove.com/propose/skin_note_s1.gif";
			}else return "";		
		}
	
	
}
