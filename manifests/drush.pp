# == Class drupal::drush
#
# This class is meant to be called from drupal.
# It ensures drush is doing a thing.
#
class drupal::drush {

  # do a thing
  class { '::drupal::drush::install': } ->
  class { '::drupal::drush::config': } ->
  Class['::drupal::drush']
}
