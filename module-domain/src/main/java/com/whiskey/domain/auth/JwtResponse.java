package com.whiskey.domain.auth;

public record JwtResponse(
     String accessToken,
     String refreshToken
) {
    public static JwtResponse of(String accessToken, String refreshToken) {
        return new JwtResponse(accessToken, refreshToken);
    }
}
