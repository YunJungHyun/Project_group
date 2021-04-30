package com.spring.login.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.inject.Inject;
import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Service;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Service
public class GoogleAPI {

	@Inject
	UserService userService;

	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://oauth2.googleapis.com/token";

		try {
			URL url = new URL(reqURL);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			// 변경 가능 한 문자열이라는 점에서 StringBuffer과의차이점
			StringBuilder sb = new StringBuilder();
			sb.append("code=" + authorize_code);
			sb.append("&client_id=351044074609-1jm81l8d3bvst0v67cm6ifq31nfmrft6.apps.googleusercontent.com");
			sb.append("&client_secret=HeqwvH2T_xrv-txl9AjAWMtz");
			sb.append("&redirect_uri=http://localhost:8081/googleLogin");
			sb.append("&grant_type=authorization_code");
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			if(responseCode ==200) {
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			// refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			// System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
			
			}else {
				
				access_Token="";
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	public HashMap<String, Object> getUserInfo(String access_Token) {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://www.googleapis.com/oauth2/v2/userinfo?access_Token=" + access_Token;

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			String id = element.getAsJsonObject().get("id").getAsString();
			String email = element.getAsJsonObject().get("email").getAsString();
			String name = element.getAsJsonObject().get("name").getAsString();
			
			UserVO userVO = new UserVO();
			
			String usercode = "g-" + id;
			
			userVO.setUsercode(usercode);
			userVO.setUserid(email);
			userVO.setNickname(name);
			userVO.setLoginsort("google");
			
			 userInfo.put("userVO", userVO);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}

	
}
