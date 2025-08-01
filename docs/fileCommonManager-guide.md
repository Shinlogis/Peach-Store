
# 공용 파일 매니저 가이드

### 이미지 업로드 및 DB 등록 흐름
1. 컨트롤러에서 업로드된 이미지 파일과 저장 경로 전달
2. 도메인 객체 DB 저장
3. `imageFileService.saveImage(photo, fileDirName, savePath);` 로 실제 파일 저장  
4. 반환된 `fileDirName`, `filename` 으로 도메인 객체 세팅  
5. DAO를 통해 DB 업데이트 → 실패 시 `fileManager.remove(...)` 로 이미지 삭제  

## 1. Mapper 세팅
insert에서  `useGeneratedKeys="true"`, `keyProperty="pk값"`을 추가하여 자동 생성된 PK를 productTopcategory 객체에 자동 세팅되도록 합니다.

예시:
```xml
<insert id="insert" parameterType="peachstore.domain.ProductTopcategory" useGeneratedKeys="true" keyProperty="productTopcategoryId">
		insert into product_topcategory(product_topcategory_name, fileDirName, filename) 
		values(#{productTopcategoryName}, #{fileDirName}, #{filename})
	</insert>
```


## 2. 서비스에 의존성 주입
서비스에서 `ImageFileService`, `FileCommonManager`의 의존성을 주입받습니다.

## 3. 서비스에서 도메인 DB에 저장
도메인을 저장 후, pk값을 추출합니다.

예시:
```java
productCategoryDAO.insert(productTopcategory); // 저장
int id = productTopcategory.getProductTopcategoryId(); // pk값 추출
```

## 4. 전체 이미지 저장
```java
// 이미지 저장
String fileDirName = "category_"+id;
Map<String, Object> result = imageFileService.saveImage(photo, fileDirName, savePath);
```
- photo: 업로드한 파일 (MultipartFile)
- fileDirName: 서브디렉토리 이름
- savePath: 실제 서버에 저장될 물리 경로 (예: /webapps/data). 컨트롤러에서 전달받습니다.<br>(`String savePath = request.getServletContext().getRealPath("/data");`)


리턴값(Map): 
```java
{
  "fileDirName": "category1234567890",   // 하위 폴더 이름
  "savedFiles": ["1234567890.png"]       // 저장된 파일 이름 리스트
}
```

## 5. 이미지 데이터를 도메인에 저장
```java
// 도메인에 데이터 세팅
productTopcategory.setFileDirName(fileDirName);

String filename = imgList.get(0); 
productTopcategory.setFilename(filename);
```
DB 저장용:
- fileDirName: 저장된 하위 경로
- filename: 이미지 파일명

`savedFiles`는 리스트로 반환되기 때문에, 여러 이미지를 등록할 경우 리스트를 저장해주면 됩니다.

## 6. DB 업데이트
```java
int resultCount = productCategoryDAO.update(productTopcategory);
```

## 7. 실패 시 파일 삭제
```java
if (resultCount == 0) {
    fileManager.remove(fileDirName, savePath);
    throw new ProductTopcategoryException("상위 카테고리 등록 실패");
}
```


## 서비스 전체 코드 예시
```java
	@Override
	public void register(ProductTopcategory productTopcategory, String savePath, MultipartFile photo) throws ProductTopcategoryException {
		productCategoryDAO.insert(productTopcategory); // 저장
		int id = productTopcategory.getProductTopcategoryId(); // pk값 추출
		
		// 이미지 저장
		String fileDirName = "category_"+id;
		Map<String, Object> result = imageFileService.saveImage(photo, fileDirName, savePath);

		// 저장된 이미지들의 이름 배열
		List<String> imgList = (List<String>) result.get("savedFiles");
		String filename = imgList.get(0); // 상위 카테고리는 이미지가 하나만 있어서 첫 번째 이미지명만 꺼냄
		
		// 도메인에 데이터 세팅
		productTopcategory.setFileDirName(fileDirName);
		productTopcategory.setFilename(filename);
		log.debug("이미지 저장 디렉토리: {}, 파일명: {}", fileDirName, filename);

        int resultCount = productCategoryDAO.update(productTopcategory); // filepath, filename update
        if (resultCount == 0) {
            fileManager.remove(fileDirName, savePath);
            throw new ProductTopcategoryException("상위 카테고리 등록 실패");
        }
	}
```