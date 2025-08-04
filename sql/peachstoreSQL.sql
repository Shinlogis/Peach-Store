USE ELECTRONICMALL;
-- 부모부터 순서로 DELETE 되도록 순서 맞춰서 수정 해주세요
-- CREATE INSERT 전부 DROP순서랑 맞추어 놓았으니 찾을 일 있으면 참고하세요
DROP TABLE IF EXISTS review_img; -- 리뷰 이미지
DROP TABLE IF EXISTS review; -- 리뷰
DROP TABLE IF EXISTS order_detail; -- 주문상세
DROP TABLE IF EXISTS cart_item; -- 장바구니 제품
DROP TABLE IF EXISTS custom_option; -- 제품 커스텀
DROP TABLE IF EXISTS toss_payment; -- 토스 결제 정보
DROP TABLE IF EXISTS order_receipt; -- 주문내역
DROP TABLE IF EXISTS inquiry_img; -- 문의 이미지
DROP TABLE IF EXISTS snapshot; -- 스냅샷
DROP TABLE IF EXISTS product_img; -- 제품 이미지
DROP TABLE IF EXISTS product_size; -- 제품 사이즈
DROP TABLE IF EXISTS product_color; -- 제품 색상
DROP TABLE IF EXISTS product_capacity; -- 제품 용량
DROP TABLE IF EXISTS inquiry; -- 문의
DROP TABLE IF EXISTS cart; -- 장바구니
DROP TABLE IF EXISTS product; -- 제품
DROP TABLE IF EXISTS user; -- 회원
DROP TABLE IF EXISTS product_subcategory; -- 제품 서브 카테고리
DROP TABLE IF EXISTS grade_coupon; -- 등급별 쿠폰
DROP TABLE IF EXISTS user_grade; -- 회원 등급
DROP TABLE IF EXISTS admin; -- 관리자
DROP TABLE IF EXISTS size; -- 사이즈
DROP TABLE IF EXISTS color; -- 색상
DROP TABLE IF EXISTS capacity; -- 용량
DROP TABLE IF EXISTS product_engraving; -- 제품 각인
DROP TABLE IF EXISTS product_topcategory; -- 제품 상위 카테고리
DROP TABLE IF EXISTS coupon; -- 쿠폰
DROP TABLE IF EXISTS sns_provider; -- snsprovider

-- 관리자 테이블 생성(CREATE TABLE admin)
CREATE TABLE admin(
   admin_id int PRIMARY KEY AUTO_INCREMENT
   , email VARCHAR(100) NOT NULL UNIQUE
   , password varchar(100) NOT NULL
   , admin_name varchar(100) NOT NULL
   , role varchar(10) NOT NULL DEFAULT 'admin' CHECK(role in('super', 'admin'))
   , is_active boolean NOT NULL DEFAULT TRUE
);

-- snsprovider 테이블 생성(CREATE TABLE sns_provider)
CREATE TABLE sns_provider(
   sns_provider_id int PRIMARY KEY auto_increment
   , provider_name varchar(12) NOT NULL UNIQUE

);

-- 회원 등급 테이블 생성 (조건 기준 추가)(CREATE TABLE USER_GRADE)
CREATE TABLE USER_GRADE (
    USER_GRADE_ID INT AUTO_INCREMENT PRIMARY KEY,
    USER_GRADE_NAME VARCHAR(50) NOT NULL,
    DISCOUNT_RATE DECIMAL(5,2) NOT NULL,
    CRITERIA_AMOUNT INT NOT NULL, -- 등급 부여 기준 금액 예: 누적 구매금액
    IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
);

-- 회원 테이블 생성(CREATE TABLE user)
CREATE TABLE user(
   user_id int PRIMARY KEY AUTO_INCREMENT
    , id varchar(100) NOT NULL UNIQUE
	, email varchar(100) NOT NULL UNIQUE
    , salt varchar(100) 
    , hashedpassword varchar(100) 
	, user_name varchar(10) NOT NULL 
	, tel varchar(13) UNIQUE
	, address varchar(255)
	, is_active boolean  NOT NULL DEFAULT TRUE
	, created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
	, user_grade_id int NOT NULL DEFAULT 1
    , sns_provider_id int
   , CONSTRAINT fk_user_user_grade_id
      FOREIGN KEY (user_grade_id)
      REFERENCES user_grade(user_grade_id)
    , CONSTRAINT fk_user_sns_provider_id
        FOREIGN KEY (sns_provider_id)
        REFERENCES sns_provider(sns_provider_id)
);

-- 장바구니 테이블 생성(CREATE TABLE CART)
CREATE TABLE CART(
    CART_ID INT PRIMARY KEY AUTO_INCREMENT
    , USER_ID INT NOT NULL UNIQUE
    , CONSTRAINT FK_CART_USER_ID
        FOREIGN KEY (USER_ID)
        REFERENCES USER(USER_ID)
);

-- 문의 테이블 생성(CREATE TABLE INQUIRY)
CREATE TABLE INQUIRY(
    INQUIRY_ID INT PRIMARY KEY AUTO_INCREMENT
    , TITLE VARCHAR(100) NOT NULL
    , INQUIRY_TEXT VARCHAR(200) NOT NULL
    , CREATED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    , ANSWER_TEXT VARCHAR(200) 
    , ANSWERED_AT TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
    , IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
    , USER_ID INT NOT NULL
    , ADMIN_ID INT
    , CONSTRAINT FK_INQUIRY_USER_ID
        FOREIGN KEY (USER_ID)
        REFERENCES USER(USER_ID)
    , CONSTRAINT FK_INQUIRY_ADMIN_ID
        FOREIGN KEY (ADMIN_ID)
        REFERENCES ADMIN(ADMIN_ID)
);

