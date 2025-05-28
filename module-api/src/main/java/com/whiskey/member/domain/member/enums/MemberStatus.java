package com.whiskey.member.domain.member.enums;

public enum MemberStatus {
    ACTIVE("활성 계정"),
    INACTIVE("휴면 계정"),
    WITHDRAW("탈퇴 계정");

    private final String value;

    MemberStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
