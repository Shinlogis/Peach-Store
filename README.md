# 🛒 PeachStore 전자기기 쇼핑몰

PeachStore는 **pPhone, pPad, pMac 등 Apple 기반 스타일의 전자기기와 악세서리**를 판매하는 쇼핑몰입니다. 관리자와 고객 간의 인터랙션, 제품 커스터마이징, 회원 등급별 할인 정책까지 포함된 전자상거래 플랫폼입니다.

프론트엔드는 JSP + Bootstrap/jQuery, 백엔드는 Spring MVC + MyBatis, DB는 MySQL, WAS는 Tomcat으로 구성되어 있습니다.

---

## 🛠️ 기술 스택

![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring MVC](https://img.shields.io/badge/Spring%20MVC-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![MyBatis](https://img.shields.io/badge/MyBatis-0052CC?style=for-the-badge&logo=databricks&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-1A237E?style=for-the-badge)

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-005571?style=for-the-badge&logo=apachetomcat&logoColor=white)

![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)
![jQuery](https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white)

![KakaoLogin](https://img.shields.io/badge/Kakao%20Login-FFCD00?style=for-the-badge&logo=Kakao&logoColor=black)
![NaverLogin](https://img.shields.io/badge/Naver%20Login-03C75A?style=for-the-badge&logo=naver&logoColor=white)
![DaumPostAddress](https://img.shields.io/badge/Daum%20Postcode-FFCD00?style=for-the-badge&logo=Kakao&logoColor=black)

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Eclipse](https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=eclipse-ide&logoColor=white)

![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Lombok](https://img.shields.io/badge/Lombok-A41E11?style=for-the-badge&logo=lombok&logoColor=white)

---

## ✨ 주요 기능

### 👤 회원 기능
| 기능             | 설명                                                            |
| -------------- | ------------------------------------------------------------- |
| **회원가입 / 로그인** | 이메일 및 아이디 기반 회원가입, SNS 로그인(Google, Naver) 연동           |
| **회원정보 관리**    | 비밀번호 변경, 주소 수정, 휴면 전환 등                                       |
| **회원 등급 시스템**  | 누적 구매 금액에 따라 Bronze\~Platinum 등급 자동 승급<br>→ 할인율 및 쿠폰 혜택 차등 적용 |

### 🛒 쇼핑 기능
| 기능                    | 설명                                        |
| --------------------- | ----------------------------------------- |
| **제품 목록 조회**          | 상위/하위 카테고리별 필터링, 활성/비활성 제품 구분             |
| **제품 상세 조회**          | 제품 기본 정보 + 커스터마이징 옵션 (사이즈/색상/용량/각인) 선택 가능 |
| **제품 커스터마이징**         | 옵션에 따른 가격 자동 계산, 각인 문구 입력 등               |
| **장바구니 담기 / 수정 / 삭제** | 동일 제품이라도 옵션이 다르면 개별 항목으로 분리               |
| **주문 생성 (결제)**        | 장바구니 기반 주문 생성 → 결제(토스 페이먼츠) → 결제, 주문 내역 및 `snapshot`에 당시 제품 정보 저장   |
| **주문 상태 확인**          | '상품 준비 전' → '상품 준비 중' → '발송완료' 단계 확인 가능   |

### 💬 고객 서비스 기능
| 기능            | 설명                                |
| ------------- | --------------------------------- |
| **문의 등록**     | 문의 등록, 이미지 첨부 가능     |
| **관리자 답변 확인** | 관리자가 답변 시 `answered_at`과 함께 내용 표시 |
| **리뷰 작성**     | 구매 완료된 상품에 한해 리뷰 작성 가능, 이미지 등록 가능 |

### ⚙️ 관리자 기능
| 기능           | 설명                                       |
| ------------ | ---------------------------------------- |
| **관리자 관리** | 최상위 관리자가 타 관리자를 등록 및 관리 가능            |
| **카테고리 관리**  | 상위/하위 카테고리 생성, 수정, 비활성화 처리 가능            |
| **제품 관리**    | 제품 등록 / 수정 / 삭제, 옵션(색상/사이즈/용량) 및 이미지 등록  |
| **주문 관리**    | 유저 주문 내역 확인 가능  |
| **회원 관리** | 사이트 회원 목록 확인 가능        |
| **리뷰 관리** | 전체 리뷰 확인 및 선택 리뷰 비활성화 가능         |
| **문의 답변**    | 유저 문의 목록 확인 및 관리자 계정으로 답변 작성 가능          |
| **등급 관리**    | 회원 등급 생성, 수정, 삭제 가능         |

📦 기타 기능
| 기능          | 설명                                                     |
| ----------- | ------------------------------------------------------ |
| **스냅샷 기능**  | 주문 당시 제품의 이름, 가격, 옵션 등을 그대로 보존                         |
| **비활성화 관리** | 제품/리뷰/회원 등을 soft-delete 처리 (`is_active = false`) 방식 사용 |

---

## 🏗️ 시스템 아키텍처
| 계층                         | 주요 역할 및 기술             | 설명                                            |
| -------------------------- | ---------------------- | --------------------------------------------- |
| **클라이언트(웹 브라우저)**          | JSP, Bootstrap, jQuery | UI 렌더링, 사용자 입력 수집, AJAX 요청, SNS 로그인 버튼 제공     |
| **웹 서버/서블릿 컨테이너**          | Tomcat                 | HTTP 요청 수신 및 처리, JSP 서블릿 변환                   |
| **애플리케이션 서버 (Spring MVC)** | Spring MVC, MyBatis    | 요청 라우팅, 비즈니스 로직 처리, DB 연동, 트랜잭션 관리, 보안(인증/인가) |
| **DB 서버**                  | MySQL                  | 사용자, 제품, 주문, 리뷰 등 데이터 저장 및 관리             |

---

## 🗃️ 데이터베이스 설계

### 🔑 인증 및 권한 관련 테이블
| 테이블명 | 설명 |
|---|---|
| `admin` | 관리자 정보 및 역할 (`super`, `admin`) |
| `user` | 일반 회원 정보 (소셜 로그인 연동 포함) |
| `sns_provider` | 소셜 로그인 제공자 (Google, Naver) |

### 🛍️ 제품 관련 테이블
| 테이블명 | 설명 |
|---|---|
| `product_topcategory` | 제품 상위 카테고리 (pPhone, pPad 등) |
| `product_subcategory` | 제품 하위 카테고리 (14시리즈 등) |
| `product` | 제품 정보 |
| `product_img` | 제품 이미지 |
| `product_size`, `product_color`, `product_capacity` | 제품 옵션 |
| `product_engraving` | 제품 각인 옵션 |
| `custom_option` | 하나의 제품에 대한 커스터마이징 조합 |

### 🛒 쇼핑 및 주문 관련
| 테이블명 | 설명 |
|---|---|
| `cart`, `cart_item` | 장바구니 및 제품 항목 |
| `order_receipt` | 주문 영수증 (날짜, 상태) |
| `order_detail` | 주문 상세 (수량, 스냅샷) |
| `snapshot` | 주문 시점 제품 정보 스냅샷 |
| `tosspayment` | 결제 정보 저장 |

### 🎟️ 혜택 및 리뷰
| 테이블명 | 설명 |
|---|---|
| `user_grade` | 등급 정보 및 할인율 (Bronze~Platinum) |
| `review`, `review_img` | 제품 리뷰 및 이미지 |
| `inquiry`, `inquiry_img` | 문의 및 이미지, 답변 포함 |


---

## 📂 개발 관련 문서 (Developer Docs)
### 🗃️ 도메인 이미지 저장 폴더

저장 경로 예시

`C:\Dev\Peach-Store-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\peachStore\data\subcategory_17\저장시간.jpg`

`지정명칭_pk` 폴더에 `저장시간.jpg` 파일로 저장합니다.

**지정명칭**
- 상위카테고리: category
- 하위카테고리: subcategory
- 제품: product
- 문의: p
- 리뷰: r

### 📄 주요 문서

- [민감정보 관리 가이드](https://github.com/Shinlogis/Peach-Store/blob/dev/docs/security-guide.md)
  
  OAuth 키 등 민감정보를 안전하게 관리하는 방법이 정리되어 있습니다.

- [공용 파일 매니저 클래스 가이드](https://github.com/Shinlogis/Peach-Store/blob/dev/docs/fileCommonManager-guide.md)

  모든 도메인에서 이미지를 등록할 때 사용할 수 있는 공용 파일 매니저 클래스 사용법이 정리되어 있습니다.

---

## 💬 프로젝트 후기
### 🧢 이세형
수업시간에 배운것들을 구현하면서 듣고만 넘어갔던 개념들에 대해 다시 리뷰해 볼수 있는 시간과 더 나아가 보안과 관련해 조금 더 깊게 알아보고 익힐 수 있는 프로젝트 기간이 되었습니다.

### 🎨 서예닮
Spring Framework의 전반적인 생태계를 이해할 수 있었고, 특히 Spring Boot의 자동 설정 기능과 의존성 주입의 편리함을 체감할 수 있었습니다. 무엇보다 단순한 기능 구현을 넘어서 안정성과 확장성을 고려한 아키텍처 설계의 필요성을 느낄 수 있었습니다.

### 🐇 성유진
배운 내용을 실제로 적용해보며 많은 걸 얻었습니다. 다만 디테일한 부분은 미흡했기에, 다음에는 이런 부분까지 놓치지 않도록 노력할 계획입니다.

### 🧋 김지민
미니 프로젝트였지만 다양한 기능을 직접 구현해보며 스프링에 대한 이해도와 숙련도를 높일 수 있었던 의미 있는 경험이었습니다.

### 🐈 김예진
매일 접하던 쇼핑몰에 이렇게 많은 로직이 필요할지 몰랐습니다. 사용자 입장에서 당연하게 있어야 한다고 생각하는 기능을 어떻게 구현해야 하는지 생각할 수 있는 좋은 기회였습니다. 다음 프로젝트에서는 트러블 슈팅 과정도 세세하게 기록하면 더 좋은 경험이 될 것 같습니다.
