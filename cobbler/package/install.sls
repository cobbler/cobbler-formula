# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}
{%- set sls_repo_available = tplroot ~ '.package.repository' %}
{#- The "<pkg.name>-<webserver>" sub-package split (e.g. "cobbler-apache2") only
   exists from Cobbler 4.0.0 onwards; earlier versions don't have it. #}
{%- set webserver_pkg_supported = salt['pkg.version_cmp'](cobbler.version, '4.0.0') >= 0 %}
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
    - pkgs:
      - {{ cobbler.pkg.name }}
      {%- if cobbler.pkg.webserver and webserver_pkg_supported %}
      - {{ cobbler.pkg.name }}-{{ cobbler.pkg.webserver }}
      {%- endif %}
    {%- if cobbler.pkg.communityrepo.enabled %}
    - require:
      - sls: {{ sls_repo_available }}
    {%- elif cobbler.pkg.epel.enabled %}
    # Isn't supported by the yum backend of Salt. We are using osfinger parameter files to fix this. :(
    # - resolve_capabilities: true
    - require:
      - pkg: epel_release
    {%- endif %}
