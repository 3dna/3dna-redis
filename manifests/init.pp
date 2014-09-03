# == Class: redis
#
# installs and configures a redis server
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Examples
#
#  class { redis: }
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class redis (
  $version = $redis_version,
) inherits redis::params {
  include ::redis::install
  include ::redis::config
  include ::redis::service

  Class["::redis::install"] -> Class["::redis::config"] ~> Class["::redis::service"]

  anchor {
    'redis::begin':
      before => [Class['::redis::install'],Class['::redis::config']],
      notify => Class['::redis::service'];
    'redis::end':
      require => Class['::redis::service'];
  }
}
