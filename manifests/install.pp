# == Class drupal::install
#
# This class is called from drupal for install.
#
class drupal::install {

  file { $::drupal::dslm_base:
    ensure  => directory,
  }

  file { "${::drupal::dslm_base}/cores":
    ensure  => directory,
    require => File[$::drupal::dslm_base],
  }

  file { "${::drupal::dslm_base}/profiles":
    ensure  => directory,
    require => File[$::drupal::dslm_base],
  }

  ::drupal::drush::extension { 'dslm':
    version => '7.x-2.x-dev',
    require => File['/etc/profile.d/drushrc.sh'],
  }

  # todo: refactor to query and download latest drupal release via drush rl/dl
  ::drupal::core { $::drupal::cores:
    require => File["${::drupal::dslm_base}/cores"],
  }

}
