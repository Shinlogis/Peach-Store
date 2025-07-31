USE electronicmall;

-- 부모부터 순서로 delete 되도록 순서 맞춰서 수정 해주세요
-- CREATE INSERT 전부 DROP순서랑 맞추어 놓았으니 찾을 일 있으면 참고하세요

DROP TABLE IF EXISTS review_img; -- 리뷰 이미지
DROP TABLE IF EXISTS review; -- 리뷰
DROP TABLE IF EXISTS order_detail; -- 주문상세
DROP TABLE IF EXISTS cart_item; -- 장바구니 제품
DROP TABLE IF EXISTS custom_option; -- 제품 커스텀
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

-- 회원 등급 테이블 생성 (조건 기준 추가)(CREATE TABLE user_grade)
CREATE TABLE user_grade (
    user_grade_id INT AUTO_INCREMENT PRIMARY KEY,
    user_grade_name VARCHAR(50) NOT NULL,
    discount_rate DECIMAL(5,2) NOT NULL,
    criteria_amount INT NOT NULL, -- 등급 부여 기준 금액 예: 누적 구매금액
    is_active boolean NOT NULL DEFAULT TRUE
);

-- 회원 테이블 생성(CREATE TABLE user)
CREATE TABLE user(
	user_id int PRIMARY KEY AUTO_INCREMENT
    , id varchar(100) NOT NULL UNIQUE
	, email varchar(100) UNIQUE
	, password varchar(100) 
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

-- 장바구니 테이블 생성(CREATE TABLE cart)
CREATE TABLE cart(
    cart_id int PRIMARY KEY AUTO_INCREMENT
    , user_id int NOT NULL UNIQUE
    , CONSTRAINT fk_cart_user_id
        FOREIGN KEY (user_id)
        REFERENCES user(user_id)
);

-- 문의 테이블 생성(CREATE TABLE inquiry)
CREATE TABLE inquiry(
    inquiry_id int PRIMARY KEY AUTO_INCREMENT
    , title varchar(100) NOT NULL
    , inquiry_text varchar(200) NOT NULL
    , created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
    , answer_text varchar(200) 
    , answered_at TIMESTAMP DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
    , is_active boolean NOT NULL DEFAULT TRUE
    , user_id int NOT NULL
    , admin_id int
    , CONSTRAINT fk_inquiry_user_id
        FOREIGN KEY (user_id)
        REFERENCES user(user_id)
    , CONSTRAINT fk_inquiry_admin_id
        FOREIGN KEY (admin_id)
        REFERENCES admin(admin_id)
);

-- 문의 이미지 테이블 생성(CREATE TABLE inquiry_img)
-- 문의 이미지는 더미데이터 생성하지 않았음
CREATE TABLE inquiry_img(
    inquiry_img_id int PRIMARY KEY AUTO_INCREMENT
    , filename varchar(100) NOT NULL
    , inquiry_id int NOT NULL
    , CONSTRAINT fk_inquiry_img_inquiry_id
        FOREIGN KEY (inquiry_id)
        REFERENCES inquiry(inquiry_id)
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

-- 제품 상위 카테고리 테이블 생성(CREATE TABLE product_topcategory)
CREATE TABLE product_topcategory(
	product_topcategory_id int PRIMARY KEY AUTO_INCREMENT
	, product_topcategory_name varchar(100) NOT NULL
	, fileDirName varchar(30) DEFAULT NULL
    , filename varchar(30)
	, is_active boolean NOT NULL DEFAULT TRUE
);

-- 제품 하위 카테고리 테이블 생성(CREATE TABLE product_subcategory)
CREATE TABLE product_subcategory(
	product_subcategory_id int PRIMARY KEY AUTO_INCREMENT
	, product_subcategory_name varchar(100) NOT NULL
	, product_topcategory_id int NOT NULL
    , fileDirName varchar(30) DEFAULT NULL
    , filename varchar(30)
    , is_active boolean NOT NULL DEFAULT TRUE
	, CONSTRAINT fk_product_topcategory_id
		FOREIGN KEY (product_topcategory_id)
		REFERENCES product_topcategory(product_topcategory_id)
);

-- 제품 테이블 생성(CREATE TABLE product)
CREATE TABLE product(
	product_id int PRIMARY KEY AUTO_INCREMENT
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

-- 제품 사이즈 테이블 생성(CREATE TABLE product_size)
CREATE TABLE product_size(
    product_size_id int PRIMARY KEY AUTO_INCREMENT
    , additional_price int NOT NULL DEFAULT 0
    , size_id int NOT NULL
    , product_id int NOT NULL
    , CONSTRAINT fk_product_size_size_id
        FOREIGN KEY (size_id)
        REFERENCES size(size_id)
    , CONSTRAINT fk_product_size_product_id
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

-- 제품 색상 테이블 생성(CREATE TABLE product_color)
CREATE TABLE product_color(
    product_color_id int PRIMARY KEY AUTO_INCREMENT
    , color_id int NOT NULL
    , product_id int NOT NULL
    , CONSTRAINT fk_product_color_color_id
        FOREIGN KEY (color_id)
        REFERENCES color(color_id)
    , CONSTRAINT fk_product_color_product_id
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

-- 제품 용량 테이블 생성(CREATE TABLE product_capacity)
CREATE TABLE product_capacity(
    product_capacity_id int PRIMARY KEY AUTO_INCREMENT
    , additional_price int NOT NULL DEFAULT 0
    , capacity_id int NOT NULL
    , product_id int NOT NULL
    , CONSTRAINT fk_product_capacity_capacity_id
        FOREIGN KEY (capacity_id)
        REFERENCES capacity(capacity_id)
    , CONSTRAINT fk_product_capacity_product_id
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

-- 제품 이미지 테이블 생성(CREATE TABLE product_img)
-- 제품 이미지는 더미데이터 생성하지 않았음
CREATE TABLE product_img(
    product_img_id int PRIMARY KEY AUTO_INCREMENT
    , filename varchar(30) NOT NULL
    , product_id int NOT NULL
    , CONSTRAINT fk_product_img_product_id
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
);

-- 제품 커스텀 옵션 테이블 생성(CREATE TABLE custom_option)
CREATE TABLE custom_option(
    custom_option_id int PRIMARY KEY AUTO_INCREMENT
    , product_size_id int NOT NULL
    , product_color_id int NOT NULL
    , product_capacity_id int NOT NULL
    , product_engraving_id int
    , CONSTRAINT fk_custom_option_product_size_id
        FOREIGN KEY (product_size_id)
        REFERENCES product_size(product_size_id)
    , CONSTRAINT fk_custom_option_product_color_id
        FOREIGN KEY (product_color_id)
        REFERENCES product_color(product_color_id)
    , CONSTRAINT fk_custom_option_product_capacity_id
        FOREIGN KEY (product_capacity_id)
        REFERENCES product_capacity(product_capacity_id)
    , CONSTRAINT fk_custom_option_product_engraving_id
        FOREIGN KEY (product_engraving_id)
        REFERENCES product_engraving(product_engraving_id)
);

-- 장바구니 제품 테이블 생성(CREATE TABLE cart_item)
CREATE TABLE cart_item(
    cart_item_id int PRIMARY KEY AUTO_INCREMENT
    , quantity int NOT NULL DEFAULT 1 CHECK(quantity >= 1)
    , cart_id int NOT NULL UNIQUE
    , product_id int NOT NULL
    , custom_option_id int
    , CONSTRAINT fk_cart_item_cart_id
        FOREIGN KEY (cart_id)
        REFERENCES cart(cart_id)
    , CONSTRAINT fk_cart_item_product_id
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
    , CONSTRAINT fk_cart_item_custom_option_id
        FOREIGN KEY (custom_option_id)
        REFERENCES custom_option(custom_option_id)
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
	, order_status varchar(10) NOT NULL DEFAULT '상품 준비 전' CHECK(order_status IN ('상품 준비 전', '상품 준비 중', '발송완료'))
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

-- 쿠폰 테이블 생성 (변경 없음)(CREATE TABLE coupon)
CREATE TABLE coupon (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,
    coupon_name VARCHAR(50) NOT NULL,
    discount_amount INT NOT NULL,
    valid_days INT NOT NULL,
    use_condition VARCHAR(100),
    is_active boolean NOT NULL DEFAULT TRUE
);

-- 리뷰 테이블 생성(CREATE TABLE review)
CREATE TABLE review(
    review_id int PRIMARY KEY AUTO_INCREMENT
    , context text NOT NULL
    , regdate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
    , status varchar(10) NOT NULL CHECK(status in('활성', '비활성'))
    , user_id int NOT NULL
    , order_detail_id int NOT NULL
    , CONSTRAINT fk_review_user_id
        FOREIGN KEY (user_id)
        REFERENCES user(user_id)
    , CONSTRAINT fk_review_order_detail_id
        FOREIGN KEY (order_detail_id)
        REFERENCES order_detail(order_detail_id)
);

-- 리뷰 이미지 테이블 생성(CREATE TABLE review_img)
-- 리뷰 이미지는 더미데이터 생성하지 않았음
CREATE TABLE review_img(
    review_img_id int PRIMARY KEY AUTO_INCREMENT
    , filename varchar(200) NOT NULL
    , review_id int NOT NULL
    , CONSTRAINT fk_review_img_review_id
        FOREIGN KEY (review_id)
        REFERENCES review(review_id)
);

-- 등급 쿠폰 테이블 (변경 없음)(CREATE TABLE grade_coupon)
CREATE TABLE grade_coupon (
    grade_coupon_id INT AUTO_INCREMENT PRIMARY KEY
    , user_grade_id INT NOT NULL
    , coupon_id INT NOT NULL
    , issue_rule VARCHAR(100)
    , is_active boolean NOT NULL DEFAULT TRUE
    , CONSTRAINT fk_grade_coupon_user_grade_id
        FOREIGN KEY (user_grade_id)
        REFERENCES user_grade(user_grade_id)
    , CONSTRAINT fk_grade_coupon_coupon_id
        FOREIGN KEY (coupon_id)
        REFERENCES coupon(coupon_id)
);

-- ------인서트시작-------------------------------------------------

-- 사이즈 테이블 인서트 (INSERT INTO size)
INSERT INTO size (size_name) VALUES ('5.5인치');
INSERT INTO size (size_name) VALUES ('6.1인치');
INSERT INTO size (size_name) VALUES ('6.7인치');
INSERT INTO size (size_name) VALUES ('10.2인치');
INSERT INTO size (size_name) VALUES ('13.3인치');

-- 색상 테이블 인서트 (INSERT INTO color)
INSERT INTO color (color_name) VALUES ('Red');
INSERT INTO color (color_name) VALUES ('Blue');
INSERT INTO color (color_name) VALUES ('Green');
INSERT INTO color (color_name) VALUES ('Black');
INSERT INTO color (color_name) VALUES ('White');

-- 용량 테이블 인서트 (INSERT INTO capacity)
INSERT INTO capacity (capacity_name) VALUES ('16GB');
INSERT INTO capacity (capacity_name) VALUES ('32GB');
INSERT INTO capacity (capacity_name) VALUES ('64GB');
INSERT INTO capacity (capacity_name) VALUES ('128GB');
INSERT INTO capacity (capacity_name) VALUES ('256GB');

-- 제품 각인 테이블 인서트(INSERT INTO product_engraving)
INSERT INTO product_engraving (engraving_price, engraving_text)
VALUES
	(1000, '각인입니다1'),
	(1500, '각인입니다2'),
	(2000, '각인입니다3'),
	(2500, '각인입니다4'),
	(3000, '각인입니다5');

-- 제품 상위 카테고리 테이블 인서트(INSERT INTO product_topcategory)
INSERT INTO product_topcategory (product_topcategory_name, is_active)
VALUES
	('pPhone', true),
	('pPad', true),
	('pMac', true),
	('accessory', true);

-- snsprovider 테이블 인서트(insert into sns_provider)
insert into sns_provider(provider_name) values('google');
insert into sns_provider(provider_name) values('naver');
insert into sns_provider(provider_name) values('kakao');

-- 회원 등급 테이블 인서트(INSERT INTO user_grade)
INSERT INTO user_grade (user_grade_name, discount_rate, criteria_amount)
VALUES 
	('Bronze', 0.00, 0),
	('Silver', 2.00, 100000),
	('Gold', 5.00, 300000),
	('Platinum', 10.00, 700000);
INSERT INTO user_grade (user_grade_name, discount_rate, criteria_amount, is_active)
VALUES
	('zz', 12.00, 9999, false);

-- 관리자 테이블 인서트 (INSERT INTO admin)
INSERT INTO admin (email, password, admin_name, role)
VALUES ('super@admin.com', 'superpass123', '김수현', 'super');

INSERT INTO admin (email, password, admin_name, role)
VALUES ('admin1@example.com', 'adminpass1', '이정민', 'admin');

INSERT INTO admin (email, password, admin_name, role)
VALUES ('admin2@example.com', 'adminpass2', '박지은', 'admin');

INSERT INTO admin (email, password, admin_name, role)
VALUES ('admin3@example.com', 'adminpass3', '최민석', 'admin');

INSERT INTO admin (email, password, admin_name, role)
VALUES ('admin4@example.com', 'adminpass4', '정다은', 'admin');

INSERT INTO admin (email, password, admin_name, role)
VALUES ('admin5@example.com', 'adminpass5', '오세훈', 'admin');

-- 쿠폰 테이블 인서트(INSERT INTO coupon)
INSERT INTO coupon (coupon_name, discount_amount, valid_days, use_condition)
VALUES 
  ('WELCOME10', 10000, 30, '신규 가입 시 사용 가능'),
  ('OVER100K', 15000, 15, '10만원 이상 구매 시'),
  ('LOYALTY20', 20000, 20, 'Gold 등급 전용'),
  ('SUPERPLATINUM', 30000, 10, 'Platinum 등급 전용');

-- 제품 서브카테고리 테이블 인서트(INSERT INTO product_subpcategory)
INSERT INTO product_subcategory (product_subcategory_name, product_topcategory_id)
VALUES
	('14시리즈', 1), ('15시리즈', 1), ('16시리즈', 1),
	('Air', 2), ('Mini', 2), ('Pro', 2),
	('노트북', 3), ('데스크탑', 3), ('디스플레이', 3),
	('MagSafe 충전기', 4), ('실리콘 케이스', 4), ('스마트 키보드 폴리오', 4),('에어팟', 4);

	
-- 회원 테이블 인서트(INSERT INTO user)
-- 나중에 금액이랑 묶으면 user_grade_id는 default로만 insert할것
INSERT INTO user (id, email, password, user_name, tel, address, user_grade_id, sns_provider_id)
VALUES 
    ('user01', 'user01@example.com', 'pass01', '홍길동', '010-1234-0001', '서울시 강남구', 1, NULL),
    ('user02', 'user02@example.com', 'pass02', '김영희', '010-1234-0002', '서울시 서초구', 2, NULL),
    ('user03', 'user03@example.com', 'pass03', '박철수', '010-1234-0003', '서울시 송파구', 3, NULL),
    ('user04', 'user04@example.com', 'pass04', '이민호', '010-1234-0004', '서울시 강서구', 4, NULL),
    ('user05', 'user05@example.com', NULL, '최지우', '010-1234-0005', '서울시 양천구', 1, 1),
    ('user06', 'user06@example.com', NULL, '정해인', '010-1234-0006', '서울시 노원구', 2, 2),
    ('user07', NULL, NULL, '한지민', '010-1234-0007', '서울시 도봉구', 3, 3),
    ('user08', 'user08@example.com', NULL, '서강준', '010-1234-0008', '서울시 성동구', 4, 1),
    ('user09', 'user09@example.com', NULL, '김소현', '010-1234-0009', '서울시 마포구', 1, 2),
    ('user10', NULL, NULL, '이성경', '010-1234-0010', '서울시 은평구', 2, 3),
    ('user11', 'user11@example.com', 'pass11', '조인성', '010-1234-0011', '서울시 구로구', 3, NULL),
    ('user12', 'user12@example.com', 'pass12', '배수지', '010-1234-0012', '서울시 금천구', 4, NULL),
    ('user13', 'user13@example.com', NULL, '윤아', '010-1234-0013', '서울시 중랑구', 1, 2),
    ('user14', NULL, NULL, '김태리', '010-1234-0014', '서울시 동작구', 2, 3),
    ('user15', 'user15@example.com', NULL, '이준기', '010-1234-0015', '서울시 강북구', 3, 1);

-- 등급 쿠폰 테이블 인서트(INSERT INTO grade_coupon)
INSERT INTO grade_coupon (user_grade_id, coupon_id, issue_rule)
VALUES 
  (1, 1, '가입 시 자동 발급'),
  (2, 2, 'Silver 등급 도달 시 발급'),
  (3, 3, 'Gold 등급 도달 시 발급'),
  (4, 4, 'Platinum 등급 도달 시 발급');

-- 제품 테이블 인서트(INSERT INTO product)
INSERT INTO product (product_code, product_name, price, introduce, detail, product_subcategory_id)
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

-- 장바구니 테이블 인서트(INSERT INTO cart)
INSERT INTO cart (user_id) VALUES (1);
INSERT INTO cart (user_id) VALUES (2);
INSERT INTO cart (user_id) VALUES (3);
INSERT INTO cart (user_id) VALUES (4);
INSERT INTO cart (user_id) VALUES (5);
INSERT INTO cart (user_id) VALUES (6);
INSERT INTO cart (user_id) VALUES (7);
INSERT INTO cart (user_id) VALUES (8);
INSERT INTO cart (user_id) VALUES (9);
INSERT INTO cart (user_id) VALUES (10);
INSERT INTO cart (user_id) VALUES (11);
INSERT INTO cart (user_id) VALUES (12);
INSERT INTO cart (user_id) VALUES (13);
INSERT INTO cart (user_id) VALUES (14);
INSERT INTO cart (user_id) VALUES (15);

-- 문의 테이블 인서트(INSERT INTO inquiry)
-- UPDATE시 CURRENT TIME 찍히게 했으므로 UPDATE문 포함한 INSERT
INSERT INTO inquiry (title, inquiry_text, user_id) 
VALUES ('배송 문의', '언제 배송되나요?', 1);

INSERT INTO inquiry (title, inquiry_text, user_id) 
VALUES ('색상 변경 가능한가요?', 'Red 색상으로 변경 가능한가요?', 2);

INSERT INTO inquiry (title, inquiry_text, user_id) 
VALUES ('각인 추가 문의', '각인 문구 추가 가능한가요?', 3);

INSERT INTO inquiry (title, inquiry_text, user_id) 
VALUES ('제품 설명이 부족해요', '상세 페이지에 사이즈 정보가 부족해요.', 4);

INSERT INTO inquiry (title, inquiry_text, user_id) 
VALUES ('환불 문의', '개봉하지 않았는데 환불 가능할까요?', 5);

UPDATE inquiry
SET answer_text = '변경 가능합니다.', answered_at = CURRENT_TIMESTAMP, admin_id = 1
WHERE inquiry_id = 2;

UPDATE inquiry
SET answer_text = '네, 주문 전에 추가 가능합니다.', answered_at = CURRENT_TIMESTAMP, admin_id = 2
WHERE inquiry_id = 3;

UPDATE inquiry
SET answer_text = '가능합니다. 고객센터로 문의주세요.', answered_at = CURRENT_TIMESTAMP, admin_id = 1
WHERE inquiry_id = 5;

-- 제품 사이즈 테이블 인서트(INSERT INTO product_size)
INSERT INTO product_size (additional_price, size_id, product_id)
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

-- 제품 색상 테이블 인서트(INSERT INTO product_color)
INSERT INTO product_color (color_id, product_id)
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


-- 제품 용량 테이블 인서트(INSERT INTO product_capacity)
INSERT INTO product_capacity (additional_price, capacity_id, product_id)
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

-- 제품 이미지 테이블 인서트(INSERT INTO product_img)
-- =========인서트 없음
-- 스냅샷 테이블 인서트(INSERT INTO snapshot)
-- 스냅샷 테이블 인서트(INSERT INTO snapshot)
INSERT INTO snapshot (product_id, product_name, price, size, capacity, color, engraving, filename)
VALUES
    (1, 'pPhone 14 Pro 블랙', 1350000, '6.1인치', '128GB', 'Black', '각인입니다1', 'a7F3xBq9'),
    (2, 'pPhone 15 화이트', 1250000, '6.1인치', '128GB', 'Green', NULL, 'R9tLm2Qc'),
    (3, 'pPhone SE 3 레드', 650000, '4.7인치', '64GB', 'Black', '각인입니다2', 'Zt8wKm2Q'),

    (4, 'pPad Air 5 스페이스 그레이', 850000, '10.9인치', '256GB', 'Red', NULL, 'Np6Ud8Xr'),
    (5, 'pPad Mini 6 핑크', 770000, '8.3인치', '256GB', 'Red', '각인입니다3', 'Pq1sLe8N'),

    (6, 'pMac M1 13인치', 1290000, '13인치', '128GB', 'Black', NULL, 'Tz3Mxv7W'),

    (10, 'MagSafe 무선 충전기', 49000, NULL, NULL, 'White', '각인입니다5', 'Hj7Er5Yc'),
    (12, '스마트 키보드 폴리오', 219000, NULL, NULL, 'Green', NULL, 'Kw9Tb4Vz');


-- 문의 이미지 테이블 인서트(INSERT INTO inquiry_img)
-- =========인서트 없음

-- 주문내역 테이블 인서트(INSERT INTO order_receipt)
INSERT INTO order_receipt (order_status, user_id)
VALUES
	('상품 준비 전', 1),
	('상품 준비 중', 3),
	('발송완료', 5),
	('상품 준비 전', 7),
	('상품 준비 중', 9),
	('발송완료', 2),
	('상품 준비 전', 4);

-- 제품 커스텀 옵션 테이블 인서트(INSERT INTO custom_option)
INSERT INTO custom_option (product_size_id, product_color_id, product_capacity_id, product_engraving_id)
VALUES
    (1, 1, 1, 1),
    (2, 2, 2, NULL),
    (3, 3, 3, 2),
    (4, 4, 4, NULL),
    (5, 5, 5, 3);

-- 주문상세 테이블 인서트(INSERT INTO order_detail)
INSERT INTO order_detail (order_quantity, order_receipt_id, snapshot_id)
VALUES
	(2, 1, 1),
	(1, 1, 2),
	(3, 2, 3),
	(1, 3, 4),
	(2, 3, 5),
	(1, 4, 6),
	(1, 5, 7),
	(2, 5, 8);
	

-- 장바구니 제품 테이블 인서트(INSERT INTO cart_item)
INSERT INTO cart_item (cart_id, product_id, custom_option_id)
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

-- 리뷰 테이블 인서트 (INSERT INTO review)
INSERT INTO review (context, status, user_id, order_detail_id)
VALUES
    ('정말 마음에 들어요! 배송도 빨랐어요.', '활성', 2, 4),
    ('상품이 설명과 같고 만족스러워요.', '활성', 3, 5),
    ('가성비 최고네요. 다음에도 구매할게요!', '활성', 4, 5);


-- 리뷰 이미지 테이블 인서트(INSERT INTO inquiry_img)
-- =========인서트 없음
show tables;