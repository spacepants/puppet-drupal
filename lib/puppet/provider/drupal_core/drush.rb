require 'fileutils'

Puppet::Type.type(:drupal_core).provide(:drush) do
  desc "Manage Drupal cores via Drush"

  commands :drush => 'drush'

  def self.instances
    cores = []
    begin
      Puppet.debug 'Loading available cores'
      drush('dslm-cores').split("\n").each do |line|
        if match = line.match(/drupal-(\d\.\d+)/)
          cores << new(:ensure  => 'present',
                       :version => match[1])

        end
      end
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "Drupal cores: #{e.message}"
    end
    cores
  end

  def self.prefetch(resources)
    vars = instances
    resources.each do |name, res|
      if provider = vars.find{ |v| v.name == res.title }
        res.provider = provider
      end
    end
  end

  def exists?
    [:present].include? @property_hash[:ensure]
  end


  def create
    drush('pm-download', "drupal-#{resource[:version]}", '--destination="$DSLM_BASE/cores"')

    @property_hash[:ensure] = :present
  end

  def destroy
    FileUtils.rm_rf("$DSLM_BASE/cores/drupal-#{resource[:version]}")
    @property_hash[:ensure] = :absent
  end

  def version
    @property_hash[:version]
  end

  def version=(should)
    drush('pm-download', "drupal-#{resource[:version]}", '--destination="$DSLM_BASE/cores"')
    @property_hash[:version] = should
  end

end
