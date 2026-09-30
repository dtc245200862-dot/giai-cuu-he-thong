-- PAYFLOW - QUERY OPTIMIZATION
CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- Truy vấn cũ: Non-SARGable, có thể gây Full Table Scan
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- Composite B-Tree Index phục vụ điều kiện lọc
CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);

-- Truy vấn mới: SARGable, sử dụng khoảng thời gian
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

-- Có thể dùng để đo thời gian thực thi trên môi trường MySQL hỗ trợ profiling
SET profiling = 1;

SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at < '2026-07-01 00:00:00';

SHOW PROFILES;
