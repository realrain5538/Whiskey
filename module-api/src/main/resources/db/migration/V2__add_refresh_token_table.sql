CREATE TABLE refresh_token (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    member_id bigint,
    refresh_token varchar(512),
    expiry_at datetime,
    created_at datetime
);

-- 인덱스 생성
CREATE INDEX refresh_token_index ON refresh_token (id, member_id);

-- 외래키 생성
ALTER TABLE refresh_token ADD FOREIGN KEY (member_id) REFERENCES member (id);