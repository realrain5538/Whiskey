package com.whiskey.admin.whiskey.dto;

import com.whiskey.domain.whiskey.enums.CaskType;
import jakarta.validation.constraints.NotBlank;

public record CaskRegisterValue(
    @NotBlank
    CaskType caskType) {

}