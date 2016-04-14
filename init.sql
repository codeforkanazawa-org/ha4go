create database if not exists ha4go default character set utf8;
grant ALL on ha4go.* to ha4go@'%' identified by 'ha4goha4go';
grant ALL on ha4go.* to ha4go@'localhost' identified by 'ha4goha4go';
flush privileges;
