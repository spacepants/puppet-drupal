# == Class drupal::install
#
# This class is called from drupal for install.
#
class drupal::install {

  file { $::drupal::dslm_base:
    ensure  => directory,
    require => Exec["${::drupal::drush_path} dl dslm"],
  }

  file { "${::drupal::dslm_base}/cores":
    ensure  => directory,
    require => File[$::drupal::dslm_base],
  }

  file { "${::drupal::dslm_base}/profiles":
    ensure  => directory,
    require => File[$::drupal::dslm_base],
  }

  # todo: refactor to query and download latest drupal release via drush rl/dl
  ::drupal::core { $::drupal::available_cores:
    require => File["${::drupal::dslm_base}/cores"],
  }

}
