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
  $cores              = [ '7.43' ],
  $composer_path      = '/usr/local/bin/composer',
  $drush_extensions   = [],
  $drush_ini          = undef,
  $drush_install_path = '/opt/drush',
  $drush_path         = '/usr/local/bin/drush',
  $drush_php          = undef,
  $drush_version      = '7.x',
  $dslm_base          = '/var/drupal',
  $php_ini            = undef,
) inherits ::drupal::params {

  validate_array($cores)
  validate_absolute_path($composer_path)
  validate_array($drush_extensions)
  if $drush_ini {
    validate_absolute_path($drush_ini)
  }
  validate_absolute_path($drush_install_path)
  validate_absolute_path($drush_path)
  if $drush_php {
    validate_absolute_path($drush_php)
  }
  validate_absolute_path($dslm_base)
  if $php_ini {
    validate_absolute_path($php_ini)
  }

  anchor { '::drupal::begin': }     ->
  class { '::drupal::drush': }      ->
  class { '::drupal::install': }
  class { '::drupal::cacheclear': } ->
  anchor { '::drupal::end': }

}
