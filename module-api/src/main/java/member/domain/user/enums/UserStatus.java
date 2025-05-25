package member.domain.user.enums;

public enum UserStatus {
    ACTIVE("활성 계정"),
    INACTIVE("휴면 계정"),
    WITHDRAW("탈퇴 계정");

    private final String value;

    UserStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
