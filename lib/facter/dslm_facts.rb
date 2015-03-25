facts = {
  'drupal_dslm_base'     => 'DSLM BASE',
}
dslm = {}

begin
  Facter::Util::Resolution.exec("drush dslm 2>/dev/null").each do |line|
    key, val = line.split(':') if line
    dslm[key.strip] = val.strip
  end

  facts.each do |fact, name|
    Facter.add(fact) do
      setcode do
        dslm[name]
      end
    end
  end
rescue Exception => e
end
