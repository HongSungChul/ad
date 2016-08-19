# 브랜드 박스


## 컨텐츠 내용

- [설치](#install)
- [소개](#introduction)

- [Todo](#todo)

## Install

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
