# == Class drupal::drush::config
#
# This class is meant to be called from drupal.
# It ensures drush is doing a thing.
#
class drupal::drush::config {

  file { '/etc/drush':
    ensure => directory,
  }

  file { '/usr/share/drush':
    ensure  => directory,
  }

  file { '/usr/share/drush/commands':
    ensure  => directory,
    require => File['/usr/share/drush'],
  }

  $drush_base = "${::drupal::drush_install_path}/vendor/drush/drush"

  file { '/etc/profile.d/drushrc.sh':
    ensure  => link,
    target  => "${drush_base}/examples/example.bashrc",
    require => File['/usr/local/bin/drush'],
  }

  file { '/etc/bash_completion.d/drush':
    ensure  => link,
    target  => "${drush_base}/drush.complete.sh",
    require => File['/usr/local/bin/drush'],
  }

  concat { 'drush profile':
    ensure => present,
    path   => '/etc/profile.d/drush.sh',
  }
  concat::fragment { 'drush profile header':
    ensure  => present,
    target  => 'drush profile',
    content => "# MANAGED BY PUPPET\n\n",
    order   => 0,
  }

  concat::fragment { 'drush profile path':
  ensure  => present,
  target  => 'drush profile',
  content => "export PATH=\$PATH:/usr/local/bin\n\n",
  order   => 1,
  }

  $drush_ini_ensure = $::drupal::drush_ini ? {
      undef   => absent,
      default => present,
    }
  concat::fragment { 'drush profile drush_ini':
    ensure  => $drush_ini_ensure,
    target  => 'drush profile',
    content => "export DRUSH_INI=${drupal::drush_ini}\n",
    order   => 2,
  }

  $drush_php_ensure = $::drupal::drush_php ? {
      undef   => absent,
      default => present,
    }
  concat::fragment { 'drush profile drush_php':
    ensure  => $drush_php_ensure,
    target  => 'drush profile',
    content => "export DRUSH_PHP=${drupal::drush_php}\n",
    order   => 2,
  }

  $php_ini_ensure = $::drupal::php_ini ? {
      undef   => absent,
      default => present,
    }
  concat::fragment { 'drush profile php_ini':
    ensure  => $php_ini_ensure,
    target  => 'drush profile',
    content => "export PHP_INI=${drupal::php_ini}\n",
    order   => 2,
  }

  concat::fragment { 'drush profile dslm_base':
    ensure  => present,
    target  => 'drush profile',
    content => "export DSLM_BASE=${drupal::dslm_base}\n",
    order   => 2,
  }

  if ::drupal::drush_extensions {
    ::drupal::drush::extension { $::drupal::drush_extensions:
      require => File['/etc/profile.d/drushrc.sh'],
    }
  }

}
