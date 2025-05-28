package com.whiskey.member.domain.member;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import com.whiskey.member.domain.base.BaseEntity;
import com.whiskey.member.domain.member.enums.MemberStatus;
import org.springframework.data.annotation.CreatedDate;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class member extends BaseEntity {
    @Column(name = "password_hash")
    private String passwordHash;

    @Column(name = "member_name")
    private String memberName;

    @Column
    private String email;

    @Column(name = "profile_img_path")
    private String profileImgPath;

    @Column(name = "oauth_id")
    private String oauthId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "is_status")
    private MemberStatus isStatus;

    @CreatedDate
    @Column(nullable = false, name = "reg_date")
    private LocalDateTime regDate;
}