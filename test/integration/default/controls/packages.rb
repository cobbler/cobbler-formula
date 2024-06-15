# frozen_string_literal: true

# Prepare platform "finger"
platform_finger = system.platform[:finger].split('.').first.to_s

control 'cobbler.package.install' do
  title 'The required package should be installed'

  # Override by `platform_finger`
  package_name =
    case platform_finger
    when 'centos-8', 'rockylinux-8', 'almalinux-8'
      'cobbler3.2'
    when 'rockylinux-9', 'almalinux-9'
      'cobbler3.3'
    else
      'cobbler'
    end

  describe package(package_name) do
    it { should be_installed }
  end
end
