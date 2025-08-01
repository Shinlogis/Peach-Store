package peachstore.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Data
@Component
public class Paging {
	private int totalRecord;
	private int pageSize=10;
	private int totalPage;
	private int blockSize=10;
	private int currentPage=1;
	private int firstPage;
	private int lastPage;
	private int curPos;
	private int num;
	
	public void init(List list, HttpServletRequest request) {
		totalRecord=list.size();
		totalPage = (int)Math.ceil((float)totalRecord/pageSize) ;
		if(request.getParameter("currentPage") !=null) {
			currentPage= Integer.parseInt(request.getParameter("currentPage"));
		}
		firstPage = currentPage - (currentPage-1)%blockSize;
		lastPage  = firstPage + (blockSize-1);
		curPos = (currentPage-1)*pageSize;
		num = totalRecord-curPos;
	}
	
	public void init(int totalRecord, HttpServletRequest request) {
	    this.totalRecord = totalRecord;

	    // 1. 현재 페이지 파라미터 유효성 검사
	    if(request.getParameter("currentPage") != null) {
	        try {
	            currentPage = Integer.parseInt(request.getParameter("currentPage"));
	            if (currentPage < 1) currentPage = 1;
	        } catch (NumberFormatException e) {
	            currentPage = 1;
	        }
	    }

	    // 2. 페이지 수 계산
	    this.totalPage = (int) Math.ceil((double) totalRecord / pageSize);
	    if (currentPage > totalPage) currentPage = totalPage;

	    // 3. 페이징 범위 계산
	    this.firstPage = currentPage - (currentPage - 1) % blockSize;
	    this.lastPage = Math.min(firstPage + blockSize - 1, totalPage);

	    // 4. DB 쿼리용 인덱스 계산
	    this.curPos = (currentPage - 1) * pageSize;

	    // 5. 번호 (No) 계산, 음수 방지
	    this.num = Math.max(0, totalRecord - curPos);
	}
	public int getStartIndex() {
		return curPos;
	}

	// 🔹 현재 페이지의 마지막 인덱스 (for view logic 등)
	public int getEndIndex() {
		return Math.min(curPos + pageSize, totalRecord);
	}

}