-- 문의 이미지 테이블 생성(CREATE TABLE INQUIRY_IMG)
-- 문의 이미지는 더미데이터 생성하지 않았음
CREATE TABLE INQUIRY_IMG(
    INQUIRY_IMG_ID INT PRIMARY KEY AUTO_INCREMENT
    , FILENAME VARCHAR(100) NOT NULL
    , INQUIRY_ID INT NOT NULL
    , CONSTRAINT FK_INQUIRY_IMG_INQUIRY_ID
        FOREIGN KEY (INQUIRY_ID)
        REFERENCES INQUIRY(INQUIRY_ID)
);

-- 사이즈 테이블 생성(CREATE TABLE size)
CREATE TABLE size(
   size_id int PRIMARY KEY AUTO_INCREMENT
   , size_name varchar(100) NOT NULL
);

-- 컬러 테이블 생성(CREATE TABLE color)
CREATE TABLE color(
   color_id int PRIMARY KEY AUTO_INCREMENT
   , color_name varchar(100) NOT NULL
);

-- 용량 수치 테이블 생성(CREATE TABLE capacity)
CREATE TABLE capacity(
   capacity_id int PRIMARY KEY AUTO_INCREMENT
   , capacity_name varchar(100) NOT NULL
);

-- 제품 각인 테이블 생성(CREATE TABLE product_engraving)
CREATE TABLE product_engraving(
   product_engraving_id int PRIMARY KEY AUTO_INCREMENT
   , engraving_price int NOT NULL CHECK(engraving_price >= 0)
   , engraving_text varchar(10) NOT NULL
);

-- 제품 상위 카테고리 테이블 생성(CREATE TABLE PRODUCT_TOPCATEGORY)
CREATE TABLE PRODUCT_TOPCATEGORY(
   PRODUCT_TOPCATEGORY_ID INT PRIMARY KEY AUTO_INCREMENT
   , PRODUCT_TOPCATEGORY_NAME VARCHAR(100) NOT NULL
   , FILEDIRNAME VARCHAR(30) DEFAULT NULL
    , FILENAME VARCHAR(30)
   , IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
);

-- 제품 하위 카테고리 테이블 생성(CREATE TABLE PRODUCT_SUBCATEGORY)
CREATE TABLE PRODUCT_SUBCATEGORY(
   PRODUCT_SUBCATEGORY_ID INT PRIMARY KEY AUTO_INCREMENT
   , PRODUCT_SUBCATEGORY_NAME VARCHAR(100) NOT NULL
   , PRODUCT_TOPCATEGORY_ID INT NOT NULL
    , FILEDIRNAME VARCHAR(30) DEFAULT NULL
    , FILENAME VARCHAR(30)
    , IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
   , CONSTRAINT FK_PRODUCT_TOPCATEGORY_ID
      FOREIGN KEY (PRODUCT_TOPCATEGORY_ID)
      REFERENCES PRODUCT_TOPCATEGORY(PRODUCT_TOPCATEGORY_ID)
);

-- 제품 테이블 생성(CREATE TABLE product)
CREATE TABLE product(
   product_id int PRIMARY KEY AUTO_INCREMENT
   , is_deleted BOOLEAN DEFAULT FALSE
   , product_code varchar(100) NOT NULL
   , product_name varchar(100) NOT NULL
   , price int NOT NULL
   , introduce varchar(100) NOT NULL
   , detail varchar(100) NOT NULL
   , product_subcategory_id int
   , CONSTRAINT fk_product_product_subcategory_id
      FOREIGN KEY (product_subcategory_id)
      REFERENCES product_subcategory(product_subcategory_id)
);

-- 제품 사이즈 테이블 생성(CREATE TABLE PRODUCT_SIZE)
CREATE TABLE PRODUCT_SIZE(
    PRODUCT_SIZE_ID INT PRIMARY KEY AUTO_INCREMENT
    , ADDITIONAL_PRICE INT NOT NULL DEFAULT 0
    , SIZE_ID INT NOT NULL
    , PRODUCT_ID INT NOT NULL
    , CONSTRAINT FK_PRODUCT_SIZE_SIZE_ID
        FOREIGN KEY (SIZE_ID)
        REFERENCES SIZE(SIZE_ID)
    , CONSTRAINT FK_PRODUCT_SIZE_PRODUCT_ID
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
);

-- 제품 색상 테이블 생성(CREATE TABLE PRODUCT_COLOR)
CREATE TABLE PRODUCT_COLOR(
    PRODUCT_COLOR_ID INT PRIMARY KEY AUTO_INCREMENT
    , COLOR_ID INT NOT NULL
    , PRODUCT_ID INT NOT NULL
    , CONSTRAINT FK_PRODUCT_COLOR_COLOR_ID
        FOREIGN KEY (COLOR_ID)
        REFERENCES COLOR(COLOR_ID)
    , CONSTRAINT FK_PRODUCT_COLOR_PRODUCT_ID
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
);

