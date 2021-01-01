-- DB update 2019_06_02_00 -> 2019_06_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_02_00 2019_06_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559053099143474521'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559053099143474521');

UPDATE `smart_scripts` SET `action_param2` = 4, `action_param3` = 10000 WHERE `source_type` = 9 AND `id` = 1 AND `entryorguid` IN (1847100,1847101,1847102,1847103,1847104);
UPDATE `smart_scripts` SET `action_param2` = 4, `action_param3` = 10000 WHERE `entryorguid` = 1847101 AND `source_type` = 9 AND `id` = 2;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
