# Домашнее задание по теме «Основы Git»

1. Создайте легковестный тег v0.0 на HEAD коммите и запуште его во все три добавленных на предыдущем этапе upstream.

```bash
git tag v0.0 7ec2f95
git push origin --tags
git push gitlab --tags
```

2. Аналогично создайте аннотированный тег v0.1.

```bash
git tag -a v0.1 7ec2f95 -m "v0.1"
```

## Задание №3 – Ветки

1.  Переключитесь обратно на ветку `main`, которая должна быть связана с веткой `main` репозитория на `github`.

```bash
git checkout origin/main
```

2. Посмотрите лог коммитов и найдите хеш коммита с названием `Prepare to delete and move`, который был создан в пределах предыдущего домашнего задания.

```bash
git log --oneline

16f3893 Prepare to delete and move
```

3. Выполните `git checkout` по хешу найденного коммита.

```bash
git checkout 16f3893
```

4. Создайте новую ветку `fix` базируясь на этом коммите `git switch -c fix`.

```bash
git switch -c fix
```

5. Отправьте новую ветку в репозиторий на гитхабе `git push -u origin fix`.

```bash
git push -u origin fix
```

6. Посмотрите, как визуально выглядит ваша схема коммитов: https://github.com/basson63/devops-netology-29/network.

7. Теперь измените содержание файла README.md, добавив новую строчку.

8. Отправьте изменения в репозиторий и посмотрите, как изменится схема на странице https://github.com/basson63/devops-netology-29/network и как изменится вывод команды git log.

 
## Задание 4. Упрощаем себе жизнь

