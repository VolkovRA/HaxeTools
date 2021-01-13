# Haxe инструменты

Зачем это надо
------------------------------

Давно напрашивался отдельный репо для всех часто используемых классов и утилит. Теперь они лежат тут, в одном месте, они обрели свой дом. Благодаря тряске дерева в Haxe, неиспользуемые классы не попадают в Ваш итоговый проект. Не имеет зависимостей.

Добавление в проект
------------------------------

1. Установите haxelib себе на локальную машину, чтобы вы могли использовать библиотеки Haxe.
2. Установите tools себе на локальную машину, глобально, используя cmd:
```
haxelib git tools https://github.com/VolkovRA/HaxeTools master
```
Синтаксис команды:
```
haxelib git [project-name] [git-clone-path] [branch]
haxelib git minject https://github.com/massiveinteractive/minject.git         # Use HTTP git path.
haxelib git minject git@github.com:massiveinteractive/minject.git             # Use SSH git path.
haxelib git minject git@github.com:massiveinteractive/minject.git v2          # Checkout branch or tag `v2`
```
3. Добавьте библиотеку tools в ваш Haxe проект.

Дополнительная информация:
 * [Документация Haxelib](https://lib.haxe.org/documentation/using-haxelib/ "Using Haxelib")
 * [Документация компилятора Haxe](https://haxe.org/manual/compiler-usage-hxml.html "Configure compile.hxml")