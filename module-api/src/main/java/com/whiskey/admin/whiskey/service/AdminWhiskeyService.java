package com.whiskey.admin.whiskey.service;

import com.whiskey.admin.whiskey.dto.CaskRegisterDto;
import com.whiskey.admin.whiskey.dto.WhiskeyRegisterDto;
import com.whiskey.admin.whiskey.dto.WhiskeyResponseDto;
import com.whiskey.admin.whiskey.dto.WhiskeySearchDto;
import com.whiskey.admin.whiskey.repository.AdminWhiskeyRepository;
import com.whiskey.domain.whiskey.Cask;
import com.whiskey.domain.whiskey.Whiskey;
import com.whiskey.exception.ErrorCode;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminWhiskeyService {

    private final AdminWhiskeyRepository whiskeyRepository;

    @Transactional
    public void register(WhiskeyRegisterDto whiskeyDto) {
        checkDuplicate(whiskeyDto);

        Whiskey whiskey = Whiskey.builder()
            .distillery(whiskeyDto.distillery())
            .name(whiskeyDto.name())
            .country(whiskeyDto.country())
            .age(whiskeyDto.age())
            .maltType(whiskeyDto.maltType())
            .abv(whiskeyDto.abv())
            .volume(whiskeyDto.volume())
            .description(whiskeyDto.description())
            .build();

        List<Cask> casks = new ArrayList<>();
        List<CaskRegisterDto> caskValue = whiskeyDto.casks() != null ? whiskeyDto.casks() : Collections.emptyList();
        for(CaskRegisterDto caskDto : caskValue) {
            Cask cask = new Cask();
            cask.setType(caskDto.caskType());
            casks.add(cask);
        }

        whiskey.addCasks(casks);
        whiskeyRepository.save(whiskey);
    }

    private void checkDuplicate(WhiskeyRegisterDto whiskeyDto) {
        int count = whiskeyRepository.checkDuplicateWhiskey(whiskeyDto.distillery(), whiskeyDto.name(), whiskeyDto.age(), whiskeyDto.maltType(), whiskeyDto.abv(), whiskeyDto.volume());

        if(count > 0) {
            throw ErrorCode.CONFLICT.exception("이미 등록된 위스키입니다.");
        }
    }

    @Transactional
    public void update(Long id, @Valid WhiskeyRegisterDto whiskeyDto) {
        checkDuplicate(whiskeyDto);

        Whiskey whiskey = whiskeyRepository.findById(id).orElseThrow(() -> ErrorCode.NOT_FOUND.exception("위스키를 찾을 수 없습니다."));

        whiskey.setDistillery(whiskeyDto.distillery());
        whiskey.setName(whiskeyDto.name());
        whiskey.setCountry(whiskeyDto.country());
        whiskey.setAge(whiskeyDto.age());
        whiskey.setMaltType(whiskeyDto.maltType());
        whiskey.setAbv(whiskeyDto.abv());
        whiskey.setVolume(whiskeyDto.volume());
        whiskey.setDescription(whiskeyDto.description());

        List<CaskRegisterDto> casks = whiskeyDto.casks() != null ? whiskeyDto.casks() : Collections.emptyList();
        if(!casks.isEmpty()) {
            whiskey.getCasks().clear();

            for(CaskRegisterDto caskDto : casks) {
                Cask cask = new Cask();
                cask.setType(caskDto.caskType());
                whiskey.getCasks().add(cask);
            }
        }
    }

    @Transactional
    public void delete(Long id) {
        if(!whiskeyRepository.existsById(id)) {
            throw ErrorCode.NOT_FOUND.exception("해당 위스키가 존재하지 않습니다.");
        }

        whiskeyRepository.deleteById(id);
    }

    public WhiskeyResponseDto findById(Long id) {
        Whiskey whiskey = whiskeyRepository.findById(id).orElseThrow(() -> ErrorCode.NOT_FOUND.exception("위스키를 찾을 수 없습니다."));
        return WhiskeyResponseDto.from(whiskey);
    }

    public List<WhiskeyResponseDto> searchWhiskeys(@Valid WhiskeySearchDto whiskeyDto) {
        List<Whiskey> whiskeys = whiskeyRepository.searchWhiskeys(whiskeyDto);
        return WhiskeyResponseDto.from(whiskeys);
    }
}
