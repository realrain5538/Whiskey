package com.whiskey.admin.whiskey.dto;

import jakarta.validation.constraints.NotBlank;

public record CaskRegisterValue(
    @NotBlank
    String type) {

}