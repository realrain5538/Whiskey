package com.whiskey.admin.whiskey.repository;

import com.whiskey.admin.whiskey.dto.WhiskeySearchValue;
import com.whiskey.domain.whiskey.Whiskey;
import java.util.List;

public interface AdminWhiskeyRepositoryCustom {
    List<Whiskey> findWhiskeys(WhiskeySearchValue whiskeyDto);
}
