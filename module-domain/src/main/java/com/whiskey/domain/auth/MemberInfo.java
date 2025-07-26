package com.whiskey.domain.auth;

import com.whiskey.domain.member.Member;

public record MemberInfo(
    Long id,
    String memberName,
    String email
) {
    public static MemberInfo from(Member member) {
        return new MemberInfo(
            member.getId(),
            member.getMemberName(),
            member.getEmail()
        );
    }
}