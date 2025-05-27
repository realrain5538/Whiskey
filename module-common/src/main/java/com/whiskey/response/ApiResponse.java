package com.whiskey.response;

public record ApiResponse<T>(
    boolean success,
    String message) {
        public static <T> ApiResponse<T> success(String message) {
            return new ApiResponse<>(true, message);
        }
}
