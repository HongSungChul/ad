package com.mbagix.ad.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.snu.ids.ha.index.Keyword;
import org.snu.ids.ha.index.KeywordExtractor;
import org.snu.ids.ha.index.KeywordList;
import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.AdmMapper;
import com.mbagix.ad.mapper.KeywordMapper;
import com.mbagix.ad.mapper.MemberMapper;
import com.mbagix.ad.mapper.PointMapper;

/**
 * 광고물 분석  서비스
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

@Service(value = "analService")
public class AnalService {
	@Resource(name = "sysService")
	private SysService sysService;
	
	@Resource(name = "admMapper")
    private AdmMapper admMapper;	
	
	@Resource(name = "keywordMapper")
    private KeywordMapper keywordMapper;
	
	@Resource(name = "pointMapper")
    private PointMapper pointMapper;
	
	@Resource(name = "memberMapper")
    private MemberMapper memberMapper;
	/**
	 * 광고물 조회 추가
	 *
	 * @param Map map 광고물 조회정보
	*/
	public void view(Map<String,Object> map){
		//System.out.println(map);
		admMapper.addView(map);
	}
	
	/**
	 * 광고 키워드 생성
	 *
	 * @param String adUid -광고단위,int cnt - 갯수
	*/
	public List createKeyword(String adUid,int cnt) {
		Float qweight = Float.parseFloat(sysService.getCodeTbl("anal_weight","query").getDescription());
		Float rweight = Float.parseFloat(sysService.getCodeTbl("anal_weight","referer").getDescription());
		
		
		List wordList = new ArrayList();
		
		Map queryMap = new HashMap();
		Map req = new HashMap();
		req.put("adUid", adUid);
		admMapper.deleteWordUser(req);
		List<Map> list = admMapper.getAllRequest(req); 
		for(Map data:list){
			
			String query = (String)data.get("query");
			if(query!=null&& !query.equals("")){
				
				KeywordExtractor ke = new KeywordExtractor();
				KeywordList kl = ke.extractKeyword(query, true);

				
				for( int i = 0; i < kl.size(); i++ ) {
					Keyword kwrd = kl.get(i);
					//System.out.println(kwrd.getString() + "\t" + kwrd.getCnt()+"\t"+kwrd.getTag());
					addWeight(queryMap,kwrd.getString(),qweight*kwrd.getCnt());
				}
			}
			String originHost=(String)data.get("originHost");
			if(originHost!=null&& !originHost.equals("")){
				Map condition = new HashMap();
				condition.put("domain",originHost);
				List<Map> wordSiteList = admMapper.getAllWordSite(condition);
				for(Map wordSite:wordSiteList){
					String sw = (String)wordSite.get("word");
					addWeight(queryMap,sw,rweight);
				}
			}
		}
		Map<String, Float> sortedMapDesc = sortByComparator(queryMap, false);//desc
        //printMap(sortedMapDesc);
		
		int i=0;
		List<Map> res = new ArrayList();
		for (Entry<String, Float> entry : sortedMapDesc.entrySet()){
			
			if(cnt>i){
				//System.out.println("Key : " + entry.getKey() + " Value : "+ entry.getValue());
				Map wordUser = new HashMap();
				wordUser.put("adUid", adUid);
				wordUser.put("word", entry.getKey());
				wordUser.put("weight", entry.getValue());
				
				//System.err.println(wordUser);
				admMapper.addWordUser(wordUser);
				res.add(wordUser);
			}else{
				break;
			}
            i++;
        }
		
		return res;
		//admMapper.addRequest(request);
	}
	/**
	 * 광고단어에 가중치 추가
	 *
	 * @param Map res -정보,String word -단어,float weight -가중치
	*/
	private void addWeight(Map res,String word,float weight){
		Float totalWeight = (Float)res.get(word);
		if(totalWeight==null){
			totalWeight=0f;
		}
		totalWeight += weight;
		res.put(word, totalWeight);
	}
	/**
	 * 정렬
	 *
	 * @param Map<String, Float> unsortMap -광고.가중치, final boolean order -순서
	 * @return 정렬된 값
	*/
	 private static Map<String, Float> sortByComparator(Map<String, Float> unsortMap, final boolean order)
	    {

	        List<Entry<String, Float>> list = new LinkedList<Entry<String, Float>>(unsortMap.entrySet());

	        // Sorting the list based on values
	        Collections.sort(list, new Comparator<Entry<String, Float>>()
	        {
	            public int compare(Entry<String, Float> o1,
	                    Entry<String, Float> o2)
	            {
	                if (order)
	                {
	                    return o1.getValue().compareTo(o2.getValue());
	                }
	                else
	                {
	                    return o2.getValue().compareTo(o1.getValue());

	                }
	            }
	        });

	        // Maintaining insertion order with the help of LinkedList
	        Map<String, Float> sortedMap = new LinkedHashMap<String, Float>();
	        for (Entry<String, Float> entry : list)
	        {
	            sortedMap.put(entry.getKey(), entry.getValue());
	        }

	        return sortedMap;
	    }
	 /**
		 * 모든 광고단위 리턴 
		 *
		 * @param Map<String, Float> condition -광고단위 검색조건 
		 * @return 광고단위 검색 결과
		*/
	 	public List<Map>  getAllAdUid(Map<String,Object> condition){
			return admMapper.getAllAdUid(condition);
		}
}
