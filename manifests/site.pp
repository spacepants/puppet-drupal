# == Define drupal::site
#
# This define is called from drupal for site scaffolding.
#
define drupal::site (
  $ensure         = 'present',
  $admin_password = randstr(),
  $core           = undef,
  $database       = undef,
  $db_user        = undef,
  $db_password    = undef,
  $db_host        = undef,
  $db_port        = undef,
  $db_driver      = undef,
  $db_prefix      = undef,
  $update         = undef,
  $docroot        = undef,
  $writeaccess    = undef,
  $base_url       = undef,
  $cookie_domain  = undef,
  $files_target   = undef,
  $web_user       = undef,
  $web_group      = undef,
) {
  require ::drupal

  # validate yo params here

  exec { "scaffold out ${name} site root":
    command   => "${::drupal::drush_path} dslm-new ${name} ${core}",
    cwd       => $docroot,
    creates   => "${docroot}/${name}",
    logoutput => true,
  }

  if $files_target {
    file { "${docroot}/${name}/sites/default/files":
      ensure  => link,
      target  => $files_target,
      require => Exec["scaffold out ${name} site root"]
    }
  } else {
    file { "${docroot}/${name}/sites/default/files":
      ensure  => directory,
      owner   => $web_user,
      group   => $web_group,
      mode    => '2775',
      require => Exec["scaffold out ${name} site root"]
    }
  }

  file { "${docroot}/${name}/sites/default/settings.php":
    ensure  => file,
    mode    => '0444',
    content => template('drupal/settings.php.erb'),
    require => File["${docroot}/${name}/sites/default/files"]
  }

  exec { "install ${name} drupal site":
    command   => "drush site-install standard --account-pass='${admin_password}' -l ${name} --yes --site-name=${name}",
    unless    => "drush status -l ${name} | grep 'bootstrap.*Successful'",
    logoutput => true,
    require   => File["${docroot}/${name}/sites/default/settings.php"]
  }
}
