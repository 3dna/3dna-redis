# == Class: redis::install
#
# install the redis package, meant to be used only as part of the 'redis' class
#
# === Parameters
#
# [*$redis::params::package*]
#   the name of the package
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class redis::install {
  package {$redis::params::package:
    ensure => installed,
  }
}
