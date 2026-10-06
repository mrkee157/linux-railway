# Sử dụng Ubuntu làm nền tảng hệ điều hành
FROM ubuntu:22.04

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

# Tạo user 
RUN useradd -rm -d /home/kee -s /bin/bash -g root -G sudo -u 1000 kee && \
    echo 'kee:kee157' | chpasswd || true

# Đảm bảo thư mục SSH và quyền được cấp đúng
RUN mkdir -p /home/kee/.ssh && chown -R kee:root /home/kee

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
