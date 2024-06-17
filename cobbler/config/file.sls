# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as cobbler with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

cobbler-config-file-file-managed:
  file.managed:
    - name: {{ cobbler.config }}
    - source: {{ files_switch([ cobbler.version + '/settings.yaml.jinja'],
                              lookup='cobbler-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ cobbler.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        cobbler: {{ cobbler | json }}

cobbler-modules-file-file-managed:
  file.managed:
    - name: /etc/cobbler/modules.conf
    - source: {{ files_switch([ cobbler.version + '/modules.conf.jinja'],
                              lookup='cobbler-modules-file-file-managed'
                )
              }}
    - mode: 644
    - user: root
    - group: {{ cobbler.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        cobbler: {{ cobbler | json }}

cobbler-mongodb-file-file-managed:
  file.managed:
    - name: /etc/cobbler/mongodb.conf
    - source: {{ files_switch([ cobbler.version + '/mongodb.conf.jinja'],
                              lookup='cobbler-mongodb-file-file-managed'
                )
              }}
    - mode: 644
    - user: root
    - group: {{ cobbler.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        cobbler: {{ cobbler | json }}
