package com.example.demo.service.mypage;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;

@Service
public class CreateImageService {
	
	@Autowired
	MemberDao memberDao;
	
    @Value("${kakao.RestApi-key}")
    String restApiKey;

    public String request(String prompt,HttpServletRequest request,HttpSession session) {
    	String url = "https://api.kakaobrain.com/v2/inference/karlo/t2i";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", " KakaoAK "+restApiKey);
        headers.add("Content-Type", " application/json");
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("prompt", prompt);
        map.put("image_quality", 100);
        map.put("image_format", "jpeg");

        RestTemplate template = new RestTemplate();
        HttpEntity<Map<String,Object>> entity = new HttpEntity<Map<String,Object>>(map,headers);
        ResponseEntity<String> response = template.exchange(url, HttpMethod.POST, entity, String.class);
        
        ObjectMapper obj = new ObjectMapper();
        String imageUrl="";
        
		try {
			JsonNode node = obj.readTree(response.getBody());
			imageUrl = node.get("images").get(0).get("image").asText();

			String destinationPath = request.getRealPath("/upload/") +session.getAttribute("member_id")+ ".jpeg"; // 저장할 파일 경로

			downloadImage(imageUrl, destinationPath);
			
			// 데이터 베이스에 파일 명 저장
			Member member = new Member();
			member.setMember_id((String)session.getAttribute("member_id"));
			member.setMember_image(session.getAttribute("member_id")+ ".jpeg");
			int result = memberDao.setImage(member);
			
			System.out.println("이미지 다운로드 및 저장 성공!");
		} catch (IOException e) {
			System.err.println("이미지 다운로드 및 저장 중 오류 발생: " + e.getMessage());
			return "Fail";
		}
        
        
		return "Success";
    }
    
    private static void downloadImage(String imageUrl, String destinationPath) throws IOException {
        URL url = new URL(imageUrl);

        BufferedImage image = ImageIO.read(url);
        
        // 파일로 저장
        File destinationFile = new File(destinationPath);
        ImageIO.write(image, "jpeg", destinationFile);
    }

}
