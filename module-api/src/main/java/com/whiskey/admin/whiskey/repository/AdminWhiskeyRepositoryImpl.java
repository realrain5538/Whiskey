package com.whiskey.admin.whiskey.repository;

import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.whiskey.admin.whiskey.dto.WhiskeySearchValue;
import com.whiskey.domain.whiskey.Whiskey;
import jakarta.persistence.EntityManager;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository
public class AdminWhiskeyRepositoryImpl implements AdminWhiskeyRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    public AdminWhiskeyRepositoryImpl(EntityManager em) {
        this.queryFactory = new JPAQueryFactory(em);
    }

    @Override
    public List<Whiskey> findWhiskeys(WhiskeySearchValue whiskeyDto) {
        return List.of();
    }
}
