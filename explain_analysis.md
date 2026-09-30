# Phân tích EXPLAIN trước và sau tối ưu

## 1. Trước khi tối ưu

Truy vấn cũ sử dụng YEAR(created_at) và MONTH(created_at) trong WHERE. Đây là dạng Non-SARGable vì hàm được áp dụng trực tiếp lên cột created_at. Khi đó MySQL khó sử dụng B-Tree Index trên created_at để tìm trực tiếp khoảng dữ liệu cần thiết và có thể phải quét rất nhiều dòng.

Kết quả EXPLAIN thường có type = ALL, thể hiện Full Table Scan. Cột rows có thể rất lớn, gần với số dòng của bảng.

## 2. Sau khi tối ưu

Tạo Composite Index:

`idx_type_date(transaction_type, created_at)`

Điều kiện ngày được viết thành khoảng:

`created_at >= '2026-06-01 00:00:00' AND created_at < '2026-07-01 00:00:00'`

Cách viết này SARGable và cho phép MySQL tìm kiếm theo Index. EXPLAIN dự kiến có type = range hoặc ref, possible_keys/key có thể hiển thị `idx_type_date`, và rows giảm đáng kể.

Kết luận: truy vấn mới giảm lượng dữ liệu phải quét và giúp giảm tải CPU, đồng thời hạn chế thời gian giữ tài nguyên của bảng.
