# == Class: redis::service
#
# manages the redis service as part of the redis module. should not be included directly
#
# === Parameters
#
# [*service*]
#   override the default service name from redis::params
# [*ensure*]
#   whether or not puppet should ensure the service. defaults to undef
# [*enable*]
#   whether or not the service is enabled to start. defaults to true
#
# === Variables
#
# None
#
# === Examples
#
# include redis
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class redis::service (
  $service = $redis::params::service,
  $ensure  = undef,
  $enable  = true,
) {
  service { $service:
    ensure => $ensure,
    enable => $enable,
  }
}
