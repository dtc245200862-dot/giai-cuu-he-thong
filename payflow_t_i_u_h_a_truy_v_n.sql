-- HỆ THỐNG PAYFLOW - SCRIPT TỐI ƯU HÓA HIỆU SUẤT TRUY VẤN
-- Mục tiêu: Khắc phục lỗi Quét toàn bảng (Full Table Scan) và loại bỏ Non-SARGable functions.

USE payflow_db;

-- ========================================================
-- BƯỚC 1: THIẾT KẾ VÀ TẠO COMPOSITE INDEX
-- ========================================================
-- Tạo Index kết hợp trên hai cột transaction_type và created_at 
-- để phục vụ tối ưu cho mệnh đề WHERE và đảm bảo tính chọn lọc (Selectivity).
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- ========================================================
-- BƯỚC 2: TRUY VẤN ĐÃ ĐƯỢC TÁI CẤU TRÚC (SARGABLE QUERY)
-- ========================================================
-- Sử dụng EXPLAIN để kiểm tra kế hoạch thực thi trước khi chạy thực tế
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';