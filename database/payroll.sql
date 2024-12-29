Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25
Server version: 8.0.39 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use payroll_system
Database changed
mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
| 33 | yash       | sd        | cse        | ceo         |   1000000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.01 sec)

mysql> select * from payroll;
Empty set (0.00 sec)

mysql> select * from users;
+----+---------------+----------------------------+--------------------------------------------------------------+
| id | username      | email                      | password                                                     |
+----+---------------+----------------------------+--------------------------------------------------------------+
|  1 | Shreeharsha   | shreeharsha@gmail.com      | $2a$10$GYG2o9.ajOPHixPEljZQ5.1l7Dx./Xp0RdqtdRuppPlXR7u24a.mi |
|  2 | Sampreeth     | sampreeth@gmail.com        | $2a$10$SpyzX8WPgUnafUkZKuZgnOspCvzHVwTbvJt4gG5Ud9NYUXkwL1WX. |
|  3 | Shreyas       | shreyas@gmail.com          | $2a$10$UHw9rX8x3ni.fPPYUpIYEe9uZ7uXNlO.TLeoRqjwAArnxAdqJ3Vki |
|  4 | Shreyasrk     | shreyasrk@gmail.com        | $2a$10$PL/piXNlEHiRLnzT.irKEOFtJ8xgZPJ6vabJ0UnLpkLT.vNRDD2W. |
|  5 | Shreevardhan  | shreevardhanrao@gmail.com  | $2a$10$Jn967Z8Wl09wU1AF0n9qv.JOFSekAdVeJmjB3IaZTHFx7Dp5rfkk2 |
|  6 | shreevardhani | shreevardhanirao@gmail.com | $2a$10$JFjWBzUE1IWZgqCmouXVGua3Na3xVqyGsMdkeBt6/ziuo02LYYEje |
|  7 | shriharsha    | shriharsha@gmail.com       | $2a$10$HmEPwV2fdLjW700sLL1bceznWTgf9mFWZg5Pe5ObspmoAAIQ97ING |
|  8 | sampreethi    | sampreethi@gmail.com       | $2a$10$DKXWy5TVJP2RztuwvOtvX.MHSOOWkfNK8Wv/NrQl6LuEop5wwn3xy |
|  9 | srk           | srk@gmail.com              | $2a$10$OJbtxG5tooJN8Y8KVXrfs.BwnVWcbQEaqnicVFNAb2kLaGGvfI1QG |
| 10 | sreeleela     | sreleela@gmail.com         | $2a$10$sTR4RKZxy6OIkP2OJpQb7OQjMtDb.h7KdQJ81TfNGb1154Qhc4Nm. |
| 11 | user          | user@gmail.com             | $2a$10$d.gEKPJR6JD84.9Zd.g71eQttB3Nq9TuHvwn5IhTZXokaJcAD1x5y |
| 12 | darshan       | darshan@gmail.com          | $2a$10$r3Q5SHMFT6nhBGpItkHIwuaT9kiVkjbv67UkBy3W3.e2dWZ9I/TMi |
| 13 | satwik        | satwik@gmail.com           | $2a$10$zW4TJmALpiIqmBUyo9YrC.zv/ApVAgT2PUTeRGhMPXXAVUr6z71Qa |
+----+---------------+----------------------------+--------------------------------------------------------------+
13 rows in set (0.01 sec)

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
| 33 | yash       | sd        | cse        | ceo         |   1000000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> select * from payroll;
+--------+---------+---------+------------+------------+------------+
| emp_id | tax     | bonus   | deductions | net_salary | pay_date   |
+--------+---------+---------+------------+------------+------------+
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
+--------+---------+---------+------------+------------+------------+
2 rows in set (0.00 sec)