-- 제품 용량 테이블 생성(CREATE TABLE PRODUCT_CAPACITY)
CREATE TABLE PRODUCT_CAPACITY(
    PRODUCT_CAPACITY_ID INT PRIMARY KEY AUTO_INCREMENT
    , ADDITIONAL_PRICE INT NOT NULL DEFAULT 0
    , CAPACITY_ID INT NOT NULL
    , PRODUCT_ID INT NOT NULL
    , CONSTRAINT FK_PRODUCT_CAPACITY_CAPACITY_ID
        FOREIGN KEY (CAPACITY_ID)
        REFERENCES CAPACITY(CAPACITY_ID)
    , CONSTRAINT FK_PRODUCT_CAPACITY_PRODUCT_ID
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
);

-- 제품 이미지 테이블 생성(CREATE TABLE PRODUCT_IMG)
-- 제품 이미지는 더미데이터 생성하지 않았음
CREATE TABLE PRODUCT_IMG(
    PRODUCT_IMG_ID INT PRIMARY KEY AUTO_INCREMENT
    , FILENAME VARCHAR(30) NOT NULL
    , PRODUCT_ID INT NOT NULL
    , CONSTRAINT FK_PRODUCT_IMG_PRODUCT_ID
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
);

-- 제품 커스텀 옵션 테이블 생성(CREATE TABLE CUSTOM_OPTION)
CREATE TABLE CUSTOM_OPTION(
    CUSTOM_OPTION_ID INT PRIMARY KEY AUTO_INCREMENT
    , PRODUCT_SIZE_ID INT
    , PRODUCT_COLOR_ID INT 
    , PRODUCT_CAPACITY_ID INT
    , PRODUCT_ENGRAVING_ID INT
    , CONSTRAINT FK_CUSTOM_OPTION_PRODUCT_SIZE_ID
        FOREIGN KEY (PRODUCT_SIZE_ID)
        REFERENCES PRODUCT_SIZE(PRODUCT_SIZE_ID)
    , CONSTRAINT FK_CUSTOM_OPTION_PRODUCT_COLOR_ID
        FOREIGN KEY (PRODUCT_COLOR_ID)
        REFERENCES PRODUCT_COLOR(PRODUCT_COLOR_ID)
    , CONSTRAINT FK_CUSTOM_OPTION_PRODUCT_CAPACITY_ID
        FOREIGN KEY (PRODUCT_CAPACITY_ID)
        REFERENCES PRODUCT_CAPACITY(PRODUCT_CAPACITY_ID)
    , CONSTRAINT FK_CUSTOM_OPTION_PRODUCT_ENGRAVING_ID
        FOREIGN KEY (PRODUCT_ENGRAVING_ID)
        REFERENCES PRODUCT_ENGRAVING(PRODUCT_ENGRAVING_ID)
);

-- 장바구니 제품 테이블 생성(CREATE TABLE CART_ITEM)
CREATE TABLE CART_ITEM(
    CART_ITEM_ID INT PRIMARY KEY AUTO_INCREMENT
    , QUANTITY INT NOT NULL DEFAULT 1 CHECK(QUANTITY >= 1)
    , CART_ID INT NOT NULL
    , PRODUCT_ID INT NOT NULL
    , CUSTOM_OPTION_ID INT
    , CONSTRAINT FK_CART_ITEM_CART_ID
        FOREIGN KEY (CART_ID)
        REFERENCES CART(CART_ID)
    , CONSTRAINT FK_CART_ITEM_PRODUCT_ID
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCT(PRODUCT_ID)
    , CONSTRAINT FK_CART_ITEM_CUSTOM_OPTION_ID
        FOREIGN KEY (CUSTOM_OPTION_ID)
        REFERENCES CUSTOM_OPTION(CUSTOM_OPTION_ID)
);

-- 제품 스냅샷 테이블 생성(create table snapshot)
CREATE TABLE snapshot(
   snapshot_id int PRIMARY KEY AUTO_INCREMENT
   , product_id int NOT NULL
   , product_name varchar(100) NOT NULL
   , price int NOT NULL
   , size varchar(100)
   , capacity varchar(100)
   , color varchar(100)
   , engraving varchar(100)
    , filename varchar(100) NOT NULL
);

-- 주문내역 테이블(CREATE TABLE order_receipt)
CREATE TABLE order_receipt(
   order_receipt_id int PRIMARY KEY AUTO_INCREMENT
   , orderdate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
   , order_status varchar(10) NOT NULL DEFAULT '상품 준비 전' CHECK(order_status IN ('상품 준비 전', '상품 준비 중', '발송완료', '주문취소'))
   , user_id int NOT NULL
   , CONSTRAINT fk_order_receipt_user_id
      FOREIGN KEY (user_id)
      REFERENCES user(user_id)
);

-- 주문상세 테이블 생성(CREATE TABLE order_detail)
CREATE TABLE order_detail(
   order_detail_id int PRIMARY KEY AUTO_INCREMENT
   , order_quantity int NOT NULL
   , order_receipt_id int NOT NULL
   , snapshot_id int NOT NULL UNIQUE
   , CONSTRAINT fk_order_detail_order_receipt_id
      FOREIGN KEY (order_receipt_id)
      REFERENCES order_receipt(order_receipt_id)
   , CONSTRAINT fk_order_detail_snapshot_id
      FOREIGN KEY (snapshot_id)
      REFERENCES snapshot(snapshot_id)
);

-- 쿠폰 테이블 생성 (변경 없음)(CREATE TABLE COUPON)
CREATE TABLE COUPON (
    COUPON_ID INT AUTO_INCREMENT PRIMARY KEY,
    COUPON_NAME VARCHAR(50) NOT NULL,
    DISCOUNT_AMOUNT INT NOT NULL,
    VALID_DAYS INT NOT NULL,
    USE_CONDITION VARCHAR(100),
    IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
);

