# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
```bash
playbook git:(main) ✗ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [Print OS] ************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *****************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
```bash
cat group_vars/all/examp.yml
---
  some_fact: all default fact
```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
```bash
version : "2"
services:
  centos7:
    image: centos:7
    container_name: centos7
    restart: unless-stopped
    entrypoint: "sleep infinity"

  ubuntu:
    image: brunneis/python:3.9.0-ubuntu
    container_name: ubuntu
    restart: unless-stopped
------
➜  playbook git:(main) ✗ docker ps -a
CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS                     PORTS                                                  NAMES
1c9444241c2c   brunneis/python:3.9.0-ubuntu   "sleep infinity"         25 seconds ago   Up 4 seconds                                                                      ubuntu
ad968abddb9c   centos:7                       "sleep infinity"         25 seconds ago   Up 4 seconds                                                                      centos7
```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
```bash
➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ***********************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use /usr/bin/python3, but is using /usr/local/bin/python3.9, since the discovered platform python
interpreter was not present. See https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP **********************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

```bash
➜  playbook git:(main) ✗ cat group_vars/deb/examp.yml
---
  some_fact: "deb default fact"
➜  playbook git:(main) ✗ cat group_vars/el/examp.yml
---
  some_fact: "el default fact"
```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

```bash
➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ******************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use /usr/bin/python3, but is using /usr/local/bin/python3.9,
since the discovered platform python interpreter was not present. See https://docs.ansible.com/ansible-
core/2.12/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
```bash
➜  playbook git:(main) ✗ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
➜  playbook git:(main) ✗ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
```bash
ну просто так он не запрашивает, надо было погуглить и найти параметр

➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ******************************************************************************************************
ERROR! Attempting to decrypt but no vault secrets found

с использованием параметра --ask-vault-pass
➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ******************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use /usr/bin/python3, but is using /usr/local/bin/python3.9,
since the discovered platform python interpreter was not present. See https://docs.ansible.com/ansible-
core/2.12/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```bash
ansible-doc -t connection -l
....
local                          execute on controller
....
нужен local
```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

```bash
cat prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker

  local:
    hosts:
      localhost:
        ansible_connection: local
```

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

```bash
➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use /usr/bin/python3, but is using
/usr/local/bin/python3.9, since the discovered platform python interpreter was not present. See
https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *****************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
```bash
ansible-vault decrypt --ask-vault-password group_vars/deb/examp.yml
Vault password:
Decryption successful
ansible-vault decrypt --ask-vault-password group_vars/el/examp.yml
Vault password:
Decryption successful 
```
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
```bash
➜  playbook git:(main) ✗ ansible-vault encrypt_string "PaSSw0rd"
New Vault password:
Confirm New Vault password:
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          33333130633036643466623139343166656632363832373339633037373931626636616364376564
          6266303265323766393731643231323639656661366539620a316134303834653064373365393763
          35326131313037346333396330376564396363303335346135643339346535623930313036303131
          6530373638326263390a653530346164663539303233373936333164323933356232386632646532
          3039
 ➜  playbook git:(main) ✗ cat group_vars/all/examp.yml
---
  some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          33333130633036643466623139343166656632363832373339633037373931626636616364376564
          6266303265323766393731643231323639656661366539620a316134303834653064373365393763
          35326131313037346333396330376564396363303335346135643339346535623930313036303131
          6530373638326263390a653530346164663539303233373936333164323933356232386632646532
          3039         
```
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
```bash
➜  playbook git:(main) ✗ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use /usr/bin/python3, but is using
/usr/local/bin/python3.9, since the discovered platform python interpreter was not present. See
https://docs.ansible.com/ansible-core/2.12/reference_appendices/interpreter_discovery.html for more
information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *****************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).

сделано

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

ввод пароля сделал из файла --vault-password-file=pass
```bash
➜  playbook git:(main) ✗ ./script.sh
[+] Running 4/4
 ⠿ Network playbook_default  Created                                       0.2s
 ⠿ Container ubuntu          Started                                       2.2s
 ⠿ Container centos7         Started                                       1.9s
 ⠿ Container fedora          Started                                       2.1s

PLAY [Print os facts] **********************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]
ok: [fedora]
[WARNING]: Distribution ubuntu 20.04 on host ubuntu should use
/usr/bin/python3, but is using /usr/local/bin/python3.9, since the discovered
platform python interpreter was not present. See
https://docs.ansible.com/ansible-
core/2.12/reference_appendices/interpreter_discovery.html for more information.
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ****************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] **************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [fedora] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP *********************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[+] Running 4/4
 ⠿ Container centos7         Removed                                      10.7s
 ⠿ Container ubuntu          Removed                                      10.6s
 ⠿ Container fedora          Removed                                      10.7s
 ⠿ Network playbook_default  Removed                                       0.2s
``` 
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.
 
