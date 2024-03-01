- name: disable nodejs
  ansible.builtin.shell: dnf module disable nodejs

- name: install nodejs
  ansible.builtin.yum:
    name: nodejs
    state: installed

- name: add user
  ansible.builtin.user:
  name: roboshop

- name: removing old app content
  ansible.builtin.file:
    path: /app
    state: absent

- name: creating app directory
  ansible.builtin.file:
    path: /app
    state: directory

- name: downloading {{component}} app content
  ansible.builtin.unarchive:
    src: curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/{{component}}.zip
    dest: /app

- name: installing nodejs dependencies
  community.general.npm:
    path: /app
    state: latest

- name: setting {{component}} service file
  ansible.builtin.copy:
    src: "{{component}}.serrvice"
    dest: /etc/systemd/system/{{component}}.service

- name: installing {{component}} service
  ansible.builtin.systemd:
    name: "{{component}}"
    daemon_reload: yes
    enabled: yes
    OB
    state: restarted
- name: load schema
  ansible.builtin.include_tasks: "{{schema_type}}"-schema.yml
  when: shema_load
  
