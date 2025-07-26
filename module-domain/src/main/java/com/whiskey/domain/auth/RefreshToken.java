package com.whiskey.domain.auth;

import com.whiskey.domain.base.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;

@Entity
@Getter
@NoArgsConstructor
public class RefreshToken extends BaseEntity {
    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "refresh_token", length = 512)
    private String refreshToken;

    @Column(name = "expiry_at")
    private LocalDateTime expiryAt;

    @CreatedDate
    @Column(name = "issued_at")
    private LocalDateTime issuedAt;

    public RefreshToken(Long memberId, String refreshToken, LocalDateTime expiryAt) {
        this.memberId = memberId;
        this.refreshToken = refreshToken;
        this.expiryAt = expiryAt;
        this.issuedAt = LocalDateTime.now();
    }

    public void updateToken(String newToken, LocalDateTime expiryTime) {
        this.refreshToken = newToken;
        this.expiryAt = expiryTime;
        this.issuedAt = LocalDateTime.now();
    }
}
