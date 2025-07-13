package com.whiskey.member.service;

import com.whiskey.auth.dto.LoginRequest;
import com.whiskey.domain.auth.JwtResponse;
import com.whiskey.domain.member.Member;
import com.whiskey.domain.member.enums.MemberStatus;
import com.whiskey.dto.ValidationErrorValue;
import com.whiskey.exception.ErrorCode;
import com.whiskey.member.dto.MemberRegisterValue;
import com.whiskey.member.repository.MemberRepository;
import com.whiskey.security.jwt.JwtTokenProvider;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;

    @Transactional
    public void signup(MemberRegisterValue memberDto) {
        // 회원가입 약관동의 체크 확인

        // 중복가입 체크
        checkDuplicate(memberDto.email());

        try {
            String encryptPassword = passwordEncoder.encode(memberDto.password());
            Member member = Member.builder()
                .passwordHash(encryptPassword)
                .memberName(memberDto.memberName())
                .email(memberDto.email())
                .status(MemberStatus.ACTIVE)
                .build();

            memberRepository.save(member);
        }
        catch(DataIntegrityViolationException e) {
            throw ErrorCode.CONFLICT.exception("이미 가입된 이메일입니다.");
        }
    }

    private void checkDuplicate(String email) {
        if(memberRepository.existsByEmailAndStatus(email, MemberStatus.ACTIVE)) {
            ValidationErrorValue errorValue = new ValidationErrorValue("email", email, "duplicate");
            throw ErrorCode.CONFLICT.exception("이미 가입된 이메일입니다.", errorValue);
        }
    }

    public JwtResponse login(@Valid LoginRequest loginRequest) {
        log.debug("=== Login 시작: {} ===", loginRequest.email());

        try {
            Member member = authenticateMember(loginRequest.email(), loginRequest.password());

            List<SimpleGrantedAuthority> authorities = List.of(
                new SimpleGrantedAuthority("ROLE_USER")
            );

            String accessToken = jwtTokenProvider.generateToken(member.getId(), authorities);
            String refreshToken = jwtTokenProvider.generateRefreshToken(member.getId());

            log.debug("=== Login 성공: {} ===", loginRequest.email());
            return new JwtResponse(accessToken, refreshToken);
        }
        catch(Exception e) {
            log.error("Login 실패: {}", loginRequest.email(), e);
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
