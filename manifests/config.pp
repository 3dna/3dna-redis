# == Class: redis::config
#
# installs the redis config file. meant to be used by the redis clas
#
# === Parameters
#
# The parameters are mostly what is available in the default config file for redis 2.4 on ubuntu (the quantal package)
# Any missing parameters, sorry, I'll take a pull request! :)
#
# The only one really of note is 'loglevel'. The class's param is called redis_loglevel because loglevel is a metaparam in puppet
#
# The defaults are all also pulled from that file, so if there's one that's different for your OS package, let me know and we can
# extract it out to the params class, but you're of course more than welcome to provide your own and/or submit a PR :)
#
# I recommend using hiera to configure these settings. Hiera is awesome.
#
# === Examples
#
# in manifest:
# include redis
#
# in hiera:
# ---
# redis::config::port: 1234
# redis::config::bind: 0.0.0.0
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2013 3dna
#
class redis::config (
  $port                        = 6379,
  $bind                        = '127.0.0.1',
  $unixsocket                  = undef,
  $unixsocketperm              = 0755,
  $timeout                     = 0,
  $tcp_keepalive               = 0,
  $redis_loglevel              = 'notice',
  $logfile                     = $redis::params::logfile,
  $pidfile                     = $redis::params::pidfile,
  $syslog_enabled              = false,
  $syslog_ident                = 'redis',
  $syslog_facility             = 'local0',
  $databases                   = 16,
  $save                        = [ '900 1', '300 10', '60 10000' ],
  $stop_writes_on_bgsave_error = true,
  $rdbcompression              = true,
  $rdbchecksum                 = true,
  $dbfilename                  = 'dump.rdb',
  $dir                         = $redis::params::dir,
  $slaveof                     = undef,
  $masterauth                  = undef,
  $slave_serve_stale_data      = true,
  $slave_read_only             = true,
  $repl_ping_slave_period      = 10,
  $repl_timeout                = 60,
  $repl_disable_tcp_nodelay    = false,
  $repl_backlog_size           = '1mb',
  $repl_backlog_ttl            = 3600,
  $slave_priority              = 100,
  $min_slaves_to_write         = 0,
  $min_slaves_max_lag          = 10,
  $requirepass                 = false,
  $rename_command              = {},
  $maxclients                  = $redis_version ? {
    '2.4'   => '0',
    '2.8'   => '10000',
    default => '10000',
  },
  $maxmemory                   = undef,
  $maxmemory_policy            = 'volatile-lru',
  $maxmemory_samples           = 3,
  $appendonly                  = false,
  $appendfilename              = 'appendonly.aof',
  $appendfsync                 = 'everysec',
  $no_append_fsync_on_rewrite  = false,
  $auto_aof_rewrite_percentage = 100,
  $auto_aof_rewrite_min_size   = '64mb',
  $aof_rewrite_incremental_fsync = true,
  $lua_time_limit              = 5000,
  $notify_keyspace_events      = "",
  $slowlog_log_slower_than     = 10000,
  $slowlog_max_len             = 128,
  # vm is deprecated in 1.4
  $vm_enabled                  = false,
  $vm_swap_file                = $redis::params::vm_swap_file,
  $vm_max_memory               = 0,
  $vm_page_size                = 32,
  $vm_pages                    = 134217728,
  $vm_max_threads              = 4,
  # advanced settings
  $hash_max_ziplist_entries     = 512,
  $hash_max_ziplist_value       = 64,
  $list_max_ziplist_entries    = 512,
  $list_max_ziplist_value      = 64,
  $set_max_intset_entries      = 512,
  $zset_max_ziplist_entries    = 128,
  $zset_max_ziplist_value      = 64,
  $activerehashing             = true,
  $client_output_buffer_limit  = [
                                  'normal 0 0 0',
                                  'slave 256mb 64mb 60',
                                  'pubsub 32mb 8mb 60',
                                ],
  $hz                          = 10,
  $include                     = [],
  $ulimit_open_files           = undef,
) inherits redis {
  $syslog_enabled_bool = str2bool($syslog_enabled)
  $rdbcompression_bool = str2bool($rdbcompression)
  $slave_serve_stale_data_bool = str2bool($slave_serve_stale_data)
  $appendonly_bool = str2bool($appendonly)
  $no_append_fsync_on_rewrite_bool = str2bool($no_append_fsync_on_rewrite)
  $vm_enabled_bool = str2bool($vm_enabled)
  $activerehashing_bool = str2bool($activerehashing)
  $stop_writes_on_bgsave_error_bool = str2bool($stop_writes_on_bgsave_error)
  $rdbchecksum_bool = str2bool($rdbchecksum)
  $slave_read_only_bool = str2bool($slave_read_only)
  $repl_disable_tcp_nodelay_bool = str2bool($repl_disable_tcp_nodelay)
  $aof_rewrite_incremental_fsync_bool = str2bool($aof_rewrite_incremental_fsync)
  
  
  
  
  
  
  # validate port as numeric
  # validate timeout as numeric?
  # validate absolute path for logfile
  # validate absolute path for pidfile
  # validate databases as numeric?
  # validate absolute path for dir
  # validate repl_ping_slave_period as numeric
  # validate repl_timeout as numeric
  # validate repl_timeout > repl_ping_slave_period
  # validate rename_command as hash
  # validate maxclients as numeric
  # validate maxmemory_samples as numeric
  # validate absolute path for vm_swap_file
  # validate vm_max_memory as numeric
  # validate vm_page_size as numeric
  # validate vm_pages as numeric
  # validate vm_max_threads as numeric
  # validate hash_max_zipmap_entries as numeric
  # validate hash_max_zipmap_value as numeric
  # validate list_max_zipmap_entries as numeric
  # validate list_max_ziplist_value as numeric
  # validate set_max_intset_entries as numeric
  # validate zset_max_ziplist_entries as numeric
  # validate zset_max_ziplist_value as numeric


  file { $redis::params::config_file:
    content => template("redis/redis-${version}.conf.erb"),
  }

  file { $redis::params::default_file:
    content => template('redis/redis.default.erb'),
  }
}
