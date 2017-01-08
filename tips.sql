# ON MASTER

CREATE DATABASE `TTT`;

USE REA;
CREATE TABLE `item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `age` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `item` (name, age) VALUES ('Rundong', 12);
INSERT INTO `item` (name, age) VALUES ('Kevin', 12);
INSERT INTO `item` (name, age) VALUES ('Yuchen', 12);

SHOW MASTER STATUS;

SET GLOBAL binlog_format = 'STATEMENT';
SHOW global variables LIKE 'binlog_format';


# ON SLAVE
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='172.22.0.1',
    MASTER_PORT=3777,
    MASTER_USER='root',
    MASTER_PASSWORD='Password12',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=12135;
START SLAVE;
SHOW SLAVE STATUS \G;

// ANOTHER SLAVE
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='172.22.0.1',
    MASTER_PORT=3778,
    MASTER_USER='root',
    MASTER_PASSWORD='Password12',
    MASTER_LOG_FILE='mysql-bin.000003',
    MASTER_LOG_POS=13010;
START SLAVE;
SHOW SLAVE STATUS \G;
--------------

SET GLOBAL binlog_format = 'STATEMENT';
SHOW global variables LIKE 'binlog_format';

CREATE TABLE `item2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `age` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `item` ADD COLUMN `created_at` timestamp DEFAULT CURRENT_TIMESTAMP;

show processlist \G

ALTER TABLE `item` ADD COLUMN `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP;
CREATE TRIGGER store_updated_at 
BEFORE UPDATE ON item
FOR EACH ROW
SET NEW.updated_at = NOW();

----------------
CREATE TRIGGER item_created_at
BEFORE INSERT ON item
FOR EACH ROW
INSERT INTO `item3` (name) VALUES ('s');

CREATE TRIGGER item_update_at
BEFORE UPDATE ON item
FOR EACH ROW
INSERT INTO `item3` (name) VALUES ('s');

CREATE TABLE `item3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `item3` (name) VALUES ('s')

