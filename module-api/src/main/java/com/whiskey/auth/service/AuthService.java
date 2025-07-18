package com.whiskey.auth.service;

import com.whiskey.auth.dto.LoginRequest;
import com.whiskey.domain.auth.JwtResponse;
import com.whiskey.domain.auth.MemberInfo;
import com.whiskey.domain.member.Member;
import com.whiskey.domain.member.enums.MemberStatus;
import com.whiskey.exception.ErrorCode;
import com.whiskey.member.repository.MemberRepository;
import com.whiskey.security.jwt.JwtTokenProvider;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class AuthService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;

    public JwtResponse login(@Valid LoginRequest loginRequest) {
        try {
            Member member = authenticateMember(loginRequest.email(), loginRequest.password());

            List<SimpleGrantedAuthority> authorities = List.of(
                new SimpleGrantedAuthority("ROLE_USER")
            );

            String accessToken = jwtTokenProvider.generateToken(member.getId(), authorities);
            String refreshToken = jwtTokenProvider.generateRefreshToken(member.getId());

            Long expireTime = jwtTokenProvider.getAccessTokenValidityTime();
            MemberInfo memberInfo = MemberInfo.from(member);

            return new JwtResponse(accessToken, refreshToken, "Bearer", expireTime, memberInfo);
        }
        catch(Exception e) {
            throw ErrorCode.UNAUTHORIZED.exception("인증에 실패했습니다.");
        }
    }

    private Member authenticateMember(String email, String password) {
        Member member = memberRepository.findByEmailAndStatus(email, MemberStatus.ACTIVE)
            .orElseThrow(() -> ErrorCode.UNAUTHORIZED.exception("존재하지 않는 회원입니다."));

        if(!passwordEncoder.matches(password, member.getPasswordHash())) {
            throw ErrorCode.UNAUTHORIZED.exception("비밀번호가 일치하지 않습니다.");
        }

        if(member.getStatus() != MemberStatus.ACTIVE) {
            throw ErrorCode.UNAUTHORIZED.exception("비활성화된 계정입니다.");
        }

        return member;
    }
}
