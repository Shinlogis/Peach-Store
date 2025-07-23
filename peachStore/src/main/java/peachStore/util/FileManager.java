package peachStore.util;

import org.springframework.stereotype.Component;

@Component
public class FileManager {
//	public void save(Product product,String savePath)throws UploadException {
//		//파일의 수가 복수개이므로, 상품마다 1:1대응하는 디렉토리를 생성하자
//		File directory = new File(savePath,"p_"+product.getProduct_id()); //p_7
//		
//		//MultipartFile 변수와 html 이름이 동일하면 매핑됨
//		MultipartFile[] photo=product.getPhoto();
//	
//		log.debug("업로드 한 파일의 수는 "+photo.length);
//		List imgList =new ArrayList<>();
//		
//		
//		for(int i=0;i<photo.length;i++) {
//			try {
//				String ori= photo[i].getOriginalFilename();
//				
//				//개발자가 원하는 파일명 생성하기
//				String ext=ori.substring(ori.lastIndexOf(".")+1,ori.length());
//				try {
//					Thread.sleep(10); //연산 속도가 너무 빠르면 파일명이 중복될 수 있으므로 잉ㄹ부러 지연
//				} catch (InterruptedException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//				long time=System.currentTimeMillis();
//				String filename=time+"."+ext;
//				
//				//생성한 파일명을 DB에 저장하기 위해 Product와 imgList에 보관해놓자
//				ProductImg productImg = new ProductImg();
//				productImg.setFilename(filename);
//				imgList.add(productImg);
//				product.setImgList(imgList);
//				
//				File file=new File(directory.getAbsolutePath()+File.separator+filename);
//				log.debug("업로드된 이미지가 생성된 경로는 서예닮~~"+directory);
//				photo[i].transferTo(file);
//			} catch (Exception e) {
//				throw new UploadException("파일업로드 실패",e);
//			}
//		}
//	}
//	
//	//상품이미지 삭제 (지정한 상품의 디렉토리 및 그 안의 파일들)
//	public void remove(Product product,String savePath) {
//		//디렉토리를 지우기 위해서는, 그 안에 파일들이 먼저 지워져야함
//		//1) 조사 대상 디렉토리를 지정
//		File directory = new File(savePath,"p_"+product.getProduct_id());
//		
//		//디렉토리가 실제로 존재할 경우 그 안의 파일부터 지우기
//		if(directory.exists()&& directory.isDirectory()) {
//			File[] files = directory.listFiles();
//			
//			if(files!=null) {
//				for(File file:files) {
//					boolean deleted = file.delete();
//					log.debug(file.getName()+"를 삭제한 결과"+deleted);
//				}
//			}
//			
//			//파일이 모두 삭제되었으므로 디렉토리도 삭제
//			boolean result=directory.delete();
//			if(result==false) {
//				log.warn("디렉토리삭제실패 "+directory.getAbsolutePath());
//			}
//		}
//	}
}
