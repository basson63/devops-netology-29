# Домашнее задание к занятию 12 «GitLab»

## Подготовка к выполнению

1. Подготовьте к работе GitLab [по инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/gitlab-containers).
2. Создайте свой новый проект.
3. Создайте новый репозиторий в GitLab, наполните его [файлами](./repository).
4. Проект должен быть публичным, остальные настройки по желанию.

## Основная часть

### DevOps

В репозитории содержится код проекта на Python. Проект — RESTful API сервис. Ваша задача — автоматизировать сборку образа с выполнением python-скрипта:

1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated).
2. Python версии не ниже 3.7.
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`.
4. Создана директория `/python_api`.
5. Скрипт из репозитория размещён в /python_api.
6. Точка вызова: запуск скрипта.
7. При комите в любую ветку должен собираться docker image с форматом имени hello:gitlab-$CI_COMMIT_SHORT_SHA . Образ должен быть выложен в Gitlab registry или yandex registry.   
8.* (задание необязательное к выполению) При комите в ветку master после сборки должен подняться pod в kubernetes. Примерный pipeline для push в kubernetes по [ссылке](https://github.com/awertoss/devops-netology/blob/main/09-ci-06-gitlab/gitlab-ci.yml).
Если вы еще не знакомы с k8s - автоматизируйте сборку и деплой приложения в docker на виртуальной машине.

```txt
поднял runner  в докере у себя на ВМ
```

### Product Owner

Вашему проекту нужна бизнесовая доработка: нужно поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:

1. Какой метод необходимо исправить.
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`.
3. Issue поставить label: feature.

### Developer

Пришёл новый Issue на доработку, вам нужно:

1. Создать отдельную ветку, связанную с этим Issue.
2. Внести изменения по тексту из задания.
3. Подготовить Merge Request, влить необходимые изменения в `master`, проверить, что сборка прошла успешно.


### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность.
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый.

```bash
➜  test7777 git:(main) docker pull  registry.gitlab.com/vitaliy495/test7777
Using default tag: latest
latest: Pulling from vitaliy495/test7777
2d473b07cdd5: Already exists
4d72898c849f: Already exists
dc9f490a51fc: Already exists
4f4fb700ef54: Already exists
8153f3a16140: Already exists
c9c45d6ef274: Already exists
43526066c4bc: Already exists
Digest: sha256:8be756a519665ca1b6bf35cf224309a14fce4ce6403cd23e72ec25d00c30952c
Status: Downloaded newer image for registry.gitlab.com/vitaliy495/test7777:latest
registry.gitlab.com/vitaliy495/test7777:latest
➜  test7777 git:(main) docker ps -a
CONTAINER ID   IMAGE                                            COMMAND                  CREATED         STATUS         PORTS                                       NAMES
a8d122fcfd91   registry.gitlab.com/vitaliy495/test7777:latest   "python3 /python_api…"   5 seconds ago   Up 3 seconds   0.0.0.0:5290->5290/tcp, :::5290->5290/tcp   iii
➜  test7777 git:(main) curl http://127.0.0.1:5290/rest/api/get_info
{"version": 3, "method": "GET", "message": "Running"}
```

## Итог

В качестве ответа пришлите подробные скриншоты по каждому пункту задания:

- файл [gitlab-ci.yml](repository/.gitlab-ci.yml);
- [Dockerfile](repository/Dockerfile);
- [лог успешного выполнения пайплайна](https://gitlab.com/basson63/tests63/-/jobs/5702398136);
- [решённый Issue.](https://gitlab.com/basson63/tests63/-/issues/?sort=created_date&state=closed&first_page_size=20)

### Важно 
После выполнения задания выключите и удалите все задействованные ресурсы в Yandex Cloud.

## Необязательная часть

Автомазируйте работу тестировщика — пусть у вас будет отдельный конвейер, который автоматически поднимает контейнер в docker или k8s и выполняет проверку, например, при помощи curl. На основе вывода будет приниматься решение об успешности прохождения тестирования.

