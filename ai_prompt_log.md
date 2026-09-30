# AI Prompt Log - PayFlow

## Prompt 1
Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng nhưng trong WHERE lại viết YEAR(created_at) = 2026, tại sao MySQL khó sử dụng Index và có thể phải quét toàn bộ bảng?

## Prompt 2
SARGable trong SQL là gì? Tại sao điều kiện dạng khoảng trên cột ngày tháng có thể giúp B-Tree Index hoạt động tốt hơn?

## Prompt 3
Khi thiết kế Composite Index trên (transaction_type, created_at), thứ tự các cột có quan trọng không? Vì sao?

## Prompt 4
Trong EXPLAIN của MySQL, các giá trị type như ALL, index, range, ref và const có ý nghĩa gì?

## Prompt 5
Trong kết quả EXPLAIN, `Using index condition` khác `Using index` như thế nào?

## Prompt 6
Index Seek và Index Scan khác nhau như thế nào? B-Tree hỗ trợ việc tìm kiếm dữ liệu trong Index ra sao?

## Prompt 7
Nếu bảng Transactions có INSERT/UPDATE/DELETE hàng nghìn lần mỗi giây thì việc thêm nhiều Index có thể gây ảnh hưởng gì đến hiệu năng?

## Prompt 8
Làm thế nào để xem thời gian thực thi câu lệnh trong MySQL thay vì chỉ xem Execution Plan? Có thể sử dụng SET profiling = 1 trong môi trường hỗ trợ profiling không?
