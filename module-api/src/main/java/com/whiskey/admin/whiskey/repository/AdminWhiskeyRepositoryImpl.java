package com.whiskey.admin.whiskey.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.whiskey.admin.whiskey.dto.WhiskeySearchDto;
import com.whiskey.domain.whiskey.QWhiskey;
import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.domain.whiskey.enums.MaltType;
import java.util.List;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

@Repository
public class AdminWhiskeyRepositoryImpl implements AdminWhiskeyRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    public AdminWhiskeyRepositoryImpl(JPAQueryFactory queryFactory) {
        this.queryFactory = queryFactory;
    }

    @Override
    public List<Whiskey> searchWhiskeys(WhiskeySearchDto whiskeyDto) {
        QWhiskey whiskey = QWhiskey.whiskey;
        return queryFactory
            .selectFrom(whiskey)
            .where(
                distilleryContains(whiskeyDto.distillery()),
                nameContains(whiskeyDto.name()),
                countryContains(whiskeyDto.country()),
                ageEquals(whiskeyDto.age()),
                maltTypeEquals(whiskeyDto.maltType()),
                volumeEquals(whiskeyDto.volume())
            ).fetch();
    }

    private BooleanExpression distilleryContains(String distillery) {
        return StringUtils.hasText(distillery) ? QWhiskey.whiskey.distillery.containsIgnoreCase(distillery) : null;
    }

    private BooleanExpression nameContains(String name) {
        return StringUtils.hasText(name) ? QWhiskey.whiskey.name.containsIgnoreCase(name) : null;
    }

    private BooleanExpression countryContains(String country) {
        return StringUtils.hasText(country) ? QWhiskey.whiskey.country.containsIgnoreCase(country) : null;
    }

    private BooleanExpression ageEquals(Integer age) {
        return age != null ? QWhiskey.whiskey.age.eq(age) : null;
    }

    private BooleanExpression maltTypeEquals(Enum<?> maltType) {
        return maltType != null ? QWhiskey.whiskey.maltType.eq((MaltType) maltType) : null;
    }

    private BooleanExpression volumeEquals(Integer volume) {
        return volume != null ? QWhiskey.whiskey.volume.eq(volume) : null;
    }
}
