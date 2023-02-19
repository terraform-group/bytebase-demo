CREATE ALGORITHM = UNDEFINED DEFINER = CURRENT_USER SQL SECURITY DEFINER VIEW `current_dept_emp` AS SELECT 1 AS `emp_no`,1 AS `dept_no`,1 AS `from_date`,1 AS `to_date`;
CREATE ALGORITHM = UNDEFINED DEFINER = CURRENT_USER SQL SECURITY DEFINER VIEW `dept_emp_latest_date` AS SELECT 1 AS `emp_no`,1 AS `from_date`,1 AS `to_date`;
CREATE TABLE `department` (
  `dept_no` CHAR(4) NOT NULL,
  `dept_name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`dept_no`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE UNIQUE INDEX `dept_name` ON `department` (`dept_name`);
CREATE TABLE `dept_emp` (
  `emp_no` INT NOT NULL,
  `dept_no` CHAR(4) NOT NULL,
  `from_date` DATE NOT NULL,
  `to_date` DATE NOT NULL,
  PRIMARY KEY (`emp_no`, `dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `department` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE INDEX `dept_no` ON `dept_emp` (`dept_no`);
CREATE TABLE `dept_manager` (
  `emp_no` INT NOT NULL,
  `dept_no` CHAR(4) NOT NULL,
  `from_date` DATE NOT NULL,
  `to_date` DATE NOT NULL,
  PRIMARY KEY (`emp_no`, `dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `department` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE INDEX `dept_no` ON `dept_manager` (`dept_no`);
CREATE TABLE `employee` (
  `emp_no` INT NOT NULL,
  `birth_date` DATE NOT NULL,
  `first_name` VARCHAR(14) NOT NULL,
  `last_name` VARCHAR(16) NOT NULL,
  `gender` ENUM('M','F') NOT NULL,
  `hire_date` DATE NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE TABLE `salary` (
  `emp_no` INT NOT NULL,
  `amount` INT NOT NULL,
  `from_date` DATE NOT NULL,
  `to_date` DATE NOT NULL,
  PRIMARY KEY (`emp_no`, `from_date`),
  CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE TABLE `subject` (
  `id` BIGINT NOT NULL,
  `course` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
CREATE TABLE `title` (
  `emp_no` INT NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `from_date` DATE NOT NULL,
  `to_date` DATE DEFAULT NULL,
  PRIMARY KEY (`emp_no`, `title`, `from_date`),
  CONSTRAINT `title_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employee` (`emp_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET=UTF8MB4 DEFAULT COLLATE=UTF8MB4_0900_AI_CI;
DROP VIEW IF EXISTS `current_dept_emp`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `current_dept_emp` AS SELECT `l`.`emp_no` AS `emp_no`,`d`.`dept_no` AS `dept_no`,`l`.`from_date` AS `from_date`,`l`.`to_date` AS `to_date` FROM `dept_emp` AS `d` JOIN `dept_emp_latest_date` AS `l` ON (((`d`.`emp_no`=`l`.`emp_no`) AND (`d`.`from_date`=`l`.`from_date`) AND (`l`.`to_date`=`d`.`to_date`)));
DROP VIEW IF EXISTS `dept_emp_latest_date`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `dept_emp_latest_date` AS SELECT `dept_emp`.`emp_no` AS `emp_no`,MAX(`dept_emp`.`from_date`) AS `from_date`,MAX(`dept_emp`.`to_date`) AS `to_date` FROM `dept_emp` GROUP BY `dept_emp`.`emp_no`;
