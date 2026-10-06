# Sử dụng Ubuntu làm nền tảng hệ điều hành
FROM ubuntu:22.04

# Tránh bị hỏi các câu hỏi cấu hình (interactive prompts) khi cài đặt phần mềm
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật hệ thống và cài đặt OpenSSH Server, sudo, curl, git và các tiện ích cơ bản
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    git \
    wget \
    net-tools \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục chạy cho SSH daemon
RUN mkdir /var/run/sshd

# Tạo một user mới tên là "vpsuser" và mật khẩu là "vpspassword123" 
# (Bạn nên đổi lại thông tin này cho bảo mật hơn sau khi vào được)
RUN useradd -rm -d /home/vpsuser -s /bin/bash -g root -G sudo -u 1000 vpsuser
RUN echo 'kee:kee157' | chpasswd

# Cho phép root đăng nhập qua SSH (tùy chọn, ở đây dùng vpsuser an toàn hơn)
# Mở cổng SSH trong container
EXPOSE 22

# Chạy script khởi động SSH và giữ container sống bằng một lệnh foreground
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
