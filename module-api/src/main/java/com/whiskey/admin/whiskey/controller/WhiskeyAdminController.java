package com.whiskey.admin.whiskey.controller;

import com.whiskey.admin.whiskey.dto.WhiskeyRegisterValue;
import com.whiskey.admin.whiskey.service.WhiskeyAdminService;
import com.whiskey.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
@Slf4j
public class WhiskeyAdminController {

    private final WhiskeyAdminService whiskeyService;

//    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/whiskey")
    public ApiResponse<Void> register(@Valid @RequestBody WhiskeyRegisterValue whiskeyDto) {
        whiskeyService.register(whiskeyDto);
        return ApiResponse.success("위스키 등록이 완료되었습니다.");
    }

    @PutMapping("/whiskey/{id}")
    public ApiResponse<Void> update(@PathVariable("id") Long id, @Valid @RequestBody WhiskeyRegisterValue whiskeyDto) {
        whiskeyService.update(id, whiskeyDto);
        return ApiResponse.success("위스키 정보가 수정되었습니다.");
    }
}
