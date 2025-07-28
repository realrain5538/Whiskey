package com.whiskey.admin.whiskey.repository;

import com.whiskey.admin.whiskey.dto.WhiskeySearchValue;
import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.domain.whiskey.enums.MaltType;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AdminWhiskeyRepository extends JpaRepository<Whiskey, Long>, AdminWhiskeyRepositoryCustom {

    @Query("SELECT COUNT(w) FROM Whiskey w WHERE w.distillery = :distillery AND w.name = :name AND w.age = :age AND w.maltType = :malt_type AND w.abv = :abv")
    int checkDuplicateWhiskey(
        @Param("distillery") String distillery,
        @Param("name") String name,
        @Param("age") int age,
        @Param("malt_type") MaltType maltType,
        @Param("abv") double abv
    );
}