CREATE TABLE member (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    password_hash varchar(100),
    member_name varchar(20),
    email varchar(100),
    profile_img_path varchar(500),
    oauth_id varchar(100),
    status enum('ACTIVE','INACTIVE','WITHDRAW'),
    reg_date datetime,
    create_at datetime COMMENT '테이블 생성일시',
    update_at datetime COMMENT '테이블 수정일시'
);

CREATE TABLE whiskey (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    distillery varchar(100),
    name varchar(100),
    country varchar(20),
    age int,
    malt_type enum('SINGLE_MALT','BLENDED') COMMENT 's:싱글몰트, b:블렌디드',
    abv double COMMENT '도수',
    description text,
    image_path varchar(500),
    create_at datetime COMMENT '테이블 생성일시',
    update_at datetime COMMENT '테이블 수정일시'
);

CREATE TABLE cask (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    whiskey_id bigint,
    type enum('SHERRY','PORT','BOURBON'),
    create_at datetime COMMENT '테이블 생성일시',
    update_at datetime COMMENT '테이블 수정일시'
);

CREATE TABLE review (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    whiskey_id bigint,
    member_id bigint,
    star_rate double,
    review_date datetime,
    create_at datetime COMMENT '테이블 생성일시',
    update_at datetime COMMENT '테이블 수정일시'
);

CREATE TABLE wish_list (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    whiskey_id bigint,
    member_id bigint,
    wish_date datetime,
    create_at datetime COMMENT '테이블 생성일시',
    update_at datetime COMMENT '테이블 수정일시'
);

-- 인덱스 생성
CREATE INDEX member_index ON member (id, status);
CREATE INDEX whiskey_index ON whiskey (id, distillery, name, malt_type, abv);
CREATE INDEX cask_index ON cask (id, whiskey_id);
CREATE INDEX review_index ON review (id, star_rate);
CREATE INDEX wish_list_index ON wish_list (id, wish_date);

-- 외래키 생성
ALTER TABLE cask ADD FOREIGN KEY (whiskey_id) REFERENCES whiskey (id);
ALTER TABLE review ADD FOREIGN KEY (whiskey_id) REFERENCES whiskey (id);
ALTER TABLE review ADD FOREIGN KEY (member_id) REFERENCES member (id);
ALTER TABLE wish_list ADD FOREIGN KEY (whiskey_id) REFERENCES whiskey (id);
ALTER TABLE wish_list ADD FOREIGN KEY (member_id) REFERENCES member (id);