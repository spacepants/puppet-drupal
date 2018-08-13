# == Class drupal::drush::config
#
# This class is meant to be called from drupal.
# It ensures drush is doing a thing.
#
class drupal::drush::config(
  $drush_ini_ensure = false,
  $drush_php_ensure = false,
  $php_ini_ensure   = false,
) {

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
    target  => 'drush profile',
    content => "# MANAGED BY PUPPET\n\n",
    order   => 0,
  }

  concat::fragment { 'drush profile path':
    target  => 'drush profile',
    content => "export PATH=\$PATH:/usr/local/bin\n\n",
    order   => 1,
  }

  if $drush_ini_ensure {
    concat::fragment { 'drush profile drush_ini':
      target  => 'drush profile',
      content => "export DRUSH_INI=${drupal::drush_ini}\n",
      order   => 2,
    }
  }

  if $drush_php_ensure {
    concat::fragment { 'drush profile drush_php':
      target  => 'drush profile',
      content => "export DRUSH_PHP=${drupal::drush_php}\n",
      order   => 2,
    }
  }

  if $php_ini_ensure {
    concat::fragment { 'drush profile php_ini':
      ensure  => $php_ini_ensure,
      target  => 'drush profile',
      content => "export PHP_INI=${drupal::php_ini}\n",
      order   => 2,
    }
  }

  concat::fragment { 'drush profile dslm_base':
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
