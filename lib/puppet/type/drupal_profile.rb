require 'pathname'
require 'uri'

Puppet::Type.newtype(:drupal_profile) do
  desc "Manages a Drupal installation profile or distribution"

  def self.title_patterns
    [
      [ /^(\w+)-(\d\.\d+)$/, [ [ :name, lambda {|x| x} ], [ :version, lambda {|x| x} ] ] ]
    ]
  end

  ensurable do
    desc "The state the profile or distro should be in."
    defaultvalues
  end

  newparam(:name, :namevar => true) do
    desc "Name of the profile. Can be set by using a title in the format 'name-version'"
    newvalues /^[\.|\w]+(::\w+)?$/
  end

  newparam(:version, :namevar => true) do
    desc "Version of the profile. Can be set by using a title in the format 'name-version'"
  end

end
