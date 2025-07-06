package com.whiskey.auth.controller;

import com.whiskey.auth.dto.LoginRequest;
import com.whiskey.auth.service.AuthService;
import com.whiskey.domain.login.AccessTokenHeader;
import com.whiskey.domain.login.LoginToken;
import com.whiskey.domain.login.RefreshTokenCookie;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<Void> login(@Valid @RequestBody LoginRequest loginRequest) {

    }
}
