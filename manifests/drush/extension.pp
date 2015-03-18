# == Define drupal::drush::extension
#
# Installs an extension for drush
#
define drupal::drush::extension {

  exec {"${::drupal::drush_path} dl ${name}":
    creates => "/usr/share/drush/commands/${name}",
    #notify  => Exec['cc drush'],
  }

}
