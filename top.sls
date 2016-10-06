base:
  'salt':
    - salt.master
    - salt.formulas

prod:
  'salt':
    - salt.master
    - salt.formulas
    - salt.minion
