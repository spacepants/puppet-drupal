# == Class drupal::drush::config
#
# This class is meant to be called from drupal.
# It ensures drush is doing a thing.
#
class drupal::cacheclear {

    exec { 'cc drush':
    command     => '/usr/local/bin/drush cc drush',
    require     => File['/etc/profile.d/drushrc.sh'],
    refreshonly => true,
  }

}
