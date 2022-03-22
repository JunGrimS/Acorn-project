package pack.controller.content;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.model.content.ContentDaoInter;
import pack.model.content.LocationDto;
import pack.model.content.LocationPhDto;
import pack.model.content.LocationRegionVO;

@Controller
@RequestMapping("/content")
public class ContentController {
	
	@Autowired
	ContentDaoInter daoInter;
	
	@Autowired
	private LocationRegionVO getRegionClass;
	
	
	@RequestMapping()
	public ModelAndView content() {
		ModelAndView andView=new ModelAndView("content/content");
		String[] regionList=getRegionClass.getRegionList();
		
		andView.addObject("regionList", regionList);
		//랜덤으로 지역 뽑아줄 번호
		int ranNum = new Random().nextInt(15);
		
		//지역 검색할거니깐
		String searchType="loc_region";
		//랜덤으로 뽑힌 추천 지역
		String regionName = regionList[ranNum];
		// 지역 이름 첨부 해주고
		andView.addObject("regionName", regionName);
		//리스트 검색
		List<LocationDto> regionReco = daoInter.getListSelected(searchType, regionName);
		
		
		//도시 선택 이번에는 그냥 중구만 하자
		int ranNum2 = (int)Math.random() * regionList[ranNum].length();
		
		//위에서 한것처럼 랜덤 지역을 얻어내고
		String ranRegion2=getRegionClass.getRegionList()[new Random().nextInt(15)];
		
		String searchType2="loc_city";
		//위에서 한것처럼 랜덤 지역을 얻어내고 그 지역안 도시를 getRegionClass.splitCityNames()를 통해 
		String cityName=getRegionClass.splitCityNames(ranRegion2)[ranNum2];
		andView.addObject("cityName", cityName);
		//그 도시안의 관광지 리스트 보여주기 
		List<LocationDto> cityReco =daoInter.getListSelected(searchType2, cityName);
		
		andView.addObject("regionList", regionList);
		andView.addObject("regionRecoList", regionReco);
		andView.addObject("cityRecoList", cityReco);
		
		return andView;

	}
	
	
	

	// ajax용 지역 리스트 Json 생성기
	@RequestMapping("/region_list")
	@ResponseBody
	public String[] regionListJson() {
		// ajax통해 해당지역 도시리스트 보내기

		return getRegionClass.getRegionList();

	}
	
	@RequestMapping(value = "/city", method = RequestMethod.GET)
	@ResponseBody
	public String[] cityList(@RequestParam("loc_region") String loc_region) {

		return getRegionClass.splitCityNames(loc_region);
	}

	// ajax용 region 입력시 도시 리스트 Json 생성기
	@RequestMapping("/city_list")
	@ResponseBody
	public String[] cityListJson(@RequestParam("loc_region")String loc_region) {
		
		return getRegionClass.splitCityNames(loc_region);
	}
	
	// ajax용 region 입력시 도시 리스트 Json 생성기
	@RequestMapping("/locImg")
	@ResponseBody
	public String locImgJson(@RequestParam("loc_id")String loc_id) {
		
		System.out.println(loc_id);
		
		List<LocationPhDto> phList=daoInter.getLocPh(loc_id);
		
		if(phList!=null) {
			
			String oneUrl=phList.get(0).getLoc_ph_url();
			return oneUrl;
		}else {
			return null;
		}
		}

}
