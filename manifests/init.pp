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
class redis inherits redis::params {
  require ::redis::install
  require ::redis::config
  require ::redis::service

  Class["::redis::config"] -> Class["::redis::install"] -> Class["::redis::service"]
  Class["::redis::config"] ~> Class["::redis::service"]

}
