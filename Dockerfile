# ssr-with-net-speeder
FROM ubuntu:14.04.5
MAINTAINER uncia

RUN apt-get update && \
apt-get clean  

RUN apt-get install -y openssh-server python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc && \
apt-get clean

RUN echo "root:password"|chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

#install libsodium support chacha20
RUN wget --no-check-certificate -O libsodium-1.0.16.tar.gz https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz &&\
    tar zxf libsodium-1.0.16.tar.gz && rm -rf libsodium-1.0.16.tar.gz
WORKDIR /libsodium-1.0.16
RUN ./configure && make && make install
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf
RUN ldconfig

RUN git clone -b akkariiin/master https://github.com/shadowsocksrr/shadowsocksr.git uncia
RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

# Tear down building environment and delete git repository
WORKDIR /
RUN rm -rf net-speeder
RUN rm -rf libsodium-1.0.16

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
