require 'fileutils'

Puppet::Type.type(:drupal_core).provide(:drush) do
  desc "Manage Drupal profiles or distros via Drush"

  commands :drush => 'drush'

  def self.instances
    profiles = []
    begin
      Puppet.debug 'Loading available profiles'
      drush('dslm-profiles').split("\n").each do |line|
        if match = line.match(/(\S)-(\d\.\d+)/)
          profiles << new(:ensure  => 'present',
                       :name    => match[1],
                       :version => match[2])

        end
      end
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "Drupal profiles: #{e.message}"
    end
    profiles
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
    drush('pm-download', "#{resource[:name]}-#{resource[:version]}", '--destination="$DSLM_BASE/profiles"')

    @property_hash[:ensure] = :present
  end

  def destroy
    FileUtils.rm_rf("$DSLM_BASE/profiles/#{resource[:name]}-#{resource[:version]}")
    @property_hash[:ensure] = :absent
  end

  def version
    @property_hash[:version]
  end

  def version=(should)
    drush('pm-download', "#{resource[:name]}-#{resource[:version]}", '--destination="$DSLM_BASE/profiles"')
    @property_hash[:version] = should
  end

end