-- 리뷰 테이블 생성(CREATE TABLE review)
CREATE TABLE review(
    review_id int PRIMARY KEY AUTO_INCREMENT
    , content text NOT NULL
    , regdate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
    , status varchar(10) NOT NULL CHECK(status in('활성', '숨김'))
    , user_id int NOT NULL
    , order_detail_id int NOT NULL
    , CONSTRAINT fk_review_user_id
        FOREIGN KEY (user_id)
        REFERENCES user(user_id)
    , CONSTRAINT fk_review_order_detail_id
        FOREIGN KEY (order_detail_id)
        REFERENCES order_detail(order_detail_id)
);

-- 리뷰 이미지 테이블 생성(CREATE TABLE REVIEW_IMG)
-- 리뷰 이미지는 더미데이터 생성하지 않았음
CREATE TABLE REVIEW_IMG(
    REVIEW_IMG_ID INT PRIMARY KEY AUTO_INCREMENT
    , FILENAME VARCHAR(200) NOT NULL
    , REVIEW_ID INT NOT NULL
    , CONSTRAINT FK_REVIEW_IMG_REVIEW_ID
        FOREIGN KEY (REVIEW_ID)
        REFERENCES REVIEW(REVIEW_ID)
);

-- 등급 쿠폰 테이블 (변경 없음)(CREATE TABLE GRADE_COUPON)
CREATE TABLE GRADE_COUPON (
    GRADE_COUPON_ID INT AUTO_INCREMENT PRIMARY KEY
    , USER_GRADE_ID INT NOT NULL
    , COUPON_ID INT NOT NULL
    , ISSUE_RULE VARCHAR(100)
    , IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE
    , CONSTRAINT FK_GRADE_COUPON_USER_GRADE_ID
        FOREIGN KEY (USER_GRADE_ID)
        REFERENCES USER_GRADE(USER_GRADE_ID)
    , CONSTRAINT FK_GRADE_COUPON_COUPON_ID
        FOREIGN KEY (COUPON_ID)
        REFERENCES COUPON(COUPON_ID)
);


-- 토스 결제 정보 테이블
CREATE TABLE toss_payment (
    payment_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_receipt_id int NOT NULL UNIQUE,
    toss_order_id VARCHAR(255) NOT NULL,
    toss_payment_key VARCHAR(255) NOT NULL UNIQUE,
    toss_payment_method VARCHAR(255) NOT NULL,
    toss_payment_status VARCHAR(255) NOT NULL,
    total_amount BIGINT NOT NULL,
    approved_at DATETIME(6) DEFAULT NULL,
    requested_at DATETIME(6) NOT NULL,
    CONSTRAINT fk_order_receipt_id FOREIGN KEY (order_receipt_id) REFERENCES order_receipt(order_receipt_id)
);


-- ------인서트시작-------------------------------------------------

-- 사이즈 테이블 인서트 (INSERT INTO SIZE)
INSERT INTO SIZE (SIZE_NAME) VALUES ('5.5인치');
INSERT INTO SIZE (SIZE_NAME) VALUES ('6.1인치');
INSERT INTO SIZE (SIZE_NAME) VALUES ('6.7인치');
INSERT INTO SIZE (SIZE_NAME) VALUES ('10.2인치');
INSERT INTO SIZE (SIZE_NAME) VALUES ('13.3인치');

-- 색상 테이블 인서트 (INSERT INTO COLOR)
INSERT INTO COLOR (COLOR_NAME) VALUES ('RED');
INSERT INTO COLOR (COLOR_NAME) VALUES ('BLUE');
INSERT INTO COLOR (COLOR_NAME) VALUES ('GREEN');
INSERT INTO COLOR (COLOR_NAME) VALUES ('BLACK');
INSERT INTO COLOR (COLOR_NAME) VALUES ('WHITE');

-- 용량 테이블 인서트 (INSERT INTO CAPACITY)
INSERT INTO CAPACITY (CAPACITY_NAME) VALUES ('16GB');
INSERT INTO CAPACITY (CAPACITY_NAME) VALUES ('32GB');
INSERT INTO CAPACITY (CAPACITY_NAME) VALUES ('64GB');
INSERT INTO CAPACITY (CAPACITY_NAME) VALUES ('128GB');
INSERT INTO CAPACITY (CAPACITY_NAME) VALUES ('256GB');

-- 제품 각인 테이블 인서트(INSERT INTO PRODUCT_ENGRAVING)
INSERT INTO PRODUCT_ENGRAVING (ENGRAVING_PRICE, ENGRAVING_TEXT)
VALUES
   (1000, '각인입니다1'),
   (1500, '각인입니다2'),
   (2000, '각인입니다3'),
   (2500, '각인입니다4'),
   (3000, '각인입니다5');

-- 제품 상위 카테고리 테이블 인서트(INSERT INTO PRODUCT_TOPCATEGORY)
INSERT INTO PRODUCT_TOPCATEGORY (PRODUCT_TOPCATEGORY_NAME, IS_ACTIVE)
VALUES
   ('pPhone', true),
   ('pPad', true),
   ('pMac', true),
   ('accessory', true);

-- SNSPROVIDER 테이블 인서트(INSERT INTO SNS_PROVIDER)
INSERT INTO SNS_PROVIDER(PROVIDER_NAME) VALUES('GOOGLE');
INSERT INTO SNS_PROVIDER(PROVIDER_NAME) VALUES('NAVER');
INSERT INTO SNS_PROVIDER(PROVIDER_NAME) VALUES('KAKAO');

