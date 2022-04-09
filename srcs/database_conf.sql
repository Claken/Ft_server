CREATE DATABASE sachouam;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON sachouam.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
