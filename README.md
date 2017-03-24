apcu
bcmath
bz2
Core
ctype
curl
date
dom
exif
fileinfo
filter
hash
iconv
igbinary
imagick
json
libxml
mbstring
mysqli
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
redis
Reflection
session
SimpleXML
sockets
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zip
zlib
zmq

apc 更新为apcu
ereg 不支持
hybrid 找不到
mcrypt 找不到
xlog 不支持
xxtea 找不到
protobuf 装不上
xhprof 无法静态编译

igbinary7拓展有php7版本但需要在github上拉取

php7 已经移除了ereg拓展，ereg能完成的工作preg_match也能完成

run yum -y update && yum install -y autoconf file gcc-c++ gcc glibc-devel make curl-devel libedit libxml2-devel wget bzip2 bzip2-devel openssl-devel unzip ImageMagick-devel && wget http://cn2.php.net/distributions/php-7.1.3.tar.gz && tar -zxf php-7.1.3.tar.gz && rm -rf php-7.1.3.tar.gz && cd /php-7.1.3/ext/ && wget https://pecl.php.net/get/memcached-3.0.3.tgz && tar -zxf memcached-3.0.3.tgz && rm -rf memcached-3.0.3.tgz && wget https://pecl.php.net/get/apcu-5.1.8.tgz && tar -zxf apcu-5.1.8.tgz && rm -rf apcu-5.1.8.tgz && wget https://pecl.php.net/get/zmq-1.1.3.tgz && tar -zxf zmq-1.1.3.tgz && rm -rf zmq-1.1.3.tgz && wget https://pecl.php.net/get/redis-3.1.1.tgz && tar -zxf redis-3.1.1.tgz && rm -rf redis-3.1.1.tgz && wget https://pecl.php.net/get/imagick-3.4.3.tgz && tar -zxf imagick-3.4.3.tgz && rm -rf imagick-3.4.3.tgz && wget https://codeload.github.com/igbinary/igbinary7/zip/master && unzip master && rm -rf master && cd / && wget http://cdn.0x8c.com/zeromq-4.2.1.tar.gz && tar -zxf zeromq-4.2.1.tar.gz && cd zeromq-4.2.1 && ./configure --prefix=/usr/local/zmq && make -j8 && make install && cd / && wget https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz && tar -zxf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18 && ./configure && make -j20 && make install && cd /php-7.1.3 && rm -rf ./configure && ./buildconf --force && ./configure --prefix=/usr/local/php -enable-exif --enable-redis --enable-mysqlnd --with-config-file-path=/usr/local/php/ini --enable-fpm --enable-apcu --enable-bcmath --with-bz2=/usr/bin/bzip2 --with-mysqli --enable-mbstring --with-curl --with-imagick --with-openssl --enable-igbinary --enable-sockets --enable-zip --with-zlib --with-zmq=/usr/local/zmq/ --enable-memcached --disable-memcached-sasl  && make -j20 && make install

xhprof 拓展无法静态编译
https://github.com/Yaoguais/phpng-xhprof/archive/master.zip
