salt:
  # Set this to true to clean any non-salt-formula managed files out of
  # /etc/salt/{master,minion}.d ... You really don't want to do this on 2015.2
  # and up as it'll wipe out important files that Salt relies on.
  clean_config_d_dir: False

  # This state will remove "/etc/salt/minion" when you set this to true.
  minion_remove_config: True

  # This state will remove "/etc/salt/master" when you set this to true.
  master_remove_config: True

  # Set this to False to not have the formula install packages (in the case you
  # install Salt via git/pip/etc.)
  install_packages: True

  # to overwrite map.jinja salt packages
  lookup:
    salt-master: 'salt-master'
    salt-minion: 'salt-minion'
    salt-syndic: 'salt-syndic'
    salt-cloud: 'salt-cloud'
    salt-ssh: 'salt-ssh'

  # salt master config
  master:
    fileserver_backend:
      - roots

    file_roots:
      base:
        - /srv/salt/base
      prod:
        - /srv/salt/prod

    pillar_roots:
      base:
        - /srv/salt/base/pillar
      prod:
        - /srv/salt/prod/pillar

    # for salt-api with tornado rest interface
    rest_tornado:
      port: 8000
      ssl_crt: /etc/pki/api/certs/server.crt
      ssl_key: /etc/pki/api/certs/server.key
      debug: False
      disable_ssl: False

    # Define winrepo provider, by default support order is pygit2, gitpython
    # Set to gitpython for Debian & Ubuntu to get around saltstack/salt#35993
    # where pygit2 is not compiled with pygit2.GIT_FEATURE_HTTPS support
    winrepo_provider: gitpython

  # salt minion config:
  minion:

    # single master setup
    master: salt


salt_formulas:
  git_opts:
    default:
      baseurl: https://github.com/saltstack-formulas
      basedir: /srv/salt/base/formulas
      update: False
      options:
        rev: master
    dev:
      basedir: /srv/salt/prod/formulas
      update: True
      options:
        rev: master
  basedir_opts:
    makedirs: True
    user: root
    group: root
    mode: 755

  list:
    base:
      - salt-formula
      - postfix-formula
    prod:
      - salt-formula
      - postfix-formula
      - openssh-formula
