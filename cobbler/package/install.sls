# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}
{%- set sls_repo_available = tplroot ~ '.package.repository' %}
{%- if cobbler.pkg.epel.enabled %}
include:
  - epel
{%- if grains["osfinger"] == "CentOS Linux-8" %}
cobbler-package-install-pkg-enable-dnf-module:
  cmd.run:
    - name: dnf module enable cobbler
    - unless: dnf module list --enabled | grep cobbler
    - require:
      - pkg: epel_release
{%- endif %}
{%- endif %}
cobbler-package-install-pkg-installed:
  pkg.installed:
    - name: {{ cobbler.pkg.name }}
    {%- if cobbler.pkg.communityrepo.enabled %}
    - require:
      - sls: {{ sls_repo_available }}
    {%- elif cobbler.pkg.epel.enabled %}
    # Isn't supported by the yum backend of Salt. We are using osfinger parameter files to fix this. :(
    # - resolve_capabilities: true
    - require:
      - pkg: epel_release
    {%- endif %}
