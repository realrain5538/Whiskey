package com.whiskey.domain.whiskey.repository;

import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.domain.whiskey.dto.WhiskeyCommand;
import com.whiskey.domain.whiskey.dto.WhiskeySearchCondition;
import java.util.List;

public interface WhiskeyRepositoryCustom {
    List<Whiskey> searchWhiskeys(WhiskeySearchCondition whiskeyDto);

    int checkDuplicateWhiskey(WhiskeyCommand whiskeyDto);
}
