package com.whiskey.member.dto;

import com.whiskey.domain.member.Member;

public record MemberResponse(
    Long id,
    String memberName,
    String email
) {
    public static MemberResponse from(Member member) {
        return new MemberResponse(
            member.getId(),
            member.getMemberName(),
            member.getEmail()
        );
    }
}