-- 회원 등급 테이블 인서트(INSERT INTO USER_GRADE)
INSERT INTO USER_GRADE (USER_GRADE_NAME, DISCOUNT_RATE, CRITERIA_AMOUNT)
VALUES 
   ('Bronze', 0.00, 0),
   ('Silver', 2.00, 100000),
   ('Gold', 5.00, 300000),
   ('Platinum', 10.00, 700000);
INSERT INTO user_grade (user_grade_name, discount_rate, criteria_amount, is_active)
VALUES
   ('zz', 12.00, 9999, false);

-- 관리자 테이블 인서트 (INSERT INTO ADMIN)
INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('SUPER@ADMIN.COM', 'SUPERPASS123', '김수현', 'SUPER');

INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('ADMIN1@EXAMPLE.COM', 'ADMINPASS1', '이정민', 'ADMIN');

INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('ADMIN2@EXAMPLE.COM', 'ADMINPASS2', '박지은', 'ADMIN');

INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('ADMIN3@EXAMPLE.COM', 'ADMINPASS3', '최민석', 'ADMIN');

INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('ADMIN4@EXAMPLE.COM', 'ADMINPASS4', '정다은', 'ADMIN');

INSERT INTO ADMIN (EMAIL, PASSWORD, ADMIN_NAME, ROLE)
VALUES ('ADMIN5@EXAMPLE.COM', 'ADMINPASS5', '오세훈', 'ADMIN');

-- 쿠폰 테이블 인서트(INSERT INTO COUPON)
INSERT INTO COUPON (COUPON_NAME, DISCOUNT_AMOUNT, VALID_DAYS, USE_CONDITION)
VALUES 
  ('WELCOME10', 10000, 30, '신규 가입 시 사용 가능'),
  ('OVER100K', 15000, 15, '10만원 이상 구매 시'),
  ('LOYALTY20', 20000, 20, 'GOLD 등급 전용'),
  ('SUPERPLATINUM', 30000, 10, 'PLATINUM 등급 전용');

-- 제품 서브카테고리 테이블 인서트(INSERT INTO PRODUCT_SUBPCATEGORY)
INSERT INTO PRODUCT_SUBCATEGORY (PRODUCT_SUBCATEGORY_NAME, PRODUCT_TOPCATEGORY_ID)
VALUES
   ('14시리즈', 1), ('15시리즈', 1), ('16시리즈', 1),
   ('Air', 2), ('Mini', 2), ('Pro', 2),
   ('노트북', 3), ('데스크탑', 3), ('디스플레이', 3),
   ('MagSafe 충전기', 4), ('실리콘 케이스', 4), ('스마트 키보드 폴리오', 4),('에어팟', 4);

   
-- 회원 테이블 인서트(INSERT INTO user)
-- 나중에 금액이랑 묶으면 user_grade_id는 default로만 insert할것
INSERT INTO user (id, email, salt, hashedpassword, user_name, tel, address, user_grade_id, sns_provider_id)
VALUES 
	('user01', 'user01@example.com', 'Z9Lt1yJH', 'a7ac998258a4bc8e74e0f693c7d07b3721d1b1c51a1c586af2577d558acdb45f', '홍길동', '010-1234-0001', '서울시 강남구', 1, NULL),
	('user02', 'user02@example.com', 'PlkM5sAv', 'f6499cf282165ad79395cf3843172db3999f36ce215b5090d1ed7a4e14f842bb', '김영희', '010-1234-0002', '서울시 서초구', 2, NULL),
	('user03', 'user03@example.com', 's8Xe4FVr', '67f52f14f6f9fd02923b94a5182635b38e80229f2dfb95e9f1c4a4bcd9aeaad3', '박철수', '010-1234-0003', '서울시 송파구', 3, NULL),
	('user04', 'user04@example.com', 'YwBq9rLd', '87e716f703264b617b911338bd77499a3c53d0f7d6cf1e2f00c73c6408c31002', '이민호', '010-1234-0004', '서울시 강서구', 4, NULL),
	('user05', 'user05@example.com', NULL, NULL, '최지우', '010-1234-0005', '서울시 양천구', 1, 1),
	('user06', 'user06@example.com', NULL, NULL, '정해인', '010-1234-0006', '서울시 노원구', 2, 2),
	('user07', 'user07@example.com', NULL, NULL, '한지민', '010-1234-0007', '서울시 도봉구', 3, 3),
	('user08', 'user08@example.com', NULL, NULL, '서강준', '010-1234-0008', '서울시 성동구', 4, 1),
	('user09', 'user09@example.com', NULL, NULL, '김소현', '010-1234-0009', '서울시 마포구', 1, 2),
	('user10', 'user10@example.com', NULL, NULL, '이성경', '010-1234-0010', '서울시 은평구', 2, 3),
	('user11', 'user11@example.com', 'Tsdg6W0o', '4f59b274153f7e4e3c1d558f2ae3c2bb3f6dfe0fe37b4b43f9ab18611750fd8f', '조인성', '010-1234-0011', '서울시 구로구', 3, NULL),
	('user12', 'user12@example.com', 'Xv0cQ97N', 'd7f3bc3dfb1e82a6df62a63fa99f49b49173386d7f3e6f2e2f573b0dfac0cb44', '배수지', '010-1234-0012', '서울시 금천구', 4, NULL),
	('user13', 'user13@example.com', NULL, NULL, '윤아', '010-1234-0013', '서울시 중랑구', 1, 2),
	('user14', 'user14@example.com', NULL, NULL, '김태리', '010-1234-0014', '서울시 동작구', 2, 3),
	('user15', 'user15@example.com', NULL, NULL, '이준기', '010-1234-0015', '서울시 강북구', 3, 1);

