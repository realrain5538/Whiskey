package member.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import member.dto.UserRegisterValue;
import member.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import response.ApiResponse;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public ApiResponse<Void> signup(@Valid @RequestBody UserRegisterValue userDto) {
        userService.signup(userDto);
        return ApiResponse.success("회원가입에 성공하셨습니다.");
    }
}
