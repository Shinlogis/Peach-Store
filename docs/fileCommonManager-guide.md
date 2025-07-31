
# 공용 파일 매니저 가이드

### 이미지 업로드 및 DB 등록 흐름
1. 컨트롤러에서 업로드된 이미지 파일과 저장 경로 전달
2. `imageFileService.saveImage(photo, "category", savePath)` 로 실제 파일 저장  
3. 반환된 `fileDirName`, `filename` 으로 도메인 객체 세팅  
4. DAO를 통해 DB 저장 → 실패 시 `fileManager.remove(...)` 로 이미지 삭제  

## 1. 의존성 주입
서비스에서 `ImageFileService`, `FileCommonManager`의 의존성을 주입받습니다.

## 2. 전체 이미지 저장
```java
Map<String, Object> result = imageFileService.saveImage(photo, "category", savePath);
```
- photo: 업로드한 파일 (MultipartFile)
- "category": 카테고리 구분용 서브디렉토리 이름
- savePath: 실제 서버에 저장될 물리 경로 (예: /webapps/data). 컨트롤러에서 전달받습니다.<br>(`String savePath = request.getServletContext().getRealPath("/data");`)

리턴값(Map): 
```java
{
  "fileDirName": "category1234567890",   // 하위 폴더 이름
  "savedFiles": ["1234567890.png"]       // 저장된 파일 이름 리스트
}
```

## 3. 이미지 메타데이터 설정
```java
String fileDirName = (String) result.get("fileDirName");
List<String> savedFiles = (List<String>) result.get("savedFiles");
String filename = savedFiles.get(0);

productTopcategory.setFileDirName(fileDirName);
productTopcategory.setFilename(filename);
```
DB 저장용:
- fileDirName: 저장된 하위 경로
- filename: 이미지 파일명

`savedFiles`는 리스트로 반환되기 때문에, 여러 이미지를 등록할 경우 리스트를 저장해주면 됩니다.

## 4. DB 등록
```java
int resultCount = productCategoryDAO.insert(productTopcategory);
```

## 5. 실패 시 파일 삭제
```java
if (resultCount == 0) {
    fileManager.remove(fileDirName, savePath);
    throw new ProductTopcategoryException("상위 카테고리 등록 실패");
}
```


## 전체 코드 예시
```java

	@Override
	public void register(ProductTopcategory productTopcategory, String savePath, MultipartFile photo) throws ProductTopcategoryException {
		
		// imageFileService를 이용해 이미지 저장
        Map<String, Object> result = imageFileService.saveImage(photo, "category", savePath);
        String fileDirName = (String) result.get("fileDirName");
        List<String> savedFiles = (List<String>) result.get("savedFiles");
        String filename = savedFiles.get(0);
        
		// 이미지 데이터 추가
		productTopcategory.setFileDirName(fileDirName);
		productTopcategory.setFilename(filename);
		
		log.debug("setFilename: {}", productTopcategory.getFilename());

		 // 상위 카테고리 등록
        int resultCount = productCategoryDAO.insert(productTopcategory);
        if (resultCount == 0) {
            fileManager.remove(fileDirName, savePath);
            throw new ProductTopcategoryException("상위 카테고리 등록 실패");
        }
	}
```