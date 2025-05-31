package com.whiskey.member.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record MemberRegisterValue(
    @NotBlank @Email
    String email,
    @NotBlank
    String password,
    @NotBlank
    String memberName) {

}
