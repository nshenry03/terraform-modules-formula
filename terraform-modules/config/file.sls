# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as terraform__modules with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

terraform-modules-config-file-file-managed:
  file.managed:
    - name: {{ terraform__modules.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='terraform-modules-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ terraform__modules.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        terraform__modules: {{ terraform__modules | json }}