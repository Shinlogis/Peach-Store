/*이미지 썸네일 클래스 정의*/
class ProductImg {
	constructor(container, file, src, width, height) {
		this.container = container;
		this.file = file;
		this.src = src;
		this.width = width;
		this.height = height;
		this.wrapper = document.createElement("div");
		this.header = document.createElement("div");
		this.img = document.createElement("img");
		//대입
		this.img.src = this.src;

		//스타일		
		this.img.style.width = this.width + "px";
		this.img.style.height = this.height + "px";

		this.wrapper.style.width = this.width + "px";
		this.wrapper.style.height = (this.height + 20) + "px";
		this.wrapper.style.display = "inline-block";
		this.wrapper.style.margin = 2 + "px";

		this.header.innerHTML = "<a href='#'>X</a>";
		this.header.style.textAlign = "right";

		//조링(assemble)
		this.wrapper.appendChild(this.header);
		this.wrapper.appendChild(this.img);
		this.container.appendChild(this.wrapper); // ✅ DOM에 실제로 삽입


		//header에 클릭이벤트 연결
		//this가 상위스코프 영역접근 아래 화살표함수에서 자신보다 상위 영역인 클래스 인스턴스를 의미
		this.header.addEventListener("click", (e)=>{
			//a태그 => y축을 0으로
			//이벤트발생시 기본특징 제거
			e.preventDefault();
			this.remove();
		});
	}

	//내가 현재 붙어있는 컨테이너로부터 나를 삭제한다(화면에서)
	remove() {
		//화면에서만 제거.
		this.container.removeChild(this.wrapper);
		
		//배열에서도 제거
		//현재 객체가 보유한 File이 selectedFile배열의 몇번째 소속이 되어 있는지 조사하여
		//이 객체를지우면 같은 위치에있던 File도 제거하자.
		let index = selectedFile.indexOf(this.file);
		selectedFile.splice(index, 1);
	}

}