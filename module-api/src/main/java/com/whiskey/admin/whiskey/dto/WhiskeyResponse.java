package com.whiskey.admin.whiskey.dto;

import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.domain.whiskey.enums.MaltType;
import java.util.List;
import java.util.stream.Collectors;

public record WhiskeyResponse(
    String distillery,
    String name,
    String country,
    int age,
    MaltType maltType,
    double abv,
    String description,
    String imagePath,
    List<String> casks
) {
    public static WhiskeyResponse from(Whiskey whiskey) {
        List<String> cask = whiskey.getCasks()
            .stream()
            .map(caskInfo -> caskInfo.getType().name())
            .collect(Collectors.toList());

        return new WhiskeyResponse(
            whiskey.getDistillery(),
            whiskey.getName(),
            whiskey.getCountry(),
            whiskey.getAge(),
            whiskey.getMaltType(),
            whiskey.getAbv(),
            whiskey.getDescription(),
            whiskey.getImagePath(),
            cask
        );
    }
}