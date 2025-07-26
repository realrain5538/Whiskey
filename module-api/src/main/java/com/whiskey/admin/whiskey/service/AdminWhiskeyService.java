package com.whiskey.admin.whiskey.service;

import com.whiskey.admin.whiskey.dto.CaskRegisterValue;
import com.whiskey.admin.whiskey.dto.WhiskeyRegisterValue;
import com.whiskey.admin.whiskey.dto.WhiskeyResponse;
import com.whiskey.admin.whiskey.dto.WhiskeySearchValue;
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
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminWhiskeyService {

    private final AdminWhiskeyRepository whiskeyRepository;

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

        List<Cask> casks = new ArrayList<>();
        List<CaskRegisterValue> caskValue = whiskeyDto.casks() != null ? whiskeyDto.casks() : Collections.emptyList();
        for(CaskRegisterValue caskDto : caskValue) {
            Cask cask = new Cask();
            cask.setType(caskDto.caskType());
            casks.add(cask);
        }

        whiskey.addCasks(casks);
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

    public WhiskeyResponse findById(Long id) {
        Whiskey whiskey = whiskeyRepository.findById(id).orElseThrow(() -> ErrorCode.NOT_FOUND.exception("위스키를 찾을 수 없습니다."));
        return WhiskeyResponse.from(whiskey);
    }

    public List<WhiskeyResponse> find(@Valid WhiskeySearchValue whiskeyDto) {
        // 동적 쿼리 추가
        return null;
    }
}
