package peachstore.exception;

import lombok.Getter;

public class TosspaymentException extends RuntimeException {
	public TosspaymentException(String msg) {
		super(msg);
	}
	
	public TosspaymentException(Throwable e) {
		super(e);
	}
	
	public TosspaymentException(String msg, Throwable e) {
		super(msg, e);
	}
}
