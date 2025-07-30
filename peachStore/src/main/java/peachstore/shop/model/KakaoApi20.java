package peachstore.shop.model;


import com.github.scribejava.core.builder.api.DefaultApi20;

//scribe java api는 Google이 기본적으로 지원 됨, 그 이외의 naver, kako는 지원하지 않음
public class KakaoApi20 extends DefaultApi20 {
	private static final String KAKAO_AUTHORIZE_URL="https://kauth.kakao.com/oauth/authorize";
	private static final String KAKAO_ACCESS_TOKEN_URL="https://kauth.kakao.com/oauth/token";
	
	protected KakaoApi20() {}
	private static class InstanceHolder{
		private static final KakaoApi20 INSTANCE = new KakaoApi20();
	}
	
	public static KakaoApi20 instance() {
		return InstanceHolder.INSTANCE;
	}
	
	//네이버의 동의화면 Url주소
	@Override
	protected String getAuthorizationBaseUrl() {
		return KAKAO_AUTHORIZE_URL;
	}

	//네이버에 요청할 토큰 요청 주소
	@Override
	public String getAccessTokenEndpoint() {
		return KAKAO_ACCESS_TOKEN_URL;
	}

}

