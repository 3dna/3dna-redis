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
    $default_file = '/etc/default/redis-server'

    if $operatingsystem == 'Ubuntu' {
      case $operatingsystemrelease {
        '12.04': { $redis_version = '2.4' }
        '14.04': { $redis_version = '2.8' }

        # need to set the param directly
        default: { }
      }
    }
  } else {
    fail("osfamily ${osfamily} not currently supported please make a pull request!")
  }
}