-- 등급 쿠폰 테이블 인서트(INSERT INTO GRADE_COUPON)
INSERT INTO GRADE_COUPON (USER_GRADE_ID, COUPON_ID, ISSUE_RULE)
VALUES 
  (1, 1, '가입 시 자동 발급'),
  (2, 2, 'SILVER 등급 도달 시 발급'),
  (3, 3, 'GOLD 등급 도달 시 발급'),
  (4, 4, 'PLATINUM 등급 도달 시 발급');

-- 제품 테이블 인서트(INSERT INTO PRODUCT)
INSERT INTO PRODUCT (PRODUCT_CODE, PRODUCT_NAME, PRICE, INTRODUCE, DETAIL, PRODUCT_SUBCATEGORY_ID)
VALUES
   ('P14P-BLK', 'pPhone 14 Pro 블랙', 1350000, '고성능 스마트폰', '6.1인치 디스플레이 / A16 Bionic', 1),
   ('P15-WHT', 'pPhone 15 화이트', 1250000, '차세대 아이폰', '6.1인치 / USB-C / 다이나믹 아일랜드', 2),
   ('PSE3-RED', 'pPhone SE 3 레드', 650000, '보급형 아이폰', '4.7인치 / Touch ID / A15 Bionic', 3),
   
   ('PAIR5-GRY', 'pPad Air 5 스페이스 그레이', 850000, 'M1 칩 탑재 태블릿', '10.9인치 / Apple Pencil 2 지원', 4),
   ('PMINI6-PNK', 'pPad Mini 6 핑크', 770000, '컴팩트 태블릿', '8.3인치 / USB-C 포트', 5),
   ('PPRO-M2', 'pPad Pro M2 11인치', 1150000, '최상위 태블릿', 'M2 / 120Hz ProMotion 디스플레이', 6),
   
   ('PMAC-M1', 'pMac M1 13인치', 1290000, '애플 실리콘 최초 모델', 'M1 / Retina 디스플레이 / 8GB RAM', 7),
   ('PMAC-M2P', 'pMac M2 Pro 14인치', 1990000, '고성능 노트북', 'M2 Pro / Liquid Retina XDR', 8),
   ('PSTUDIO-MAX', 'pMac Studio Max', 2790000, '프로급 데스크탑', 'M1 Max / 고성능 포트 구성', 9),
   
   
   ('MAG-CHRGR', 'MagSafe 무선 충전기', 49000, '자석식 무선 충전', '아이폰 & 에어팟 지원', 10),
   ('CASE-BLUE', '실리콘 케이스 블루', 45000, '아이폰 보호 케이스', '부드러운 터치 / 내구성', 11),
   ('KEYBOARD-FOLIO', '스마트 키보드 폴리오', 219000, '아이패드 키보드', '자석 부착식 / 한국어 배열', 12);

-- 장바구니 테이블 인서트(INSERT INTO CART)
INSERT INTO CART (USER_ID) VALUES (1);
INSERT INTO CART (USER_ID) VALUES (2);
INSERT INTO CART (USER_ID) VALUES (3);
INSERT INTO CART (USER_ID) VALUES (4);
INSERT INTO CART (USER_ID) VALUES (5);
INSERT INTO CART (USER_ID) VALUES (6);
INSERT INTO CART (USER_ID) VALUES (7);
INSERT INTO CART (USER_ID) VALUES (8);
INSERT INTO CART (USER_ID) VALUES (9);
INSERT INTO CART (USER_ID) VALUES (10);
INSERT INTO CART (USER_ID) VALUES (11);
INSERT INTO CART (USER_ID) VALUES (12);
INSERT INTO CART (USER_ID) VALUES (13);
INSERT INTO CART (USER_ID) VALUES (14);
INSERT INTO CART (USER_ID) VALUES (15);

-- 문의 테이블 인서트(INSERT INTO INQUIRY)
-- UPDATE시 CURRENT TIME 찍히게 했으므로 UPDATE문 포함한 INSERT
INSERT INTO INQUIRY (TITLE, INQUIRY_TEXT, USER_ID) 
VALUES ('배송 문의', '언제 배송되나요?', 1);

INSERT INTO INQUIRY (TITLE, INQUIRY_TEXT, USER_ID) 
VALUES ('색상 변경 가능한가요?', 'RED 색상으로 변경 가능한가요?', 2);

INSERT INTO INQUIRY (TITLE, INQUIRY_TEXT, USER_ID) 
VALUES ('각인 추가 문의', '각인 문구 추가 가능한가요?', 3);

INSERT INTO INQUIRY (TITLE, INQUIRY_TEXT, USER_ID) 
VALUES ('제품 설명이 부족해요', '상세 페이지에 사이즈 정보가 부족해요.', 4);

INSERT INTO INQUIRY (TITLE, INQUIRY_TEXT, USER_ID) 
VALUES ('환불 문의', '개봉하지 않았는데 환불 가능할까요?', 5);

