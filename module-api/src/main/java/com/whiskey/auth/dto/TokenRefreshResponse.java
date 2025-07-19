package com.whiskey.auth.dto;

public record TokenRefreshResponse(
    String accessToken,
    String refreshToken,
    String tokenType,
    long expiryTime
) {}