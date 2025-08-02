package com.whiskey.admin.whiskey.dto;

import com.whiskey.domain.whiskey.enums.MaltType;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.util.List;

public record WhiskeyRegisterDto(
    @NotBlank String distillery,
    @NotBlank String name,
    @NotBlank String country,
    Integer age,
    @NotNull MaltType maltType,
    @NotNull @Min(0) @Max(100) double abv,
    @NotNull @Min(0) int volume,
    @NotBlank String description,
    List<CaskRegisterDto> casks) {

}
