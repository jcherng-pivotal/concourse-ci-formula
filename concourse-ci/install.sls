{% from "concourse-ci/map.jinja" import concourse with context %}

ssh-client:
  pkg.installed:
    - name: 'openssh-client'

group_{{ concourse.group }}:
  group.present:
    - name: {{ concourse.group }}
    - system: True

user_{{ concourse.user }}:
  user.present:
    - name: {{ concourse.user }}
    - gid: {{ concourse.group }}
    - system: True

{{ concourse.install_dir }}:
  file.directory:
    - user: {{ concourse.user }}
    - group: {{ concourse.group }}
    - mode: 755
    - makedirs: True

{{ concourse.pki_dir }}:
  file.directory:
    - user: {{ concourse.user }}
    - group: {{ concourse.group }}
    - mode: 700
    - makedirs: True

{{ concourse.bin_dir }}:
  file.directory:
    - user: {{ concourse.user }}
    - group: {{ concourse.group }}
    - mode: 755
    - makedirs: True

{{ concourse.bin_dir }}/concourse:
  file.managed:
    - source:
      - {{ concourse.exe_url }}
    - source_hash: {{ concourse.exe_hash }}
    - user: {{ concourse.user }}
    - group: {{ concourse.group }}
    - mode: 755
    # FIXME Workaround https://github.com/saltstack/salt/issues/47042
    # Should be fixed with release after 2018.3.0
    - show_changes: False
