# == Class drupal::params
#
# This class is meant to be called from drupal.
# It sets variables according to platform.
#
class drupal::params {
  $available_cores    = [ '7.34' ]
  $composer_path      = '/usr/local/bin/composer'
  $drush_path         = '/usr/local/bin/drush'
  $drush_extensions   = [ ]
  $drush_ini          = undef
  $drush_install_path = '/opt/drush'
  $drush_php          = undef
  $drush_version      = 'master'
  $dslm_base          = '/var/drupal'
  $php_ini            = undef
  case $::osfamily {
    'Debian': {
      $package_name = 'drupal'
      $service_name = 'drupal'
    }
    'RedHat', 'Amazon': {
      $package_name = 'drupal'
      $service_name = 'drupal'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
