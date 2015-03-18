# == Class: drupal
#
# Full description of class drupal here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class drupal (
  $dslm_base    = $::drupal::params::dslm_base,
  $package_name = $::drupal::params::package_name,
) inherits ::drupal::params {

  # validate parameters here

  anchor { '::drupal::begin': }     ->
  class { '::drupal::drush': }      ->
  class { '::drupal::install': }    ->
  class { '::drupal::cacheclear': } ->
  anchor { '::drupal::end': }

}
