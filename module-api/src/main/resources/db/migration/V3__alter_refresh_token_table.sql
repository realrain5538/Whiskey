ALTER TABLE refresh_token ADD COLUMN create_at datetime NULL;
ALTER TABLE refresh_token ADD COLUMN update_at datetime NULL;
ALTER TABLE refresh_token RENAME COLUMN created_at TO issued_at;