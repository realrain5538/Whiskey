package com.whiskey.admin.whiskey.controller;

import com.whiskey.admin.whiskey.dto.WhiskeyRegisterValue;
import com.whiskey.admin.whiskey.service.WhiskeyAdminService;
import com.whiskey.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/whiskey")
@RequiredArgsConstructor
@Slf4j
public class WhiskeyAdminController {

    private final WhiskeyAdminService whiskeyService;

//    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public ApiResponse<Void> register(@Valid @RequestBody WhiskeyRegisterValue whiskeyDto) {
        whiskeyService.register(whiskeyDto);
        return ApiResponse.success("위스키 등록이 완료되었습니다.");
    }
}
