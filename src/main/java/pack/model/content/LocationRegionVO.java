package pack.model.content;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public final class LocationRegionVO {
	//이 class에서 List함수를 사용하지 않는이유는, array가 더 빠르기 때문
	 
	//인터넷에서 전국 광역시/도 리스트 긁어온걸 split()으로 각각 잘라 배열로 담고 return 하는 함수 만듬
	public String[] getRegionList() {
		String list="서울#부산#대구#인천#광주#대전#울산#세종#경기#강원#충북#충남#경북#경남#전북#전남#제주";
        String[] regionList=list.split("#");
		return regionList;
	}
	
	
	//인터넷에서 전국 광역시/도별 소속 시/군 리스트를 String 한줄로 긁어온후
	//#서울
	String 서울="강남구 강동구 강북구 강서구 관악구 광진구 구로구 금천구 노원구 도봉구 동대문구 동작구 마포구 서대문구 서초구 성동구 성북구 송파구 양천구 영등포구 용산구 은평구 종로구 중구 중랑구";
	//#부산
	String 부산="강서구 금정구 남구 동구 동래구 부산진구 북구 사상구 사하구 서구 수영구 연제구 영도구 중구 해운대구 기장군";
	//#대구
	String 대구="남구 달서구 동구 북구 서구 수성구 중구 달성군";
	//#인천
	String 인천="계양구 남동구 동구 미추홀구 부평구 서구 연수구 중구 강화군 옹진군";
	//#광주
	String 광주="광산구 남구 동구 북구 서구";
	//#대전
	String 대전="대덕구 동구 서구 유성구 중구";
	//#울산
	String 울산="남구 동구 북구 중구 울주군";
	//#세종
	String 세종="세종 ";
	//#경기
	String 경기="고양시 과천시 광명시 광주시 구리시 군포시 김포시 남양주시 동두천시 부천시 성남시 수원시 시흥시 안산시 안성시 안양시 양주시 여주시 오산시 용인시 의왕시 의정부시 이천시 파주시 평택시 포천시 하남시 화성시 가평군 양평군 연천군";
	//#강원
	String 강원="강릉시 동해시 삼척시 속초시 원주시 춘천시 태백시 고성군 양구군 양양군 영월군 인제군 정선군 철원군 평창군 홍천군 화천군 횡성군";
	//#충북
	String 충북="제천시 청주시 충주시 괴산군 단양군 보은군 영동군 옥천군 음성군 증평군 진천군";
	//#충남
	String 충남="공주시 계룡시 논산시 당진시 보령시 서산시 아산시 천안시 금산군 부여군 서천군 예산군 청양군 태안군 홍성군";
	//#경북
	String 경북="경산시 경주시 구미시 김천시 문경시 상주시 안동시 영주시 영천시 포항시 고령군 군위군 봉화군 성주군 영덕군 영양군 예천군 울릉군 울진군 의성군 청도군 청송군 칠곡군";
	//#경남
	String 경남="거제시 김해시 밀양시 사천시 양산시 진주시 창원시 통영시 거창군 고성군 남해군 산청군 의령군 창녕군 하동군 함안군 함양군 합천군";
	//#전북
	String 전북="군산시 김제시 남원시 익산시 전주시 정읍시 고창군 무주군 부안군 순창군 완주군 임실군 장수군 진안군";
	//#전남
	String 전남="광양시 나주시 목포시 순천시 여수시 강진군 고흥군 곡성군 구례군 담양군 무안군 보성군 신안군 영광군 영암군 완도군 장성군 장흥군 진도군 함평군 해남군 화순군";
	//#제주"
	String 제주="제주시 서귀포시";
	//와 개노가다...
	
	
	// 해당 region 이름을 받아서 해당 지역 소속 도시배열을 return 하는 함수  
	public String[] splitCityNames(String region) {
		//Arrays.stream(region.split(" ")).forEach(i -> System.out.println(i));
		String cities=null;
		try {
			//매개변수로 받아온 region을 통해 위에 선언한 지역 field(String)을
			//불러올수 있는 방법이 생각이 나지 않아 class reflection함수를 사용해서 해당지역 String을 가져옴
			Field fd=getClass().getDeclaredField(region);
			try {
				cities=(String)fd.get(this);
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//해당 지역 도시들 array return
		return cities.split(" ");
	}
	
	//모든 지역과 지역안 소속 도시들의 map을 반환하는 method
	public Map<String, String[]> getRegionCityMap(){
		Map<String, String[]> cityMap=new HashMap<String, String[]>();
		//전국의 광역시/도 리스트의 배열을 받아오고
		String[] regionList=getRegionList();
		//각 광역시/도의 이름에 소속되는 도시들의 array를 map에 집어넣는 함수
		for (int i = 0; i < regionList.length; i++) {
			
			cityMap.put(regionList[i], splitCityNames(regionList[i]));
			//출력 확인 완료 
			//Arrays.stream(splitCityNames(regionList[i])).forEach(a -> System.out.println(a));
		}
		//아오 내가 미쳤지... 이거 절대 다시 못만듬...
		return cityMap;
		
		
	}
}
