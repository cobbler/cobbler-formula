# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}

include:
  - {{ sls_config_clean }}

{%- if pkg.communityrepo.enabled %}
cobbler-package-clean-repository-removed:
  pkgrepo.absent:
    - name: cobbler_community_repo
{%- endif %}

cobbler-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ cobbler.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
