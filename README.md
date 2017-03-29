## 安装完毕后拥有的全部拓展

```
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
```

## 有问题的拓展

1. apc 更新为apcu
2. ereg 不支持
3. hybrid 找不到
4. mcrypt 找不到
5. xlog 不支持
6. xxtea 找不到
7. protobuf 装不上
8. xhprof 装上不能用

## igbinary拓展pecl上的不能用，需要从github拉取php7版本，但此本编译仍有警告，原因正在排查

php7 已经移除了ereg拓展，ereg能完成的工作preg_match也能完成

```shell
yum -y update \
&& yum install -y autoconf file gcc-c++ gcc glibc-devel make curl-devel libedit libxml2-devel wget bzip2 bzip2-devel openssl-devel unzip ImageMagick-devel \
&& wget http://cn2.php.net/distributions/php-7.1.3.tar.gz \
&& tar -zxf php-7.1.3.tar.gz \
&& rm -rf php-7.1.3.tar.gz \
&& cd /php-7.1.3/ext/ \
&& wget https://pecl.php.net/get/memcached-3.0.3.tgz \
&& tar -zxf memcached-3.0.3.tgz && rm -rf memcached-3.0.3.tgz \
&& wget https://pecl.php.net/get/apcu-5.1.8.tgz \
&& tar -zxf apcu-5.1.8.tgz && rm -rf apcu-5.1.8.tgz \
&& wget https://pecl.php.net/get/zmq-1.1.3.tgz \
&& tar -zxf zmq-1.1.3.tgz && rm -rf zmq-1.1.3.tgz \
&& wget https://pecl.php.net/get/redis-3.1.1.tgz \
&& tar -zxf redis-3.1.1.tgz && rm -rf redis-3.1.1.tgz \
&& wget https://pecl.php.net/get/imagick-3.4.3.tgz \
&& tar -zxf imagick-3.4.3.tgz && rm -rf imagick-3.4.3.tgz \
&& wget https://github.com/Demired/igbinary7/archive/v1.0.tar.gz \
&& tar zxf v1.0.tar.gz && rm -rf v1.0.tar.gz && cd / \
&& wget http://cdn.0x8c.com/zeromq-4.2.1.tar.gz \
&& tar -zxf zeromq-4.2.1.tar.gz && cd zeromq-4.2.1 \
&& ./configure --prefix=/usr/local/zmq \
&& make -j8 && make install && cd / \
&& wget https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz \
&& tar -zxf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18 \
&& ./configure && make -j20 && make install \
&& cd /php-7.1.3 \
&& rm -rf ./configure && ./buildconf --force \
&& ./configure \
--prefix=/usr/local/php \
--enable-exif \
--enable-redis \
--enable-mysqlnd \
--with-config-file-path=/usr/local/php/ini \
--enable-fpm \
--enable-apcu \
--enable-bcmath \
--with-bz2=/usr/bin/bzip2 \
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
--enable-memcached \
--disable-memcached-sasl  \
&& make -j20 && make install
&& cp ./php.ini-development /usr/local/php/lib/php.ini
&& cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
&& cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
&& cp -R ./sapi/fpm/php-fpm /etc/init.d/php-fpm
```

xhprof 拓展无法静态编译

```
https://github.com/Yaoguais/phpng-xhprof/archive/master.zip
```

#分割线

## yum package

```
yum -y update && yum install -y autoconf file gcc-c++ gcc glibc-devel make curl-devel libedit libxml2-devel wget bzip2 bzip2-devel openssl-devel unzip ImageMagick-devel
```

## lib package

```
libzmq https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz
libmemcached https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz
```

## php sound code
```
php7.1.3 http://cn2.php.net/distributions/php-7.1.3.tar.gz
```

## php extension package

```
memcached https://pecl.php.net/get/memcached-3.0.3.tgz
apcu https://pecl.php.net/get/apcu-5.1.8.tgz
zmq https://pecl.php.net/get/zmq-1.1.3.tgz
redis https://pecl.php.net/get/redis-3.1.1.tgz
imagick https://pecl.php.net/get/imagick-3.4.3.tgz
igbinary7 https://github.com/Demired/igbinary7/archive/v1.0.tar.gz
```

## libzmq configure

```
./configure --prefix=/usr/local/zmq && make -j8 && make install
```

## libmemcached configure

```$xslt
./configure && make -j8 && make install
```

## php configure

```
./configure \
--prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/lib \
--enable-exif \
--enable-redis \
--enable-mysqlnd \
--enabele-fpm
--enabele-apcu
--enable-bcmath \
--with-bz2=/usr/bin/bzip2 \
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
--enable-memcached \
--disable-memcached-sasl  
&& make -j20 && make install

```

## php config file

```
cp ./php.ini-development /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
cp -R ./sapi/fpm/php-fpm /etc/init.d/php-fpm
```

## php.ini

> 5.6版本ini文件来源于www机器,7.1版本ini文件来源于源码生产环境配置文件

### 5.6存在但7.1不存在的全部配置

