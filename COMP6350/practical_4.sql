# Q1
SELECT COUNT(`enrolment id`) FROM hogwarts_enrolment;
SELECT COUNT(hogwarts_grade.grade) FROM hogwarts_grade;

SELECT e.`enrolment id`, g.grade FROM hogwarts_enrolment e
LEFT JOIN hogwarts_grade g ON g.`enrolment id` = e.`enrolment id`;

# Q2
SELECT e.`enrolment id`, g.grade FROM hogwarts_enrolment e
RIGHT JOIN hogwarts_grade g ON g.`enrolment id` = e.`enrolment id`;
# Because we graded the enrolment without a grade.

# Q3
SELECT * FROM hogwarts_student
WHERE `given names` LIKE '%a%' OR `family name` LIKE '%a%'
AND `student id` IN (
    SELECT `student id` FROM hogwarts_enrolment
    GROUP BY `student id`
    HAVING COUNT(`enrolment id`) > 3
);

# Q4
SELECT s.`student id` AS id, `given names` AS NAME FROM hogwarts_student s
WHERE s.`student id` IN (
    SELECT `student id` FROM hogwarts_enrolment
    GROUP BY `student id`
    HAVING COUNT(`enrolment id`) > 1
)
UNION
SELECT u.unitcode AS id, unitname AS NAME FROM hogwarts_unit u
WHERE u.unitcode IN (
    SELECT unitcode FROM hogwarts_enrolment
    GROUP BY unitcode
    HAVING COUNT(`enrolment id`) > 1
);