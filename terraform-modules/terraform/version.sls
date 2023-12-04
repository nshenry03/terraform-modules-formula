# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as terraform__modules with context %}

{#- Set the `module_dir` variable #}
{%- set module_dir = salt['file.join'](terraform__modules.base_dir, terraform__modules.module.name) %}

terraform-modules-terraform-version-file-managed:
  file.managed:
    - name: {{ salt['file.join'](module_dir, '.terraform-version') }}
    - contents: {{ terraform__modules.terraform.version }}
    - makedirs: True
