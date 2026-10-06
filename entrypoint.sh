#!/bin/bash
# Khởi động dịch vụ SSH ở chế độ nền
service ssh start

# Đọc cổng do Railway cấp hoặc dùng mặc định 22 bên trong container
echo "SSH Server started successfully inside container."

# Giữ container luôn chạy bằng cách tail file log hoặc sleep vô tận
tail -f /dev/null
