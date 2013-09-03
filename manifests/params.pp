# == Class: redis::params
#
# default parameters for the redis class based on OS and such
#
# not to be called directly
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class redis::params {
  if $::osfamily == 'Debian' {
    $config_file  = '/etc/redis/redis.conf'
    $logfile      = '/var/log/redis/redis-server.log'
    $pidfile      = '/var/run/redis/redis-server.pid'
    $dir          = '/var/lib/redis'
    $vm_swap_file = '/var/lib/redis/redis.swap'
    $package      = 'redis-server'
    $service      = 'redis-server'
  } else {
    fail("osfamily ${osfamily} not currently supported please make a pull request!")
  }
}
