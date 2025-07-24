package com.whiskey.admin.whiskey.dto;

import com.whiskey.domain.whiskey.enums.MaltType;

public record WhiskeySearchValue(
    String distillery,
    String name,
    String country,
    int age,
    MaltType maltType,
    double abv,
    String description
    ) {
}