```
"zend.ze1_compatibility_mode": "Off",
"asp_tags": "Off",
"y2k_compliance": "On",
"allow_call_time_pass_reference": "Off",
"safe_mode": "Off",
"safe_mode_gid": "Off",
"safe_mode_include_dir": "",
"safe_mode_exec_dir": "",
"safe_mode_allowed_env_vars": "PHP_",
"safe_mode_protected_env_vars": "LD_LIBRARY_PATH",
"exit_on_timeout": "On",
"register_globals": "Off",
"register_long_arrays": "Off",
"magic_quotes_gpc": "Off",
"magic_quotes_runtime": "Off",
"magic_quotes_sybase": "Off",
"always_populate_raw_post_data": "-1",
"extension_dir": "/usr/local/php/lib/",
"define_syslog_variables": "Off",
"mysql.allow_persistent": "On",
"mysql.max_persistent": "-1",
"mysql.max_links": "-1",
"mysql.default_port": "",
"mysql.default_socket": "",
"mysql.default_host": "",
"mysql.default_user": "",
"mysql.default_password": "",
"mysql.connect_timeout": "60",
"mysql.trace_mode": "Off",
"msql.allow_persistent": "On",
"msql.max_persistent": "-1",
"msql.max_links": "-1",
"sybase.allow_persistent": "On",
"sybase.max_persistent": "-1",
"sybase.max_links": "-1",
"sybase.min_error_severity": "10",
"sybase.min_message_severity": "10",
"sybase.compatability_mode": "Off",
"sybct.allow_persistent": "On",
"sybct.max_persistent": "-1",
"sybct.max_links": "-1",
"sybct.min_server_severity": "10",
"sybct.min_client_severity": "10",
"browscap": "/home/codebase/server-config/php_browscap.ini",
"ifx.default_host": "",
"ifx.default_user": "",
"ifx.default_password": "",
"ifx.allow_persistent": "On",
"ifx.max_persistent": "-1",
"ifx.max_links": "-1",
"ifx.textasvarchar": "0",
"ifx.byteasvarchar": "0",
"ifx.charasvarchar": "0",
"ifx.blobinfile": "0",
"ifx.nullformat": "0",
"session.bug_compat_42": "0",
"session.bug_compat_warn": "1",
"session.entropy_length": "0",
"session.entropy_file": "",
"session.hash_function": "0",
"session.hash_bits_per_character": "5",
"url_rewriter.tags": "a",
"mssql.allow_persistent": "On",
"mssql.max_persistent": "-1",
"mssql.max_links": "-1",
"mssql.min_error_severity": "10",
"mssql.min_message_severity": "10",
"mssql.compatability_mode": "Off",
"mssql.secure_connection": "Off",
"apc.enable_cli": "1",
"apc.enable_opcode_cache": "0",
"apc.include_once_override": "Off",
"apc.shm_size": "1024M",
"apc.preload_path": "/home/codebase",
"apc.gc_ttl": "900",
"apc.slam_defense": "0",
"apc.num_files_hint": "1024",
"apc.user_entries_hint": "65535",
"apc.user_ttl": "3600",
"apc.ttl": "3600",
"apc.stat": "1",
"apc.stat_ctime": "1",
"apc.serializer": "igbinary",
"apc.shm_strings_buffer": "0",
"zend_extension": "/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/opcache.so",
"opcache.memory_consumption": "64",
"opcache.interned_strings_buffer": "8",
"opcache.max_accelerated_files": "1024",
"opcache.revalidate_freq": "2",
"opcache.fast_shutdown": "1",
"opcache.enable_cli": "1",
"opcache.error_log": "/home/logs/opcache.log",
"yac.enable": "1",
"yac.keys_memory_size": "8M",
"yac.values_memory_size": "1024M",
"yac.compress_threshold": "1024",
"extension": "/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226/xlog.so",
"xlog.enabled": "1",
"http.etag.mode": "CRC32B",
"memcached.compression_threshold": "2048",
"mongo.native_long": "1",
"mongo.utf8": "0",
"mongo.chunk_size": "2097152",
"mongo.allow_persistent": "0",
"xhprof.output_dir": "/home/logs/xhprof"
```

其中
safe_mode已在php5.4被移除
mysql已在php7.0被移除
mssql不需要
mongo因为版本差异太大已被遗弃
xhprof暂未找到能用的版本
sybase已在php7.0移除
sybct已在php7.0移除
ifx不需要
yac不需要
xlog不存在
y2k_compliance 5.4中已被移除
zend.ze1_compatibility_mode 5.3中已移除
allow_call_time_pass_reference 5.4中已移除
register_globals 5.4中已移除
register_long_arrays 5.4中已移除
magic_quotes_gpc 5.4中已移除
magic_quotes_runtime 5.4中已移除
magic_quotes_sybase 5.4中已移除
define_syslog_variables 5.4中已移除
```
"asp_tags": "Off",
"exit_on_timeout": "On",
"always_populate_raw_post_data": "-1",
"extension_dir": "/usr/local/php/lib/",
"browscap": "/home/codebase/server-config/php_browscap.ini",
"session.bug_compat_42": "0",
"session.bug_compat_warn": "1",
"session.entropy_file": "",
"session.entropy_length": "0",
"session.hash_function": "0",
"session.hash_bits_per_character": "5",
"url_rewriter.tags": "a",
"apc.enable_cli": "1",
"apc.enable_opcode_cache": "0",
"apc.include_once_override": "Off",
"apc.shm_size": "1024M",
"apc.preload_path": "/home/codebase",
"apc.gc_ttl": "900",
"apc.slam_defense": "0",
"apc.num_files_hint": "1024",
"apc.user_entries_hint": "65535",
"apc.user_ttl": "3600",
"apc.ttl": "3600",
"apc.stat": "1",
"apc.stat_ctime": "1",
"apc.serializer": "igbinary",
"apc.shm_strings_buffer": "0",

"zend_extension": "opcache.so",
"opcache.enable": "1",
"opcache.enable_cli": "1",
"opcache.memory_consumption": "64",
"opcache.interned_strings_buffer": "8",
"opcache.max_accelerated_files": "1024",
"opcache.revalidate_freq": "2",
"opcache.fast_shutdown": "1",
"opcache.error_log": "/home/logs/php7_opcache.log",
"http.etag.mode": "CRC32B",
"memcached.compression_threshold": "2048",
```
