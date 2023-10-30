# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as terraform__modules with context %}

include:
  - {{ sls_service_clean }}

terraform-modules-subcomponent-config-clean-file-absent:
  file.absent:
    - name: {{ terraform__modules.subcomponent.config }}
    - watch_in:
        - sls: {{ sls_service_clean }}
