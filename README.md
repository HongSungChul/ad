# 브랜드 박스


## 목차 

- [설치](#install)
- [소개](#introduction)

- [Todo](#todo)

## Install
1. os
	centos-release-6-6.el6.centos.12.2.x86_64
2. tomcat
	 
-- tomcat download

```sh
#cd /opt
#mkdir tomcat
#wget http://mirror.apache-kr.org/tomcat/tomcat-8/v8.0.24/bin/apache-tomcat-8.0.24.zip

-- tomcat connector download
#wget http://apache.tt.co.kr/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.40-src.tar.gz
# gunzip  tomcat-connectors-1.2.40-src.tar.gz
# tar -xvf tomcat-connectors-1.2.40-src.tar

#cd /opt/tomcat/tomcat-connectors-1.2.40-src/native

#sh ./buildconf.sh
#yum install autoconf
#yum install autoconf
#yum install libtool
#sh ./configure --with-apxs=/usr/sbin/apxs
#make && make install

# find / -name "mod_jk.so"
		>/opt/tomcat/tomcat-connectors-1.2.40-src/native/apache-2.0/mod_jk.so
		
# vi /etc/httpd/conf/httpd.conf	
        
Include conf.d/*.conf
Include /opt/tomcat/tomcat-connectors-1.2.40-src/conf/httpd-jk.conf ==>추가


 ## vi /opt/tomcat/tomcat-connectors-1.2.40-src/conf/httpd-jk.conf 
    
    	LoadModule jk_module modules/mod_jk.so

		JkWorkersFile /opt/tomcat/tomcat-connectors-1.2.40-src/conf/workers.properties
		
		JkMountFile /opt/tomcat/tomcat-connectors-1.2.40-src/conf/uriworkermap.properties
		
		JkLogFile /opt/tomcat/apache-tomcat-8.0.15/logs/mod_jk.log
		
		JkLogLevel info
		
		JkLogstampFormat "[%a %b %d %H:%M:%S %Y]"
		
		JkOptions +ForwardKeySize +ForwardURICompat -ForwardDirectories
		
		JkRequestLogFormat "%w %V %T"
		
	#mv workers.properties workers.properties.origin
	mv workers.properties.minimal workders.properties
	# vi uriworkermap.properties
	
		/wikibox/*=lb >추가 
	# vi /etc/init.d/tomcat
	#!/bin/sh
		# description: Tomcat Start Stop Restart
		# processname: tomcat
		# chkconfig: 234 20 80
		#JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.51-1.b16.el6_7.x86_64/
		#export JAVA_HOME
		#PATH=$JAVA_HOME/bin:$PATH
		#export PATH
		#Source function library.
		. /etc/rc.d/init.d/functions
		source /etc/profile
		export TOMCAT_HOME=/opt/tomcat/apache-tomcat-8.0.24
		# See how we were called.
		case "$1" in
		start)
		echo -n "Starting tomcat EXPERIMENTAL: "
		daemon $TOMCAT_HOME/bin/startup.sh
		echo
		;;
		stop)
		echo -n "Shutting down tomcat EXPERIMENTAL: "
		daemon $TOMCAT_HOME/bin/shutdown.sh
		echo
		;;
		restart)
		$0 stop
		$0 start
		;;
		*)
		echo "Usage: $0 {start|stop|restart}"
		exit 1
		esac
		exit 0
	#chmod +x /opt/tomcat/apache-tomcat-8.0.24/bin/startup.sh
	#chmod 755 /etc/init.d/tomcat
  	#chkconfig --add tomcat
  	#service tomcat restart
  	 
```sh
$ npm install mysql
```

For information about the previous 0.9.x releases, visit the [v0.9 branch][].

Sometimes I may also ask you to install the latest version from Github to check
if a bugfix is working. In this case, please do:

```sh
$ npm install mysqljs/mysql
```

[v0.9 branch]: https://github.com/mysqljs/mysql/tree/v0.9

## Introduction

This is a node.js driver for mysql. It is written in JavaScript, does not
require compiling, and is 100% MIT licensed.

Here is an example on how to use it:

```js
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
  if (err) throw err;

  console.log('The solution is: ', rows[0].solution);
});

connection.end();
```

From this example, you can learn the following:

* Every method you invoke on a connection is queued and executed in sequence.
* Closing the connection is done using `end()` which makes sure all remaining
  queries are executed before sending a quit packet to the mysql server.



## Todo

* Prepared statements
* Support for encodings other than UTF-8 / ASCII

[npm-image]: https://img.shields.io/npm/v/mysql.svg
[npm-url]: https://npmjs.org/package/mysql
[node-version-image]: https://img.shields.io/node/v/mysql.svg
[node-version-url]: https://nodejs.org/en/download/
[travis-image]: https://img.shields.io/travis/mysqljs/mysql/master.svg?label=linux
[travis-url]: https://travis-ci.org/mysqljs/mysql
[appveyor-image]: https://img.shields.io/appveyor/ci/dougwilson/node-mysql/master.svg?label=windows
[appveyor-url]: https://ci.appveyor.com/project/dougwilson/node-mysql
[coveralls-image]: https://img.shields.io/coveralls/mysqljs/mysql/master.svg
[coveralls-url]: https://coveralls.io/r/mysqljs/mysql?branch=master
[downloads-image]: https://img.shields.io/npm/dm/mysql.svg
[downloads-url]: https://npmjs.org/package/mysql
