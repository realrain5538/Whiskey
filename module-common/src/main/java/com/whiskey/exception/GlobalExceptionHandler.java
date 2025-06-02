package com.whiskey.exception;

import static org.springframework.http.ResponseEntity.*;

import com.whiskey.response.ApiErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(CommonException.class)
    public ResponseEntity<ApiErrorResponse> commonException(CommonException exception) {
        HttpStatus status = exception.getErrorCode().getHttpStatus();
        String responseCode = exception.getErrorCode().name();
        ApiErrorResponse response = ApiErrorResponse.of(responseCode, exception.getMessage());

        return status(status).body(response);
    }
}