package member.service;

import lombok.RequiredArgsConstructor;
import member.domain.user.User;
import member.domain.user.enums.UserStatus;
import member.dto.UserRegisterValue;
import member.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public void signup(UserRegisterValue userDto) {
        // 회원가입 약관동의 체크 확인

        // 중복가입 체크

        String encryptPassword = passwordEncoder.encode(userDto.password());
        User user = User.builder()
            .passwordHash(encryptPassword)
            .userName(userDto.userName())
            .email(userDto.email())
            .isStatus(UserStatus.ACTIVE)
            .build();

        userRepository.save(user);
        
        // H2 활용하여 DB 저장확인
    }
}
