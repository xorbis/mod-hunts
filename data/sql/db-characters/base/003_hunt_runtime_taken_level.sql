-- Character level when the hunt was taken; the rewards are for that level.
-- 0 = taken before this column existed. Conditional so it is safe on any database state.
SET @hunts_sql := IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'hunt_runtime' AND COLUMN_NAME = 'taken_level') = 0,
  'ALTER TABLE `hunt_runtime` ADD COLUMN `taken_level` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''character level when the hunt was taken, 0 = unknown'' AFTER `state`',
  'DO 0');
PREPARE hunts_stmt FROM @hunts_sql;
EXECUTE hunts_stmt;
DEALLOCATE PREPARE hunts_stmt;
