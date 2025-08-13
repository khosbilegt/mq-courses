-- let's split up the data
-- let's split up the data
CREATE TABLE `hogwarts_student` (
  `student id` INT UNSIGNED NOT NULL,
  `given names` VARCHAR(200) NOT NULL,
  `family name` VARCHAR(200) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`student id`)
);

CREATE TABLE `hogwarts_unit` (
  `unitcode` VARCHAR(7) NOT NULL,
  `unitname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`unitcode`)
);

CREATE TABLE `hogwarts_offering` (
  `unitcode` VARCHAR(7) NOT NULL,
  `offering` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`unitcode`, `offering`),
  CONSTRAINT FK_UNIT_OFFERING FOREIGN KEY (`unitcode`) REFERENCES `hogwarts_unit`(`unitcode`)
);

CREATE TABLE `hogwarts_enrolment` (
  `enrolment id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `student id` INT UNSIGNED NOT NULL,
  `unitcode` VARCHAR(7) NOT NULL,
  `offering` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`enrolment id`),
  CONSTRAINT FK_ENROL_OFFERING FOREIGN KEY (`unitcode`, `offering`) REFERENCES `hogwarts_offering`(`unitcode`, `offering`),
  CONSTRAINT FK_ENROL_STUDENT FOREIGN KEY (`student id`) REFERENCES `hogwarts_student`(`student id`)
);


CREATE TABLE `hogwarts_grade` (
  `enrolment id` INT UNSIGNED NOT NULL,
  `grade` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`enrolment id`),
  CONSTRAINT FK_ENROL_GRADE FOREIGN KEY (`enrolment id`) REFERENCES `hogwarts_enrolment`(`enrolment id`)
);

INSERT INTO hogwarts_student VALUES (516710,"Hannah", "Abbott", "516710@student.hogwarts.edu.uk");
INSERT INTO hogwarts_student VALUES (516720,"Neville", "Longbottom", "516720@student.hogwarts.edu.uk");
INSERT INTO hogwarts_student VALUES (516730,"Draco", "Malfoy", "516730@student.hogwarts.edu.uk");
INSERT INTO hogwarts_student VALUES (516740,"Seamus", "Finnigan", "516740@student.hogwarts.edu.uk");
INSERT INTO hogwarts_student VALUES (516750,"Hermione", "Granger", "516750@student.hogwarts.edu.uk");
INSERT INTO hogwarts_student VALUES (516770,"Ron", "Weasley", "516770@student.hogwarts.edu.uk");

INSERT INTO hogwarts_unit VALUES ("Core001","Astronomy 1");
INSERT INTO hogwarts_unit VALUES ("Core002","Charms 1");
INSERT INTO hogwarts_unit VALUES ("Core004","Herbology");
INSERT INTO hogwarts_unit VALUES ("Core010","Defence against the dark arts 1");


INSERT INTO hogwarts_offering VALUES ("Core001","Term 1 - 1991");
INSERT INTO hogwarts_offering VALUES ("Core002","Term 2 - 1991");
INSERT INTO hogwarts_offering VALUES ("Core004","Term 4 - 1991");
INSERT INTO hogwarts_offering VALUES ("Core010","Term 3 - 1991");

INSERT INTO hogwarts_enrolment  VALUES (1,516770, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (2,516740, "Core001", "Term 1 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (3,516710, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (4,516710, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (5,516740, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (6,516710, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (7,516770, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (8,516720, "Core001", "Term 1 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (9,516710, "Core001", "Term 1 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (10,516730, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (11,516750, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (12,516750, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (13,516730, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (14,516770, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (15,516750, "Core001", "Term 1 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (16,516720, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (17,516730, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (18,516740, "Core004", "Term 4 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (19,516740, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (20,516720, "Core002", "Term 2 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (21,516750, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (22,516720, "Core010", "Term 3 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (23,516730, "Core001", "Term 1 - 1991");
INSERT INTO hogwarts_enrolment  VALUES (24,516770, "Core001", "Term 1 - 1991");

INSERT INTO hogwarts_grade VALUES (1,"C+");
INSERT INTO hogwarts_grade VALUES (2,"B");
INSERT INTO hogwarts_grade VALUES (3,"A+");
INSERT INTO hogwarts_grade VALUES (4,"A+");
INSERT INTO hogwarts_grade VALUES (5,"B");
INSERT INTO hogwarts_grade VALUES (6,"A+");
INSERT INTO hogwarts_grade VALUES (7,"C+");
INSERT INTO hogwarts_grade VALUES (8,"B");
INSERT INTO hogwarts_grade VALUES (9,"A+");
INSERT INTO hogwarts_grade VALUES (10,"C+");
INSERT INTO hogwarts_grade VALUES (11,"A+");
INSERT INTO hogwarts_grade VALUES (12,"A+");
INSERT INTO hogwarts_grade VALUES (13,"C+");
INSERT INTO hogwarts_grade VALUES (14,"C+");
INSERT INTO hogwarts_grade VALUES (15,"A+");
INSERT INTO hogwarts_grade VALUES (16,"B");
INSERT INTO hogwarts_grade VALUES (17,"B");
INSERT INTO hogwarts_grade VALUES (18,"A");
INSERT INTO hogwarts_grade VALUES (19,"A+");
INSERT INTO hogwarts_grade VALUES (20,"C+");
INSERT INTO hogwarts_grade VALUES (21,"A+");
INSERT INTO hogwarts_grade VALUES (22,"B");
INSERT INTO hogwarts_grade VALUES (23,"B");
INSERT INTO hogwarts_grade VALUES (24,"C+");


-- DQL 1
SELECT * FROM hogwarts_student;
-- DQL 2
SELECT * FROM hogwarts_offering;
-- DQL 3
SELECT unitcode FROM hogwarts_unit WHERE unitname LIKE '%g%';
-- DQL 4
SELECT grade, COUNT(`enrolment id`) AS counts FROM hogwarts_grade
GROUP BY grade
ORDER BY grade ASC;

-- Follow 1
SELECT CONCAT(s.`given names`, ' ', s.`family name`), e.unitcode FROM hogwarts_student s
LEFT JOIN hogwarts_enrolment e ON e.`student id` = s.`student id`

-- Follow 2
SELECT CONCAT(s.`given names`, ' ', s.`family name`), u.unitname FROM hogwarts_student s
LEFT JOIN hogwarts_enrolment e ON e.`student id` = s.`student id`
LEFT JOIN hogwarts_unit u ON u.unitcode = e.unitcode

-- Follow 3
SELECT CONCAT(s.`given names`, ' ', s.`family name`), g.grade, COUNT(g.`enrolment id`) FROM hogwarts_student s
LEFT JOIN hogwarts_enrolment e ON e.`student id` = s.`student id`
LEFT JOIN hogwarts_grade g ON g.`enrolment id` = e.`enrolment id`
GROUP BY CONCAT(s.`given names`, ' ', s.`family name`), grade
ORDER BY CONCAT(s.`given names`, ' ', s.`family name`), grade ASC;