UPDATE INQUIRY
SET ANSWER_TEXT = '변경 가능합니다.', ANSWERED_AT = CURRENT_TIMESTAMP, ADMIN_ID = 1
WHERE INQUIRY_ID = 2;

UPDATE INQUIRY
SET ANSWER_TEXT = '네, 주문 전에 추가 가능합니다.', ANSWERED_AT = CURRENT_TIMESTAMP, ADMIN_ID = 2
WHERE INQUIRY_ID = 3;

UPDATE INQUIRY
SET ANSWER_TEXT = '가능합니다. 고객센터로 문의주세요.', ANSWERED_AT = CURRENT_TIMESTAMP, ADMIN_ID = 1
WHERE INQUIRY_ID = 5;

-- 제품 사이즈 테이블 인서트(INSERT INTO PRODUCT_SIZE)
INSERT INTO PRODUCT_SIZE (ADDITIONAL_PRICE, SIZE_ID, PRODUCT_ID)
VALUES
    (0, 2, 1),
    (1000, 2, 2),
    (0, 1, 3),
    (1500, 4, 4),
    (0, 4, 5),
    (2000, 5, 6),
    (0, 3, 7),
    (0, 3, 8),
    (1000, 5, 9),
    (0, 5, 10),
    (0, 2, 11),
    (500, 1, 12);

