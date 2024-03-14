- name: disable nodejs
  ansible.builtin.shell: dnf module disable nodejs

- name: install nodejs
  ansible.builtin.yum:
    name: nodejs
    state: installed

- name: app pre-req
  ansible.builtin.include_tasks: "pre-req.yml"

- name: installing nodejs dependencies
  community.general.npm:
    path: /app
    state: latest

- name: settingup systemd
  ansible.builtin.include_tasks: "systemd.yml"

    
- name: load schema
  ansible.builtin.include_tasks: "{{schema_type}}"-schema.yml
  when: shema_load
  
