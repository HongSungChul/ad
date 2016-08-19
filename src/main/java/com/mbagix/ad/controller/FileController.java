package com.mbagix.ad.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


/**
 * 파일 업로드 컨트롤러  
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


@RequestMapping("/file")
@Controller(value = "fileController")

public class FileController {
	
	  
    private String UPLOAD_DIR="/Users/paparoti/temp/temp";
	
	
    
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public ModelAndView test() {
        return  new ModelAndView("home");
    }
    private File getUploadedFile(String fileName){
    	
    	String service=fileName.substring(0,2);
    	String folder=fileName.substring(2,5);
    	//String aaa=fileName.substring(5);
    	
    	return  new File(UPLOAD_DIR +File.separatorChar + service+File.separatorChar+
    			folder+File.separatorChar+fileName);
    	
		
    	
    }
    @ResponseBody
    @RequestMapping(value = "/image/{fileName:.+}",method = RequestMethod.GET)
    public BufferedImage  image(@PathVariable("fileName") String fileName
    		,@RequestParam(value = "width", required = false, defaultValue="0") Integer width,@RequestParam(value = "height", required = false, defaultValue="0") Integer height) {
    	//System.err.println(">>"+fileName);
    	
    	File file = getUploadedFile(fileName);
    	//System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+file.getAbsolutePath());
    	if(!file.exists()) return null;
    	BufferedImage image = null;
    	try {
    		if(width==0 && height==0){
        		return ImageIO.read(new FileInputStream(file));
        	}	
    		
    		image = ImageIO.read(file);
    		
    		int rwidth = width;
    		int rheight=height;
    		if(width==0 && height!=0){
    			float ratio = height/image.getHeight();
    			rheight=height;
    			rwidth=(int)(ratio*(float)width);
    		}else if(width!=0 && height==0){
    			float ratio = width/image.getWidth();
        		rwidth=width;
        		rheight=(int)(ratio*(float)height);
        		
    		}
    		BufferedImage thumbnail =
      			  Scalr.resize(image, Scalr.Method.SPEED, Scalr.Mode.FIT_TO_WIDTH,
      			               rwidth, rheight, Scalr.OP_ANTIALIAS);
    		
    		return thumbnail;
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return null;
    	//return  new ModelAndView("home");
    }
    @RequestMapping(value = "/upload", method = RequestMethod.POST, produces="application/json; charset=utf-8")
    @ResponseBody 
    public Object fileSubmit(@RequestParam("service") String service,
            @RequestParam("files[]") MultipartFile uploadfile) {
    	
    	//JsonResult jsonResult = new JsonResult();
    	Map jsonResult = new HashMap();
        //MultipartFile uploadfile = dto.getUploadfile();
        if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            //dto.setFileName(fileName);
            try {
                // 1. FileOutputStream 사용
                // byte[] fileData = file.getBytes();
                // FileOutputStream output = new FileOutputStream("C:/images/" + fileName);
                // output.write(fileData);
                  
                // 2. File 사용
            	//{"files":[
            	

            	//String service = dto.getService();
            	if(service==null || service.equals("")) service="00";
            	String folder = getRandomFolder();
            	SimpleDateFormat format1 = new SimpleDateFormat("yyMMddHHmmss");
        		
        		String key=format1.format(Calendar.getInstance().getTime());
        		
        		String extension = getFileExtension(fileName);
        		String newFileName = service+folder+key+(extension.equals("")?"":"."+extension);
    			
    			
    			File newDir = new File(UPLOAD_DIR + "/" + service+"/"+folder );
    			if (!newDir.exists()) newDir.mkdirs();
    			
    			Map item = new HashMap();
    	 		item.put("name",fileName);
    	 		item.put("size", uploadfile.getSize());
    	 		item.put("deleteType", "DELETE");
    	 		item.put("url", "/ad/file/image/"+newFileName);
    	 		item.put("thumbnailUrl", "/ad/file/image/"+newFileName+"?width=100");
    	 		item.put("deleteUrl", "/ad/file/image/"+newFileName);
    	 		item.put("type","image/"+extension);
    	 		//com.mbagix.jc.model.Driver
    	 		List array =  new ArrayList();
    	 		array.add(item);
    	 		jsonResult.put("files", array);
    			File newFile = new File(newDir,newFileName);
    			
    			
                //File file = new File("C:/images/" + fileName);
                uploadfile.transferTo(newFile);
                
                //jsonResult.setData(newFileName);
            } catch (IOException e) {
                e.printStackTrace();
                //jsonResult.setMsg(e.getMessage());
                //jsonResult.setSuccess(false);
            } // try - catch
        } // if
        // 데이터 베이스 처리를 현재 위치에서 처리
        //return "redirect:getBoardList.do"; // 리스트 요청으로 보내야하는데 일단 제외하고 구현
        return jsonResult;
    }
    private String getFileExtension(String fileName){
    	String extension = "";

    	int i = fileName.lastIndexOf('.');
    	if (i > 0) {
    	    extension = fileName.substring(i+1);
    	}
    	return extension;
    }
    private String getRandomFolder(){
    	long currenttime = System.currentTimeMillis();
		//int ran = (int) (500 * Math.random());
		int ran = (int) (currenttime%1000);
		String folderStr = String.valueOf(ran);
		while (folderStr.length() < 3) folderStr = "0" + folderStr;
		return folderStr;
    }
    
    
    
}