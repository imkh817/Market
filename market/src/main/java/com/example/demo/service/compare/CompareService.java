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

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.model.Item;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


@Service
public class CompareService {
	
	@Value("${naver.secret-key}")
	private String clientId;
	@Value("${naver.secret-secret}")
	private String clientSecret;
	
	// 페이징
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

	// 검색
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

	// 검색 결과 total 갯수 구하기
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

	// 검색 결과 데이터 파싱 후 배열로 만들기
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

					Item item = new Item(title, link, image, lprice);
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
