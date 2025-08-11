package com.whiskey.domain.whiskey.dto;

import com.whiskey.domain.whiskey.enums.CaskType;

public record CaskCommand(
    CaskType type
) {}