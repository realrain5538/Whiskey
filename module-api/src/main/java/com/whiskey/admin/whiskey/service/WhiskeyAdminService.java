package com.whiskey.admin.whiskey.service;

import com.whiskey.admin.whiskey.dto.WhiskeyRegisterValue;
import com.whiskey.admin.whiskey.repository.WhiskeyAdminRepository;
import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.exception.ErrorCode;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class WhiskeyAdminService {

    private final WhiskeyAdminRepository whiskeyRepository;

    @Transactional
    public void register(WhiskeyRegisterValue whiskeyDto) {
        checkDuplicate(whiskeyDto);

        Whiskey whiskey = Whiskey.builder()
            .distillery(whiskeyDto.distillery())
            .name(whiskeyDto.name())
            .country(whiskeyDto.country())
            .age(whiskeyDto.age())
            .maltType(whiskeyDto.maltType())
            .abv(whiskeyDto.abv())
            .description(whiskeyDto.description())
            .build();

        whiskeyRepository.save(whiskey);
    }

    private void checkDuplicate(WhiskeyRegisterValue whiskeyDto) {
        int count = whiskeyRepository.checkDuplicateWhiskey(whiskeyDto.distillery(), whiskeyDto.name(), whiskeyDto.age(), whiskeyDto.maltType(), whiskeyDto.abv());

        if(count > 0) {
            throw ErrorCode.CONFLICT.exception("이미 등록된 위스키입니다.");
        }
    }
}
