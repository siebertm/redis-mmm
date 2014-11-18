redis-mmm - redis multi master replication manager
==================================================

__IMPORTANT:__ This project is superseeded by redis-sentinel functionality in redis core. Don't use redis-mmm!



This project is a port of a lot of ideas of mysql-mmm to redis. That also explains the name as an hommage to the mysql-mmm project

Multi-Master?
-------------

No. Not really.


What then?
----------

redis-mmm aims to provide automatic (and, to some extent, manual) failover functionality in case the redis master crashes or anything else happens.
This functionality does not exist in redis itself.

The whole idea behind that is having a virtual IP address to which all redis clients connect to reach the master. This IP is then migrated to the
current master machine, so that the client will always reach the master. There is a slave IP address, too, so you could even balance the reads off of
the master!

All work is done by a separate monitoring process (which, for obvious reasons, should reside on a completely different host).


How to make it work
-------------------

Before you start, you need to make sure you have the following prerequisites:

* a network where you can dynamically change IPs (should be a private network)
* 2 free IP addresses
* you are NOT on Amazon EC2, since you can't add / remove IPs there (that's a lesson I had to learn)
* a separate monitoring host on your network
* two redis servers on different machines (I'll call them db1 and db2)
* redis is listening on 0.0.0.0
* the monitoring host can access both redis instances (I'll call it mon)
* a redis-mmm user on all hosts
* redis-mmm@mon can ssh to redis-mmm@db1 and redis-mmm@db2 without entering a password
* redis-mmm@db{1,2} can use sudo to do the following commands
  * /sbin/ip addr {show,add,del}
  * /usr/bin/arping


Now, go to the monitoring host, install redis-mmm (`gem install redis-mmm`) and configure /etc/redis-mmm.conf

Example configuration:

    master_ip = 192.168.10.70
    cluster_interface = eth1

    [db1]
    address = 192.168.10.1
    port = 6379
    ssh_user = redis-mmm
    ssh_port = 22

    [db2]
    address = 192.168.10.2
    port = 6379
    ssh_user = redis-mmm
    ssh_port = 22


To start the monitoring, start `redis_mmm mon`. It's left as an excercise for the reader to use upstart, god or bluepill to keep that process running.

To view the cluster's status, call `redis_mmm status`

To view info about a node, use `redis_mmm info <node>`

To show help: `redis_mmm help`



Warning
=======

This is an experimental piece of software not yet ready for prime time. I can't guarantee
consistency for now, since there's no way to make a redis server read only and some redis clients
seem to ignore crashed servers

Nevertheless, play and try, fork and update and give feedback!

