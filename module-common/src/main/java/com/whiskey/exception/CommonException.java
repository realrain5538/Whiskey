package com.whiskey.exception;

import org.springframework.http.HttpStatus;

public class CommonException extends RuntimeException {
    private final CommonErrorCode errorCode;

    public CommonException(CommonErrorCode errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }

    public CommonErrorCode getErrorCode() {
        return errorCode;
    }

    public HttpStatus getHttpStatus() {
        return errorCode.getHttpStatus();
    }
}
