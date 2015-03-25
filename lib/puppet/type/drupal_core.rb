require 'pathname'
require 'uri'


Puppet::Type.newtype(:drupal_core) do
  desc "Manages a Drupal core"

  def self.title_patterns
    [
      [ /^drupal-(\d\.\d+)$/, [ [ :version, lambda {|x| x} ] ] ],
      [ /^(\d\.\d+)$/, [ [ :version, lambda {|x| x} ] ] ]
    ]
  end

  ensurable do
    desc "The state the core should be in."
    defaultvalues
  end

  newparam(:version, :namevar => true) do
    desc "Version of core. Can be set by using a title in the format 'drupal-version'"
  end

end
