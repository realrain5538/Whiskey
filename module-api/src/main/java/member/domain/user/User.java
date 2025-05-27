package member.domain.user;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import member.domain.base.BaseEntity;
import member.domain.user.enums.UserStatus;
import org.springframework.data.annotation.CreatedDate;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User extends BaseEntity {
    @Column(name = "password_hash")
    private String passwordHash;

    @Column(name = "user_name")
    private String userName;

    @Column
    private String email;

    @Column(name = "profile_img_path")
    private String profileImgPath;

    @Column(name = "oauth_id")
    private String oauthId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, name = "is_status")
    private UserStatus isStatus;

    @CreatedDate
    @Column(nullable = false, name = "reg_date")
    private LocalDateTime regDate;
}