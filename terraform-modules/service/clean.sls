# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as terraform__modules with context %}

terraform-modules-service-clean-service-dead:
  service.dead:
    - name: {{ terraform__modules.service.name }}
    - enable: False