mysql> select * from users;
+----+---------------+----------------------------+--------------------------------------------------------------+
| id | username      | email                      | password                                                     |
+----+---------------+----------------------------+--------------------------------------------------------------+
|  1 | Shreeharsha   | shreeharsha@gmail.com      | $2a$10$GYG2o9.ajOPHixPEljZQ5.1l7Dx./Xp0RdqtdRuppPlXR7u24a.mi |
|  2 | Sampreeth     | sampreeth@gmail.com        | $2a$10$SpyzX8WPgUnafUkZKuZgnOspCvzHVwTbvJt4gG5Ud9NYUXkwL1WX. |
|  3 | Shreyas       | shreyas@gmail.com          | $2a$10$UHw9rX8x3ni.fPPYUpIYEe9uZ7uXNlO.TLeoRqjwAArnxAdqJ3Vki |
|  4 | Shreyasrk     | shreyasrk@gmail.com        | $2a$10$PL/piXNlEHiRLnzT.irKEOFtJ8xgZPJ6vabJ0UnLpkLT.vNRDD2W. |
|  5 | Shreevardhan  | shreevardhanrao@gmail.com  | $2a$10$Jn967Z8Wl09wU1AF0n9qv.JOFSekAdVeJmjB3IaZTHFx7Dp5rfkk2 |
|  6 | shreevardhani | shreevardhanirao@gmail.com | $2a$10$JFjWBzUE1IWZgqCmouXVGua3Na3xVqyGsMdkeBt6/ziuo02LYYEje |
|  7 | shriharsha    | shriharsha@gmail.com       | $2a$10$HmEPwV2fdLjW700sLL1bceznWTgf9mFWZg5Pe5ObspmoAAIQ97ING |
|  8 | sampreethi    | sampreethi@gmail.com       | $2a$10$DKXWy5TVJP2RztuwvOtvX.MHSOOWkfNK8Wv/NrQl6LuEop5wwn3xy |
|  9 | srk           | srk@gmail.com              | $2a$10$OJbtxG5tooJN8Y8KVXrfs.BwnVWcbQEaqnicVFNAb2kLaGGvfI1QG |
| 10 | sreeleela     | sreleela@gmail.com         | $2a$10$sTR4RKZxy6OIkP2OJpQb7OQjMtDb.h7KdQJ81TfNGb1154Qhc4Nm. |
| 11 | user          | user@gmail.com             | $2a$10$d.gEKPJR6JD84.9Zd.g71eQttB3Nq9TuHvwn5IhTZXokaJcAD1x5y |
| 12 | darshan       | darshan@gmail.com          | $2a$10$r3Q5SHMFT6nhBGpItkHIwuaT9kiVkjbv67UkBy3W3.e2dWZ9I/TMi |
| 13 | satwik        | satwik@gmail.com           | $2a$10$zW4TJmALpiIqmBUyo9YrC.zv/ApVAgT2PUTeRGhMPXXAVUr6z71Qa |
+----+---------------+----------------------------+--------------------------------------------------------------+
13 rows in set (0.00 sec)

mysql> select * from payroll;
+--------+---------+---------+------------+------------+------------+
| emp_id | tax     | bonus   | deductions | net_salary | pay_date   |
+--------+---------+---------+------------+------------+------------+
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
+--------+---------+---------+------------+------------+------------+
5 rows in set (0.01 sec)

mysql> select * from payroll;
+--------+---------+---------+------------+------------+------------+
| emp_id | tax     | bonus   | deductions | net_salary | pay_date   |
+--------+---------+---------+------------+------------+------------+
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-29 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
|     33 | 5000.00 | 2000.00 |    1000.00 |  994000.00 | 2024-10-30 |
+--------+---------+---------+------------+------------+------------+
15 rows in set (0.00 sec)

mysql> select * from payroll;
Empty set (0.00 sec)

mysql> select * from employees;
Empty set (0.01 sec)

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
| 37 | shashank   | naqdig    | cse        | ceo         |    150000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> ALTER TABLE employees AUTO_INCREMENT = 1;
Query OK, 0 rows affected (0.21 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
| 37 | shashank   | naqdig    | cse        | ceo         |    150000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> select * from employees;
Empty set (0.00 sec)

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
| 38 | yash       | singh     | cse        | ceo         |   1500000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> DELETE FROM employees;
Query OK, 1 row affected (0.01 sec)

mysql> ALTER TABLE employees AUTO_INCREMENT = 1;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
|  1 | shashank   | naqdig    | cse        | ceo         |    150000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> select * from employees;
Empty set (0.00 sec)

mysql> select * from employees;
+----+------------+-----------+------------+-------------+--------------+-----------+
| id | first_name | last_name | department | designation | basic_salary | hire_date |
+----+------------+-----------+------------+-------------+--------------+-----------+
|  2 | Darshan    | brungi    | cse        | employee    |   1000000.00 | NULL      |
+----+------------+-----------+------------+-------------+--------------+-----------+
1 row in set (0.00 sec)

mysql> SHOW CREATE TABLE employees;
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table

                                                                                                                |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| employees | CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `basic_salary` decimal(10,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM employees;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.03 sec)

mysql>