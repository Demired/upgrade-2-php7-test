FROM centos:7


# 运行所需
ENV PHPIZE_DEPS\
    autoconf \
    file \
    gcc-c++ \
    gcc \
    glibc-devel \
    make

# 安装所需
RUN yum -y update && yum install -y \
    $PHPIZE_DEPS \
    curl-devel \
    libedit \
    libxml2-devel \
    bzip2 \
    bzip2-devel \
    openssl-devel \
    ImageMagick-devel && rm -rf /var/cache/yum/*

ENV PHP_VERSION 7.1.3
ENV PHP_URL="http://cn2.php.net/distributions/php-7.1.3.tar.gz"
ENV PHP_SHA256="4bfadd0012b966eced448497272150ffeede13136a961aacb9e71553b8e929ec"
ENV PHP_MD5="d3294c06b207ee23126210f8276032bb"

RUN fetchDeps=' \
        wget \
        '; \
    extractDeps=' \
        unzip \
        '; \
    yum install -y $fetchDeps $extractDeps; \
    rm -rf /var/cache/yum/*; \
    \
    cd /; \
    \
    wget -O php-7.1.3.tar.gz "$PHP_URL"; \
    \
    if [ -n "$PHP_SHA256" ]; then \
  		echo "$PHP_SHA256 *php-7.1.3.tar.gz" | sha256sum -c -; \
  	fi; \
    \
    if [ -n "$PHP_MD5" ]; then \
      echo "$PHP_MD5 *php-7.1.3.tar.gz" | md5sum -c -; \
    fi; \
    cd /; \
    # zeromq
    wget http://cdn.0x8c.com/zeromq-4.2.1.tar.gz \
    && tar -zxf zeromq-4.2.1.tar.gz && rm -rf zeromq-4.2.1.tar.gz\
    && cd zeromq-4.2.1 \
    && ./configure --prefix=/usr/local/zmq \
    && make -j20 && make install; \
    \
    cd /; \
    # libmemcached
    wget https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz \
    && tar -zxf libmemcached-1.0.18.tar.gz && rm -rf libmemcached-1.0.18.tar.gz\
    && cd libmemcached-1.0.18 \
    && ./configure --prefix=/usr/local/libmemcached \
    && make -j20 && make install;

ENV PHP_INI_DIR="/usr/local/etc/php"

RUN mkdir -p $PHP_INI_DIR/conf.d;

RUN tar -zxf php-7.1.3.tar.gz && rm -rf php-7.1.3.tar.gz; \
    \
    cd /php-7.1.3/ext; \
    \
    # memcached
    \
    wget https://pecl.php.net/get/memcached-3.0.3.tgz \
    && tar -zxf memcached-3.0.3.tgz && rm -rf memcached-3.0.3.tgz; \
    \
    # apcu
    \
    wget https://pecl.php.net/get/apcu-5.1.8.tgz \
    && tar -zxf apcu-5.1.8.tgz && rm -rf apcu-5.1.8.tgz; \
    \
    # zmq
    wget https://pecl.php.net/get/zmq-1.1.3.tgz \
    && tar -zxf zmq-1.1.3.tgz && rm -rf zmq-1.1.3.tgz; \
    \
    # redis
    wget https://pecl.php.net/get/redis-3.1.1.tgz \
    && tar -zxf redis-3.1.1.tgz && rm -rf redis-3.1.1.tgz; \
    \
    # imagick
    wget https://pecl.php.net/get/imagick-3.4.3.tgz \
    && tar -zxf imagick-3.4.3.tgz && rm -rf imagick-3.4.3.tgz; \
    \
    # igbinary7
    wget https://codeload.github.com/igbinary/igbinary7/zip/master \
    && unzip master && rm -rf master; \
    \
    cd /php-7.1.3; \
    rm ./configure; \
    ./buildconf --force; \
    \
    ./configure \
    --with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
    --enable-exif \
    --enable-redis \
    --enable-mysqlnd \
    --enable-fpm \
    --enable-apcu \
    --enable-bcmath \
    --with-mysqli \
    --enable-mbstring \
    --with-curl \
    --with-imagick \
    --with-openssl \
    --enable-igbinary \
    --enable-sockets \
    --enable-zip \
    --with-zlib \
    --with-zmq=/usr/local/zmq/ \
    --with-bz2=/usr/bin/bzip2 \
    --with-libmemcached-dir=/usr/local/libmemcached \
    --enable-memcached \
    --disable-memcached-sasl \
    --enable-opcache \
    --enable-fpm;\
    \
    make -j8; \
    make install; \
    cd /; \
    rm -rf php-7.1.3
