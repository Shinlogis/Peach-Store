CREATE USER 'electronicmall'@'localhost' IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES ON electronicmall.* TO 'electronicmall'@'localhost';

FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS electronicmall CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
