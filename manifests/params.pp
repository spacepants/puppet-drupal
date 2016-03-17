# == Class drupal::params
#
# This class is meant to be called from drupal.
# It sets variables according to platform.
#
class drupal::params {
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
