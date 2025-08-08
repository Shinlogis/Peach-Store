
# 🔐 민감정보(application.properties) 관리 가이드

Spring 프로젝트에서 **OAuth 키, DB 비밀번호 등 민감한 설정값은 외부로 노출되면 안 됩니다.**  
이를 안전하게 관리하기 위한 방법을 아래에 정리합니다.

---

## ✅ 1. `application.properties`에 민감정보 분리

Spring에서는 `@Value` 애노테이션을 사용해 외부 파일에서 설정값을 주입받을 수 있습니다.

### 📁 파일 위치
```
src/main/resources/application.properties
```

### 🛠 예시

```properties
# 구글 OAuth 설정
oauth.google.clientId=YOUR_GOOGLE_CLIENT_ID
oauth.google.clientSecret=YOUR_GOOGLE_CLIENT_SECRET
oauth.google.callback=http://localhost:8080/login/google/callback

# 네이버 OAuth
oauth.naver.clientId=YOUR_NAVER_CLIENT_ID
oauth.naver.clientSecret=YOUR_NAVER_CLIENT_SECRET
oauth.naver.callback=http://localhost:8080/login/naver/callback

# 카카오 OAuth
oauth.kakao.clientId=YOUR_KAKAO_CLIENT_ID
oauth.kakao.clientSecret=YOUR_KAKAO_CLIENT_SECRET
oauth.kakao.callback=http://localhost:8080/login/kakao/callback
```

---

## ✅ 2. Java 설정파일에서 값 주입

예: `UserWebConfig.java`

```java
@Configuration
@PropertySource("classpath:application.properties")
@EnableWebMvc
@ComponentScan(basePackages = {
    "mall.shop.controller",
    "mall.shop.service",
    "mall.shop.repository"
})
public class UserWebConfig {

    // 구글 OAuth 설정
    @Value("${oauth.google.clientId}")
    private String googleClientId;

    @Value("${oauth.google.clientSecret}")
    private String googleClientSecret;

    @Value("${oauth.google.callback}")
    private String googleCallback;

    // ... 네이버, 카카오도 동일하게 작성
}
```

---

## ✅ 3. `.gitignore`로 Git에서 제외하기

민감정보가 담긴 설정 파일이 GitHub에 올라가지 않도록 **`.gitignore` 설정은 필수**입니다.

### 📁 `.gitignore` 예시

```bash
# application.properties 제외
/src/main/resources/application.properties
```

### 커밋 전 확인

```bash
git status
```

---

## 📌 요약

| 항목 | 설명 |
|------|------|
| 민감정보 위치 | `application.properties` |
| Git 제외 방법 | `.gitignore`에 추가 |
| Java 주입 방식 | `@Value` + `@PropertySource` |
| 팀원 공유 | 메신저, 클라우드 등 안전한 방식 |
| 실수 예방 | `git status` 확인 필수 |
