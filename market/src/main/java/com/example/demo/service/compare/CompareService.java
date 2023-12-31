package com.example.demo.service.compare;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.plaf.multi.MultiListUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.dao.GoodsDao;
import com.example.demo.model.ComparePrice;
import com.example.demo.model.Goods;
import com.example.demo.model.Item;
import com.example.demo.model.PagingPgm;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class CompareService {
	
	@Value("${naver.secret-key}")
	private String clientId;
	@Value("${naver.secret-secret}")
	private String clientSecret;
	
	@Autowired
	private GoodsDao dao;
	
	// 양배추 마켓 페이징
	public PagingPgm paing(String page,String compare_product) {
		if (page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 12;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int total = dao.compare_list_count(compare_product);
		System.out.println("total:"+total);
		
		PagingPgm paging = new PagingPgm(total, rowPerPage, currentPage, startRow, endRow);
		return paging;
	}
	
	// 양배추 마켓 최저가 비교 리스트
	public List<Goods> getList(PagingPgm paging,String compare_product){
		
		Goods tmp = new Goods();
		tmp.setGoods_name(compare_product);
		tmp.setStart_list(paging.getStartRow()-1);
		
		List<Goods> list = new ArrayList<Goods>();
		try {
			list = dao.get_compare_list(tmp);
		}catch(Exception e) {
			
			return list;
		}
//		for(int i=0; i<list.size(); i++) {
//			list.get(i).setGoods_price(Integer.parseInt(format_number(list.get(i).getGoods_price()+"")));
//		}
		System.out.println("list : " + list);
		return list;
		
	}
	
	// 양배추 마켓 최저가 비교 리스트 가격 최고가 , 평균가, 최저가 구하기
	public ComparePrice get_Compare_price(List<Goods> list) {
		ComparePrice price = new ComparePrice();
		if(list.size()>0) { // 검색된 결과가 1개라도 있을때
			int max=0;
			int min=list.get(0).getGoods_price();
			int total=0;
			
			for(int i=0; i<list.size(); i++) {
				if(list.get(i).getGoods_price() > max) {
					max = list.get(i).getGoods_price();
				}
				if(list.get(i).getGoods_price()<min) {
					min = list.get(i).getGoods_price();
				}
				
				total += list.get(i).getGoods_price();
			}
			
			int avg = total/list.size();
			
			price.setLow_price(min);
			price.setHigh_price(max);
			price.setAvg_price(avg);
		}
		
		return price;
	}
	
	
	// 네이버 최저가 페이징
	public ComparePaging paging(String page) {
		if (page == null || page.equals("")) {
			page = "1";
		}
		int currentPage = Integer.parseInt(page);
		int rowPerPage = 12;
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		ComparePaging paging = new ComparePaging(rowPerPage, currentPage, startRow, endRow);

		return paging;

	}

	// 네이버 검색
	public String search(String text, ComparePaging paging) {
		
		String display = String.valueOf(paging.getRowPerPage());
		String start = String.valueOf(paging.getStartRow());
		try {
			text = URLEncoder.encode(text, "UTF-8");
			display = URLEncoder.encode(display, "UTF-8");
			start = URLEncoder.encode(start, "UTF-8");

		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("검색어 인코딩 실패", e);
		}
		String apiURL = "https://openapi.naver.com/v1/search/shop?query=" + text + "&display=" + display + "&start="
				+ start; // JSON 결과

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders);

		System.out.println(responseBody);
		return responseBody;

	}

	// 네이버 검색 결과 total 갯수 구하기
	public int getTotal(String responseBody) {
		ObjectMapper objectMapper = new ObjectMapper();
		int total;
		try {
			JsonNode jsonNode = objectMapper.readTree(responseBody);
			total = jsonNode.get("total").asInt();
			System.out.println("Total: " + total);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return total;
	}

	// 가격에 . 표시
	public String format_number(String number) {
		// 내가 원하는 패턴 생성
		DecimalFormat decimalFormat = new DecimalFormat("#,###");
		try {
			// 문자열을 정수로 파싱한 후 포맷팅합니다.
			int price = Integer.parseInt(number);
			String formattedPrice = decimalFormat.format(price);
			return formattedPrice.toString();
		} catch (NumberFormatException e) {
			System.out.println("Invalid number format");
			return "0";
		}
	}

	// 네이버 검색 결과 데이터 파싱 후 배열로 만들기
	public List<Item> getList(String responseBody) {
		ObjectMapper objectMapper = new ObjectMapper();
		List<Item> list = new ArrayList<Item>();

		try {
			// responseBody를 JsonNode로 변환
			JsonNode jsonNode = objectMapper.readTree(responseBody);

			// 'items' 배열 가지고오기
			JsonNode itemsNode = jsonNode.get("items");

			int total = jsonNode.get("total").asInt();
			System.out.println("Total: " + total);

			// items 배열이 null이 아니고, 원소가 있는지 확인
			if (itemsNode != null && itemsNode.isArray() && itemsNode.size() > 0) {
				// 각각의 item에 대해 반복
				for (JsonNode itemNode : itemsNode) {
					// 각 item의 필드에 접근
					String title = itemNode.get("title").asText();
					String link = itemNode.get("link").asText();
					String image = itemNode.get("image").asText();
					String lprice = format_number(itemNode.get("lprice").asText());
					String brand = itemNode.get("brand").asText();
					String maker = itemNode.get("maker").asText();
					String category1 = itemNode.get("category1").asText();
					
					Item item = new Item(title, link, image, lprice, brand, maker, category1);
					list.add(item);
				}
				return list;
			} else {
				System.out.println("검색 결과가 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("JSON 파싱 오류");
		}
		return list;
	}

	// 네이버 API 연결
	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 오류 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}
	
	// 네이버 API 연결
	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}
	
	// 네이버 API 연결
	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();
			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
		}
	}
}
