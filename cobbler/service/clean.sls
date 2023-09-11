# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}

cobbler-service-clean-service-dead:
  service.dead:
    - name: {{ cobbler.service.name }}
    - enable: False
