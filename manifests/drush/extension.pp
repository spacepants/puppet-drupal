# == Define drupal::drush::extension
#
# Installs an extension for drush
#
define drupal::drush::extension (
  $version = undef,
) {
  if $version {
    exec {"${::drupal::drush_path} dl ${name}-${version}":
      command => "${::drupal::drush_path} pm-download ${name}",
      creates => "/usr/share/drush/commands/${name}",
      notify  => Exec['cc drush'],
    }
  } else {
    exec {"${::drupal::drush_path} dl ${name}":
      command => "${::drupal::drush_path} pm-download ${name}",
      creates => "/usr/share/drush/commands/${name}",
      notify  => Exec['cc drush'],
    }
  }
}
