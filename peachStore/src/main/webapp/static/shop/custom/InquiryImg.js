/**
 * 이미지 썸네일 클래스 정의
 */

class InquiryImg{
	constructor(container, file, src, width, height){
		this.container = container;
		this.file = file;
		this.src = src;
		this.width = width;
		this.height = height;
		
		this.wrapper = document.createElement("div");
		this.header = document.createElement("div");
		this.img = document.createElement("img");
		this.img.src = this.src;
		
		//style
		this.img.style.width = this.width + "px";
		this.img.style.height = this.height + "px";
		
		this.wrapper.style.width = this.width + "px";
		this.wrapper.style.height=(this.height+20) + "px";
		this.wrapper.style.display = "inline-block";
		this.wrapper.style.margin=2 + "px";
		
		this.header.innerHTML="<a href='#'>X</a>"
		this.header.style.textAlign="right";
		
		//조립
		this.wrapper.appendChild(this.header);
		this.wrapper.appendChild(this.img);
		this.container.appendChild(this.wrapper);
		
		//이벤트
		this.header.addEventListener("click",(e)=>{
			e.preventDefault(); //a태그에 의해 스크롤이 위로 이동하는 것 방지
			this.remove();
		});
		
	}
	
	remove(){
		//화면에서 제거
		this.container.removeChild(this.wrapper);
		
		//배열에서 제거
		let index = selectedFile.indexOf(this.file);
		selectedFile.splice(index, 1);
	}
	
}