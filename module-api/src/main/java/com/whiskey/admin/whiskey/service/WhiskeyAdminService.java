package com.whiskey.admin.whiskey.service;

import com.whiskey.admin.whiskey.dto.CaskRegisterValue;
import com.whiskey.admin.whiskey.dto.WhiskeyRegisterValue;
import com.whiskey.admin.whiskey.repository.WhiskeyAdminRepository;
import com.whiskey.domain.whiskey.Cask;
import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.domain.whiskey.enums.CaskType;
import com.whiskey.exception.ErrorCode;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import java.util.Collections;
import java.util.List;
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

        List<CaskRegisterValue> casks = whiskeyDto.casks() != null ? whiskeyDto.casks() : Collections.emptyList();
        for(CaskRegisterValue caskDto : casks) {
            Cask cask = new Cask();
            cask.setType(CaskType.valueOf(caskDto.type()));
            whiskey.getCasks().add(cask);
        }

        whiskeyRepository.save(whiskey);
    }

    private void checkDuplicate(WhiskeyRegisterValue whiskeyDto) {
        int count = whiskeyRepository.checkDuplicateWhiskey(whiskeyDto.distillery(), whiskeyDto.name(), whiskeyDto.age(), whiskeyDto.maltType(), whiskeyDto.abv());

        if(count > 0) {
            throw ErrorCode.CONFLICT.exception("이미 등록된 위스키입니다.");
        }
    }

    @Transactional
    public void update(Long id, @Valid WhiskeyRegisterValue whiskeyDto) {
        Whiskey whiskey = whiskeyRepository.findById(id).orElseThrow(() -> ErrorCode.NOT_FOUND.exception("위스키를 찾을 수 없습니다."));

        whiskey.setDistillery(whiskeyDto.distillery());
        whiskey.setName(whiskeyDto.name());
        whiskey.setCountry(whiskeyDto.country());
        whiskey.setAge(whiskeyDto.age());
        whiskey.setMaltType(whiskeyDto.maltType());
        whiskey.setAbv(whiskeyDto.abv());
        whiskey.setDescription(whiskeyDto.description());

        List<CaskRegisterValue> casks = whiskeyDto.casks() != null ? whiskeyDto.casks() : Collections.emptyList();
        if(!casks.isEmpty()) {
            whiskey.getCasks().clear();

            for(CaskRegisterValue caskDto : casks) {
                Cask cask = new Cask();
                cask.setType(CaskType.valueOf(caskDto.type()));
                whiskey.getCasks().add(cask);
            }
        }
    }
}
