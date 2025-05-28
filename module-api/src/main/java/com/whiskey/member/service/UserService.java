package com.whiskey.member.service;

import com.whiskey.member.domain.member.enums.MemberStatus;
import com.whiskey.member.domain.member.member;
import com.whiskey.member.dto.MemberRegisterValue;
import com.whiskey.member.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public void signup(MemberRegisterValue memberDto) {
        // 회원가입 약관동의 체크 확인

        // 중복가입 체크

        String encryptPassword = passwordEncoder.encode(memberDto.password());
        member user = member.builder()
            .passwordHash(encryptPassword)
            .memberName(memberDto.userName())
            .email(memberDto.email())
            .isStatus(MemberStatus.ACTIVE)
            .build();

        userRepository.save(user);
        
        // H2 활용하여 DB 저장확인
    }
}
