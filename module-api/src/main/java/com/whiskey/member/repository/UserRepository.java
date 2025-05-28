package com.whiskey.member.repository;

import java.util.Optional;
import com.whiskey.member.domain.member.member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<member, Long> {
    Optional<member> findByEmail(String email);
}
