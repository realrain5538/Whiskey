package com.whiskey.domain.whiskey;

import com.whiskey.domain.base.BaseEntity;
import com.whiskey.domain.whiskey.enums.MaltType;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Whiskey extends BaseEntity {
    @Column
    private String distillery;

    @Column
    private String name;

    @Column
    private String country;

    @Column
    private int age;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MaltType maltType;

    @Column
    private double abv;

    @Column
    private String description;

    @Column(name = "image_path")
    private String imagePath;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "whiskey_id")
    private List<Cask> casks = new ArrayList<>();

    @Builder
    public Whiskey(String distillery, String name, String country, int age, MaltType maltType, double abv, String description) {
        this.distillery = distillery;
        this.name = name;
        this.country = country;
        this.age = age;
        this.maltType = maltType;
        this.abv = abv;
        this.description = description;
    }

    public void setDistillery(String distillery) {
        this.distillery = distillery;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setMaltType(MaltType maltType) {
        this.maltType = maltType;
    }

    public void setAbv(double abv) {
        this.abv = abv;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public void setCasks(List<Cask> casks) {
        this.casks = casks;
    }

    public void addCasks(List<Cask> casks) {
        if(casks != null && !casks.isEmpty()) {
            this.casks.addAll(casks);
        }
    }
}
