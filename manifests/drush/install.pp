# == Class drupal::drush::install
#
# This class is meant to be called from drupal.
# It ensures drush is doing a thing.
#
class drupal::drush::install {

  file { $::drupal::drush_install_path:
    ensure => directory,
  }

  $composer_home = "${::drupal::drush_install_path}/.composer"
  $real_version = $::drupal::drush_version ? {
    /\./     => $::drupal::drush_version,
    'master' => 'dev-master',
    default  => "${::drupal::drush_version}.*",
  }
  $cmd = "${::drupal::composer_path} require drush/drush:${real_version}"
  exec { 'install drush':
    command     => $cmd,
    cwd         => $::drupal::drush_install_path,
    environment => ["COMPOSER_HOME=${composer_home}"],
    require     => File[$::drupal::drush_install_path],
    creates     => "${::drupal::drush_install_path}/composer.json",
    notify      => Exec['drush status'],
  }

  file { $::drupal::drush_path:
    ensure  => link,
    target  => "${::drupal::drush_install_path}/vendor/bin/drush",
    require => Exec['install drush'],
  }

  exec { 'drush status':
    command     => "${::drupal::drush_path} status",
    require     => File[$::drupal::drush_install_path],
    refreshonly => true,
  }

}
