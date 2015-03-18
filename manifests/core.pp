# == Define drupal::core
#
# Installs a core for drupal
#
define drupal::core {
  $real_core = $name ? {
    /drupal-\d\.\d{1,2}/ => $name,
    /\d\.\d{1,2}/        => "drupal-${name}",
    default              => fail("${name} is not a valid core version")
  }
  exec {"${::drupal::drush_path} dl ${real_core}":
    cwd     => "${::drupal::dslm_base}/cores",
    creates => "${::drupal::dslm_base}/cores/${real_core}",
    require => File["${::drupal::dslm_base}/cores"],
    notify  => Exec['cc drush'],
  }

}