-- 제품 색상 테이블 인서트(INSERT INTO PRODUCT_COLOR)
INSERT INTO PRODUCT_COLOR (COLOR_ID, PRODUCT_ID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (1, 6),
    (2, 7),
    (3, 8),
    (4, 9),
    (5, 10),
    (1, 11),
    (2, 12);


-- 제품 용량 테이블 인서트(INSERT INTO PRODUCT_CAPACITY)
INSERT INTO PRODUCT_CAPACITY (ADDITIONAL_PRICE, CAPACITY_ID, PRODUCT_ID)
VALUES
    (0, 1, 1),
    (10000, 2, 2),
    (20000, 3, 3),
    (30000, 4, 4),
    (40000, 5, 5),
    (0, 1, 6),
    (15000, 2, 7),
    (25000, 3, 8),
    (35000, 4, 9);

-- 제품 이미지 테이블 인서트(INSERT INTO PRODUCT_IMG)
-- =========인서트 없음

-- 스냅샷 테이블 인서트(INSERT INTO SNAPSHOT)
INSERT INTO SNAPSHOT (PRODUCT_ID, PRODUCT_NAME, PRICE, SIZE, CAPACITY, COLOR, ENGRAVING, FILENAME)
VALUES
    (1, 'PPHONE 14 PRO 블랙', 1350000, '6.1인치', '128GB', 'BLACK', '각인입니다1', 'A7F3XBQ9'),
    (2, 'PPHONE 15 화이트', 1250000, '6.1인치', '128GB', 'GREEN', NULL, 'R9TLM2QC'),
    (3, 'PPHONE SE 3 레드', 650000, '4.7인치', '64GB', 'BLACK', '각인입니다2', 'ZT8WKM2Q'),

    (4, 'PPAD AIR 5 스페이스 그레이', 850000, '10.9인치', '256GB', 'RED', NULL, 'NP6UD8XR'),
    (5, 'PPAD MINI 6 핑크', 770000, '8.3인치', '256GB', 'RED', '각인입니다3', 'PQ1SLE8N'),

    (6, 'PMAC M1 13인치', 1290000, '13인치', '128GB', 'BLACK', NULL, 'TZ3MXV7W'),

    (10, 'MAGSAFE 무선 충전기', 49000, NULL, NULL, 'WHITE', '각인입니다5', 'HJ7ER5YC'),
    (12, '스마트 키보드 폴리오', 219000, NULL, NULL, 'GREEN', NULL, 'KW9TB4VZ');


-- 문의 이미지 테이블 인서트(INSERT INTO INQUIRY_IMG)
-- =========인서트 없음

-- 주문내역 테이블 인서트(INSERT INTO ORDER_RECEIPT)
INSERT INTO ORDER_RECEIPT (ORDER_STATUS, USER_ID)
VALUES
   ('상품 준비 전', 1),
   ('상품 준비 중', 3),
   ('발송완료', 5),
   ('상품 준비 전', 7),
   ('상품 준비 중', 9),
   ('발송완료', 2),
   ('상품 준비 전', 4);

-- 제품 커스텀 옵션 테이블 인서트(INSERT INTO CUSTOM_OPTION)
INSERT INTO CUSTOM_OPTION (PRODUCT_SIZE_ID, PRODUCT_COLOR_ID, PRODUCT_CAPACITY_ID, PRODUCT_ENGRAVING_ID)
VALUES
    (1, 1, 1, 1),
    (2, 2, 2, NULL),
    (3, 3, 3, 2),
    (4, 4, 4, NULL),
    (5, 5, 5, 3);

-- 주문상세 테이블 인서트(INSERT INTO ORDER_DETAIL)
INSERT INTO ORDER_DETAIL (ORDER_QUANTITY, ORDER_RECEIPT_ID, SNAPSHOT_ID)
VALUES
   (2, 1, 1),
   (1, 1, 2),
   (3, 2, 3),
   (1, 3, 4),
   (2, 3, 5),
   (1, 4, 6),
   (1, 5, 7),
   (2, 5, 8);
   

-- 장바구니 제품 테이블 인서트(INSERT INTO CART_ITEM)
INSERT INTO CART_ITEM (CART_ID, PRODUCT_ID, CUSTOM_OPTION_ID)
VALUES
    (1, 7, NULL),
    (2, 3, NULL),
    (4, 1, NULL),
    (5, 11, NULL),
    (6, 9, 2),
    (7, 2, NULL),
    (9, 7, NULL),
    (10, 6, 3),
    (11, 4, 4),
    (13, 5, NULL),
    (14, 8, NULL),
    (15, 12, NULL);

INSERT INTO CART_ITEM (CART_ID, PRODUCT_ID, CUSTOM_OPTION_ID)
VALUES  (16, 6, NULL);
select * from cart_item;
select * from custom_option;
select * from product_size;
select * from user;
select * from cart;

-- 리뷰 테이블 인서트 (INSERT INTO review)
INSERT INTO review (content, status, user_id, order_detail_id)
VALUES
    ('정말 마음에 들어요! 배송도 빨랐어요.', '활성', 2, 4),
    ('상품이 설명과 같고 만족스러워요.', '활성', 3, 5),
    ('가성비 최고네요. 다음에도 구매할게요!', '활성', 4, 5);

INSERT INTO review (content, status, user_id, order_detail_id)
VALUES
    ('정말 마음에 들어요! 배송도 빨랐어요.', '활성', 2, 6),
    ('상품이 설명과 같고 만족스러워요.', '활성', 3, 6),
    ('가성비 최고네요. 다음에도 구매할게요!', '활성', 4, 6);
    
-- 리뷰 이미지 테이블 인서트(INSERT INTO INQUIRY_IMG)
-- =========인서트 없음
SHOW TABLES;

 SELECT
	        r.review_id,
	        r.content,
	        r.regdate,
	        r.status,
	        u.user_id AS user_id,
	        u.id AS id,
	        u.email AS email,
	        u.user_name AS user_name,
	        ug.user_grade_id AS userGradeId,
	        ug.user_grade_name AS userGradeName,
	        od.order_detail_id AS orderDetailId,
	        s.snapshot_id AS snapshotId,
	        s.product_id AS product_id,
	        s.product_name AS product_name,
	        s.price AS price,
	        s.size AS size,
	        s.capacity AS capacity,
	        s.color AS color,
	        s.engraving AS engraving
	    FROM review r
	    JOIN user u 
	        ON r.user_id = u.user_id
	    JOIN user_grade ug 
	        ON u.user_grade_id = ug.user_grade_id
	    JOIN order_detail od 
	        ON r.order_detail_id = od.order_detail_id
	    JOIN snapshot s
	        ON od.snapshot_id = s.snapshot_id
	    WHERE s.product_id=4;


select * from user;

INSERT INTO order_receipt (order_status, user_id)
VALUES  ('상품 준비 전', 16),
 ('상품 준비 중', 16),
('발송완료', 16),
 ('상품 준비 중', 16),
('발송완료', 16);


INSERT INTO product (product_code, product_name, price, introduce, detail, product_subcategory_id)
VALUES
   ('P14P-BLK', 'pPhone 14 Pro 블랙', 1350000, '고성능 스마트폰', '6.1인치 디스플레이 / A16 Bionic', 1),
   ('P15-WHT', 'pPhone 15 화이트', 1250000, '차세대 아이폰', '6.1인치 / USB-C / 다이나믹 아일랜드', 2),
   ('PSE3-RED', 'pPhone SE 3 레드', 650000, '보급형 아이폰', '4.7인치 / Touch ID / A15 Bionic', 3),
    ('PAIR5-GRY', 'pPad Air 5 스페이스 그레이', 850000, 'M1 칩 탑재 태블릿', '10.9인치 / Apple Pencil 2 지원', 4),
   ('PMINI6-PNK', 'pPad Mini 6 핑크', 770000, '컴팩트 태블릿', '8.3인치 / USB-C 포트', 5);


INSERT INTO snapshot (product_id, product_name, price, size, capacity, color, engraving, filename)
VALUES
    (13, 'pPhone 14 Pro 블랙', 1350000, '6.1인치', '128GB', 'Black', '각 인입니다1', '1753859785461.webp'),
    (14, 'pPhone 15 화이트', 1250000, '6.1인치', '128GB', 'Green', '각인 이므묘', '1753864719575.jpeg'),
    (15, 'pPhone SE 3 레드', 650000, '4.7인치', '64GB', 'Black', '각인입 니다2', '1753959155216.webp'),
    (16, 'pPad Air 5 스페이스 그레이', 850000, '10.9인치', '256GB', 'Red', '각인이므니다', '1753859785461.webp'),
    (17, 'pPad Mini 6 핑크', 770000, '8.3인치', '256GB', 'Red', '각인입니다3', '1753859785475.webp'),
    (14, 'pPhone 15 화이트', 1250000, '6.1인치', '128GB', 'Green', '각인 이므묘', '1753864719575.jpeg'),
    (15, 'pPhone SE 3 레드', 650000, '4.7인치', '64GB', 'Black', '각인입 니다2', '1753959155216.webp');


SELECT * FROM order_receipt ore JOIN order_detail od   ON ore.order_receipt_id = od.order_receipt_id WHERE ore.user_id = 16;

select * from snapshot;
select * from order_detail;
select * from product;
select * from cart;
select * from cart_item;

select * from review;





INSERT INTO order_detail (order_quantity, order_receipt_id, snapshot_id)
VALUES
   (2, 2, 9),
   (1, 8, 10),
   (3, 8, 11),
   (1, 9, 12),
   (2, 11, 13),
   (1, 10, 14),
   (2, 12, 15);


