# frozen_string_literal: true

control 'cobbler.config.file' do
  title 'Verify the configuration file'

  describe file('/etc/cobbler/settings.yaml') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include('# THIS FILE IS MANAGED BY SALTSTACK!')
    end
    # Added in pillar
    its('content') { should include 'manage_dns: true' }
    # Added in defaults
    its('content') { should include 'manage_tftpd: true' }
    # Lookup value. "manage_dhcp" itself is 3.3.x-only (a virtual "v4 or v6"
    # combination, dropped entirely in 4.0.0); "manage_dhcp_v4" renders
    # identically from the same pillar value in both major versions.
    its('content') { should include 'manage_dhcp_v4: true' }
  end
end
