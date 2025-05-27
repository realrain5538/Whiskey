package com.whiskey.member.repository;

import java.util.Optional;
import com.whiskey.member.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
