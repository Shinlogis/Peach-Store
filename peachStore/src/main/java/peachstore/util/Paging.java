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
	    this.pageSize = 10;

	    String currentPageParam = request.getParameter("currentPage");

	    if(currentPageParam != null) {
	        try {
	            currentPage = Integer.parseInt(currentPageParam);
	            if (currentPage < 1) {
	                currentPage = 1;
	            }
	        } catch (NumberFormatException e) {
	            currentPage = 1;
	        }
	    }

	    this.totalPage = (int) Math.ceil((double) totalRecord / pageSize);
	    if (currentPage > totalPage) {
	        currentPage = totalPage;
	    }

	    this.firstPage = currentPage - (currentPage - 1) % blockSize;
	    this.lastPage = Math.min(firstPage + blockSize - 1, totalPage);
	    this.curPos = (currentPage - 1) * pageSize;
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
