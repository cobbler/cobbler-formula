# -*- coding: utf-8 -*-
# vim: ft=sls

# Cobbler 3.4.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release34
# Cobbler 3.3.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release33
# Cobbler 3.2.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release32
# Cobbler 3.1.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release31
# Cobbler 3.0.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release30
# Cobbler 2.8.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release28
# Cobbler 2.6.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release26
# Cobbler 2.4.x - https://build.opensuse.org/project/show/systemsmanagement:cobbler:release24

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}
{%- set repo_version = {
  "3.4.x": "release34",
  "3.3.x": "release33",
  "3.2.x": "release32",
  "3.1.x": "release31",
  "3.0.x": "release30",
  "2.8.x": "release28",
  "2.6.x": "release26",
  "2.4.x": "release24",
}.get(cobbler.pkg.communityrepo.version) %}
{%- set repo_os_name = {
  "3.4.x": {},
  "3.3.x": {
    "openSUSE Tumbleweed": {
      "": "openSUSE_Tumbleweed"
    },
    "Leap": {
      "15.3": "Leap_15.3",
      "15.4": "Leap_15.4",
    },
    "SLES": {},
    "Fedora": {
      "34": "Fedora_34",
    },
    "CentOS": {
      "8": "CentOS_8",
    },
    "CentOS Stream": {},
    "Debian": {
      "10": "Debian_10",
      "11": "Debian_11",
    },
    "Ubuntu": {
      "18.04": "xUbuntu_18.04",
      "20.04": "xUbuntu_20.04",
      "22.04": "xUbuntu_22.04",
    },
  },
  "3.2.x": {
    "Leap": {
      "15.2": "Leap_15.2",
    },
    "SLES": {
      "15.1": "SLE_15_SP1",
    },
    "Fedora": {
      "31": "Fedora_31",
    },
    "CentOS": {},
    "CentOS Stream": {
      "8": "CentOS_8_Stream",
    },
    "Debian": {
      "10": "Debian_10",
    },
    "Ubuntu": {
      "18.04": "xUbuntu_18.04",
    },
  },
  "3.1.x": {},
  "3.0.x": {
    "Fedora": {
      "29": "Fedora_29",
    },
  },
  "2.8.x": {},
  "2.6.x": {},
  "2.4.x": {},
} %}
{%- set repo_os_releases = repo_os_name.get(cobbler.pkg.communityrepo.version).get(grains["os"]) %}
{%- if cobbler.pkg.communityrepo.enabled %}
{%- if repo_os_releases is not none and repo_os_releases.get(grains["osrelease"]) is not none %}
{%- set repo_os_name_lookup = repo_os_releases.get(grains["osrelease"]) %}
cobbler-package-install-repo-available:
  pkgrepo.managed:
    {%- if grains["os_family"] == "Debian" %}
    - name: deb http://download.opensuse.org/repositories/systemsmanagement:/cobbler:/{{ repo_version }}/{{ repo_os_name_lookup }}/ /
    - key_url: https://download.opensuse.org/repositories/systemsmanagement:/cobbler:/{{ repo_version }}/{{ repo_os_name_lookup }}/Release.key
    {%- elif grains["os_family"] in ("RedHat", "Suse") %}
    - name: cobbler_community_repo
    {%- endif %}
    - gpgcheck: true
    - gpgkey: true
    - gpgautoimport: true
    - humanname: Cobbler Community OBS repository
    {%- if grains["os_family"] in ("RedHat", "Suse") %}
    - baseurl: https://download.opensuse.org/repositories/systemsmanagement:/cobbler:{{ repo_version }}/{{ repo_os_name_lookup }}/
    {%- endif %}
{%- else %}
cobbler-package-install-repo-unavailable:
  test.fail_without_changes:
    - name: |

        ################################################################################
        #                                                                              #
        #           WARNING: Requested OS and Cobbler version not compatible           #
        #                                                                              #
        ################################################################################
        #                                                                              #
        # The Cobbler community repositories are maintained by volunteers that have    #
        # limited time. The OS and requested Cobbler version are at the moment not     #
        # available. Please either request this new combination on GitHub              #
        # (https://github.com/cobbler/cobbler/issues/) or switch to another OS and     #
        # Cobbler combination!                                                         #
        #                                                                              #
        ################################################################################
        Please include the following information in the issue:
            {{ cobbler.pkg.communityrepo.version }}/{{ grains["os"] }}/{{ grains["osrelease"] }}
{%- endif %}
{%- endif %}
