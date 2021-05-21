package com.spring.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class KakaoOauth implements OauthInterface {

	private String KAKAO_SNS_BASE_URL = "https://kauth.kakao.com/oauth/authorize";
	private String KAKAO_SNS_TOKEN_BASE_URL = "https://kauth.kakao.com/oauth/token";
	private String KAKAO_SNS_LOGOUT_BASE_URL = "https://kapi.kakao.com/v1/user/logout";
	//private String KAKAO_SNS_UNLINK_BASE_URL = "https://kapi.kakao.com/v1/user/unlink";
	private String KAKAO_SNS_USER_BASE_URL = "https://kapi.kakao.com/v2/user/me";
	private String KAKAO_SNS_CLIENT_ID ="78553ffd86a12678fb1148721501f748";
	private String KAKAO_SNS_REDIRECT_URI="http://localhost:8081/signin/KAKAO/oauth";

	public String getRedirectURL() {
		Map<String, Object> params = new HashMap<>();
		params.put("response_type", "code");
		params.put("client_id", KAKAO_SNS_CLIENT_ID);
		params.put("redirect_uri", KAKAO_SNS_REDIRECT_URI);

		String parameterString = params.entrySet().stream()
				.map(x -> x.getKey() + "=" + x.getValue()) 
				.collect(Collectors.joining("&"));

		return KAKAO_SNS_BASE_URL + "?" + parameterString;
	}



	@Override
	public String requestAccessToken(String code) {
		
		String access_Token = "";
        String refresh_Token = "";
        
        try {
			URL url = new URL(KAKAO_SNS_TOKEN_BASE_URL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
//		    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            // 변경 가능 한 문자열이라는 점에서 StringBuffer과의차이점
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id="+KAKAO_SNS_CLIENT_ID);
            sb.append("&redirect_uri="+KAKAO_SNS_REDIRECT_URI);
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            if(responseCode == 200) {
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            
            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
            
            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);
            
            br.close();
            bw.close();
            }
            else {
            	
            	access_Token= "";
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
	}
	
	@Override
	public HashMap<String, Object> getUserinfo(String access_Token) {
//	    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		    HashMap<String, Object> userInfo = new HashMap<>();
		    
		    try {
		        URL url = new URL(KAKAO_SNS_USER_BASE_URL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        
		        //    요청에 필요한 Header에 포함될 내용
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
		        
		        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
		        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
		        JsonObject profile = kakao_account.getAsJsonObject().get("profile").getAsJsonObject();
		        
		        int id = element.getAsJsonObject().get("id").getAsInt();
		        
		        UserVO userVO = new UserVO();
		        
		        String email = kakao_account.getAsJsonObject().get("email").getAsString();
		    	String profile_img = profile.get("profile_image_url").getAsString();
				String thumnail_img = profile.get("thumbnail_image_url").getAsString();
				String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
				String username = properties.getAsJsonObject().get("nickname").getAsString();
		    
		    	String  usercode = "k-"+id;
		        
		    	userVO.setUsercode(usercode);
		    	userVO.setUserid(email);
		    	userVO.setUsername(username);
		    	userVO.setGender(gender);
		    	userVO.setProfile_img(profile_img);
		    	userVO.setThumnail_img(thumnail_img);
		    	userVO.setUserpw("none");
		    	userVO.setLoginsort("KAKAO");
		   
		    	
		        userInfo.put("userVO", userVO);
		       
		        
		    } catch (IOException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    }
		    
		    return userInfo;
		}
	
	
}
