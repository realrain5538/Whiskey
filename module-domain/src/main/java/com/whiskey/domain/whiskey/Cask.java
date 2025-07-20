package com.whiskey.domain.whiskey;

import com.whiskey.domain.base.BaseEntity;
import com.whiskey.domain.whiskey.enums.CaskType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Cask extends BaseEntity {
    @Column(name = "type")
    private CaskType caskType;
}
