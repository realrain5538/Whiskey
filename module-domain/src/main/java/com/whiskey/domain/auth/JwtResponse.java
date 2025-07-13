package com.whiskey.domain.auth;

public record JwtResponse(
     String accessToken,
     String refreshToken,
     String tokenType,
     Long expireTime,
     MemberInfo memberInfo
) {
    public static JwtResponse of(String accessToken, String refreshToken, String tokenType, Long expireTime, MemberInfo memberInfo) {
        return new JwtResponse(accessToken, refreshToken, tokenType, expireTime, memberInfo);
    }
}