package com.whiskey.security.jwt;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.whiskey.SimpleTestApplication;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@SpringBootTest(classes = SimpleTestApplication.class)
public class JwtTokenProviderTest {

    @Autowired
    JwtTokenProvider jwtTokenProvider;

    @Test
    void generated_and_parse_token() {
        Long userId = 1L;
        List<GrantedAuthority> authorities = List.of(new SimpleGrantedAuthority("ROLE_USER"));

        String token = jwtTokenProvider.generateToken(userId, authorities);
        boolean valid = jwtTokenProvider.validateToken(token);

        assertTrue(valid);

        Authentication authentication = jwtTokenProvider.getAuthentication(token);
        assertEquals(userId.toString(), authentication.getName());
        assertTrue(authentication.getAuthorities().stream()
            .anyMatch(a -> a.getAuthority().equals("ROLE_USER")));
    }
}
