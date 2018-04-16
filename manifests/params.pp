class chrony::params {
  $bindcmdaddress     = [ '127.0.0.1', '::1' ]
  $chrony_password    = 'xyzzy'
  $client_log         = false
  $commandkey         = 0
  $config_keys_manage = true
  $denyhosts          = []
  $generatecommandkey = true
  $keys               = []
  $offline            = false
  $package_ensure     = 'present'
  $port               = 0
  $queryhosts         = []
  $refclocks          = []
  $rtconutc           = true
  $serve_ntp          = false
  $service_enable     = true
  $service_ensure     = 'running'
  $service_manage     = true
  $source_port        = undef
  $sync_local_clock   = true
  $udlc               = false

  case $::osfamily {
    'Archlinux' : {
      $config = '/etc/chrony.conf'
      $config_driftfile = '/etc/chrony.drift'
      $config_template = 'chrony/chrony.conf.erb'
      $config_keysfile = '/etc/chrony.keys'
      $config_keys_template = 'chrony/chrony.keys.erb'
      $config_logdir = '/var/log/chrony'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $config_stratumweight = 0
      $package_name = 'chrony'
      $service_name = 'chrony'
      $service_hasstatus = true
      $servers = {
        '0.pool.ntp.org' => ['iburst'],
        '1.pool.ntp.org' => ['iburst'],
        '2.pool.ntp.org' => ['iburst'],
      }
    }
    'RedHat' : {
      $config = '/etc/chrony.conf'
      $config_template = 'chrony/chrony.conf.redhat.erb'
      $config_keys = '/etc/chrony.keys'
      $config_keys_template = 'chrony/chrony.keys.redhat.erb'
      $config_keys_owner = 0
      $config_keys_group = chrony
      $config_keys_mode  = '0640'
      $package_name = 'chrony'
      $service_name = 'chronyd'
      $servers = {
        '0.pool.ntp.org' => ['iburst'],
        '1.pool.ntp.org' => ['iburst'],
        '2.pool.ntp.org' => ['iburst'],
      }
    }

    default     : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
