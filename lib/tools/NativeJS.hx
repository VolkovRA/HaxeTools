package tools;

import js.Syntax;

/**
 * Нативный JavaScript. ⚙️  
 * Используется для вызова нативных JS функций и методов,
 * сохраняя статическую типизацию Haxe. Это не очень
 * кроссплатформенно, но зато весьма удобно и эффективно.
 * 
 * **Обратите внимание**, джаваскрипт - зона повышенной
 * опасности! Советуем вам внимательно читать комментарий
 * с описанием вызываемых методов. Удачи!
 * 
 * Статический класс.
 */
@:dce
class NativeJS
{
    /**
     * Воткнуть точку останова. 🚨  
     * Вставляет точку остановки для активации дебаггера
     * и отладки в этом месте. Полезно для отладки, но
     * не должно использоваться в релизном билде.
     * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger
     */
    inline static public function debugger():Void {
        Syntax.code('debugger;');
    }

    /**
     * Приведение к строке.  
     * Приводит абсолютно любое значение к строке и
     * никогда не может быть: `null`
     * @param value Значение.
     * @return Строка.
     */
    inline static public function str(value:Dynamic):String {
        return Syntax.code("({0}+'')", value);
    }

    /**
     * Получить значение: `undefined`  
     * Функция вставляет в точку вызова значение: `undefined`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/undefined
     */
    inline static public function getUnd():Dynamic {
        return Syntax.code('undefined');
    }

    /**
     * Получить значение: `Infinity`  
     * Функция вставляет в точку вызова значение: `Infinity`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Infinity
     */
    inline static public function getInf():Float {
        return Syntax.code('Infinity');
    }

    /**
     * Получить значение: `NaN`  
     * Функция вставляет в точку вызова значение: `NaN`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/NaN
     */
    inline static public function getNaN():Float {
        return Syntax.code('NaN');
    }

    /**
     * Сверка типов.  
     * Оператор проверяет, принадлежит ли объект к определённому
     * классу. Другими словами, object is constructor проверяет,
     * присутствует ли объект constructor.prototype в цепочке
     * прототипов object.
     * 
     * **Обратите внимание**, при проверке объектов из разных
     * iframe, их типы всегда будут разными, даже у примитивов!
     * Это связано с тем, что различные контексты имеют разные
     * среды выполнения. Они имеют различные built-ins *(разный
     * глобальный объект, различные конструкторы и т.д.)*.
     * 
     * @param object Проверяемый объект.
     * @param constructor Функция-конструктор, на которую идёт проверка.
     * @return Объект принадлежит к указанному типу.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/instanceof
     */
    inline static public function is(object:Dynamic, constructor:Dynamic):Bool {
        return Syntax.code('({0} instanceof {1})', object, constructor);
    }

    /**
     * Проверка на строку.  
     * Возвращает: `true`, если переданным значением
     * является строка.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isStr('');
     * NativeJS.isStr('bla');
     * NativeJS.isStr('1');
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isStr(null);
     * NativeJS.isStr({});
     * NativeJS.isStr([]);
     * ```
     * @param value Проверяемое значение.
     * @return Переданное значение является строкой.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/typeof
     */
    inline static public function isStr(value:Dynamic):Bool {
        return Syntax.code("(typeof {0}==='string')", value);
    }

    /**
     * Проверка на булево значение.  
     * Возвращает: `true`, если переданное значение
     * является логическим.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isBool(true);
     * NativeJS.isBool(false);
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isBool('true');
     * NativeJS.isBool('false');
     * NativeJS.isBool(1);
     * NativeJS.isBool(null);
     * ```
     * @param value Проверяемое значение.
     * @return Переданное значение является логическим.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/typeof
     */
    inline static public function isBool(value:Dynamic):Bool {
        return Syntax.code("(typeof {0}==='boolean')", value);
    }

    /**
     * Проверка на: `undefined`  
     * Возвращает: `true`, если переданным значением
     * является: `undefined`
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * var map:Dynamic = { v2:1 };
     * NativeJS.isUnd(NativeJS.getUnd()); // undefined
     * NativeJS.isUnd(map.key);
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isUnd(null);
     * NativeJS.isUnd(NativeJS.getNaN());
     * NativeJS.isUnd(NativeJS.getInf());
     * NativeJS.isUnd(map.v2);
     * ```
     * @param value Проверяемое значение.
     * @return Переданным значением является: `undefined`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/undefined
     */
    inline static public function isUnd(value:Dynamic):Bool {
        return Syntax.code('({0}===undefined)', value);
    }

    /**
     * Проверка на: `NaN`  
     * Возвращает: `true`, если переданным значением
     * является: `NaN`
     * 
     * **Обратите внимание**, перед использованием этого
     * метода рекомендуется сперва проверить значение на
     * числовой тип: `NativeJS.isNum()`
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isNaN(NativeJS.getNaN()); // NaN
     * NativeJS.isNaN(NativeJS.getUnd()); // undefined
     * NativeJS.isNaN({});
     * NativeJS.isNaN("37,5");
     * NativeJS.isNaN(new Date().toString());
     * NativeJS.isNaN("blabla"); // "blabla" преобразовано в число
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isNaN(true);
     * NativeJS.isNaN(null);
     * NativeJS.isNaN(37);
     * NativeJS.isNaN("37");    // "37" преобразуется в число 37 которое не NaN
     * NativeJS.isNaN("37.37"); // "37.37" преобразуется в число 37.37 которое не NaN
     * NativeJS.isNaN("");      // Пустая строка преобразуется в 0 которое не NaN
     * NativeJS.isNaN(" ");     // Строка с пробелом преобразуется в 0 которое не NaN
     * NativeJS.isNaN(new Date());
     * ```
     * @param value Проверяемое значение.
     * @return Возвращает: `true`, если переданным
     *         значением является: `NaN`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/isNaN
     */
    inline static public function isNaN(value:Dynamic):Bool {
        return Syntax.code('isNaN({0})', value);
    }

    /**
     * Проверка на число.  
     * Возвращает: `true`, если переданным значением
     * является число.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isNum(37);
     * NativeJS.isNum(3.14);
     * NativeJS.isNum((42));
     * NativeJS.isNum(Math.PI);
     * NativeJS.isNum(NativeJS.getInf()); // Infinity
     * NativeJS.isNum(NativeJS.getNaN()); // NaN
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isNum(null);
     * NativeJS.isNum(NativeJS.getUnd()); // undefined
     * NativeJS.isNum({});
     * NativeJS.isNum([]);
     * ```
     * @param value Проверяемое значение.
     * @return Переданное значение является числом.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/typeof
     */
    inline static public function isNum(value:Dynamic):Bool {
        return Syntax.code("(typeof {0}==='number')", value);
    }

    /**
     * Проверка значения на конечное число.  
     * Возвращает: `true`, если переданным значением
     * является конкретное, конечное число.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isFin(0);
     * NativeJS.isFin(2e64);
     * NativeJS.isFin(910);
     * NativeJS.isFin(null); // Парсит и получается число: 0
     * NativeJS.isFin('0');  // Парсит и получается число: 0
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isFin(NativeJS.getInf());  // Infinity
     * NativeJS.isFin(NativeJS.getNaN());  // NaN
     * NativeJS.isFin(-NativeJS.getInf()); // -Infinity
     * ```
     * @param value Проверяемое значение.
     * @return Переданное значение является конечным.
     * @see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isFinite
     */
    inline static public function isFin(value:Dynamic):Bool {
        return Syntax.code('isFinite({0})', value);
    }

    /**
     * Проверка на функцию.  
     * Возвращает: `true`, если переданным значением
     * является функция.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isFunc(function(){});
     * NativeJS.isFunc(Math.sin);
     * ```
     * @param value Проверяемое значение.
     * @return Переданное значение является функцией.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/typeof
     */
    inline static public function isFunc(value:Dynamic):Bool {
        return Syntax.code("(typeof {0}==='function')", value);
    }

    /**
     * Проверка на массив.  
     * Возвращает: `true`, если переданным значением
     * является массив.
     * 
     * **Обратите внимание**, массивы из другого iframe
     * *(Отличные от того, в котором определён этот метод)*
     * не будут проходить проверку на массив! Это связано с
     * тем, что различные контексты имеют разные среды
     * выполнения. Они имеют различные built-ins *(разный
     * глобальный объект, различные конструкторы и т.д.)*.
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isArr([]);
     * NativeJS.isArr(new Array());
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isArr(0);
     * NativeJS.isArr(null);
     * NativeJS.isArr(NativeJS.getUnd()); // undefined
     * NativeJS.isArr({});
     * ```
     * @param value Проверяемый объект.
     * @return Это массив.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/instanceof
     */
    inline static public function isArr(value:Dynamic):Bool {
        return Syntax.code("({value} instanceof Array)", value);
    }

    /**
     * Проверка на объект.  
     * Возвращает: `true`, если переданным значением
     * является объект или: `null`
     * 
     * Пример:
     * ```
     * // Все эти вызовы возвращают: true
     * NativeJS.isObject(null);         // Так было с рождения JS
     * NativeJS.isObject([1, 2, 4]);    // Используйте NativeJS.isArr() для проверки на массив
     * NativeJS.isObject({ a:1 }); 
     * NativeJS.isObject(new Date());
     * NativeJS.isObject(new Number(1));
     * NativeJS.isObject(new Boolean(true));
     * NativeJS.isObject(new String('abc'));
     * 
     * // Все эти вызовы возвращают: false
     * NativeJS.isObject(0);
     * NativeJS.isObject(true);
     * NativeJS.isObject(NativeJS.getUnd()); // undefined
     * NativeJS.isObject({});
     * ```
     * @param value Проверяемый объект.
     * @return Это объект, по мнению JavaScript.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/instanceof
     */
    inline static public function isObj(value:Dynamic):Bool {
        return Syntax.code("(typeof {0}==='object')", value);
    }

    /**
     * Получить текущее время. *(mc)*  
     * Возвращает количество миллисекунд, прошедших с
     * 1 января 1970 года 00:00:00 по UTC по текущий
     * момент времени в качестве числа.
     * @return Текущее время в миллисекундах.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Date/now
     */
    inline static public function now():Float {
        return Syntax.code('Date.now()');
    }

    /**
     * Прочитать целочисленное число.  
     * Принимает строку в качестве аргумента и возвращает целое число
     * в соответствии с указанным основанием системы счисления.
     * 
     * Пример:
     * ```
     * // Все следующие примеры возвращают: 15
     * NativeJS.parseInt(" 0xF", 16);
     * NativeJS.parseInt(" F", 16);
     * NativeJS.parseInt(" 17", 8);
     * NativeJS.parseInt(021, 8);
     * NativeJS.parseInt("015", 10);
     * NativeJS.parseInt(015, 10);
     * NativeJS.parseInt(15.99, 10);
     * NativeJS.parseInt("FXX123", 16);
     * NativeJS.parseInt("1111", 2);
     * NativeJS.parseInt("15*3", 10);
     * NativeJS.parseInt("15e2", 10);
     * NativeJS.parseInt("15px", 10);
     * NativeJS.parseInt("12", 13);
     * 
     * // Все следующие примеры возвращают: NaN
     * NativeJS.parseInt("Hello", 8); // Не является числом
     * NativeJS.parseInt("546", 2);   // Неверное число в двоичной системе счисления
     * 
     * // Все следующие примеры возвращают: 4
     * NativeJS.parseInt(4.7, 10);
     * NativeJS.parseInt(4.7 * 1e22, 10);       // Очень большие числа становятся 4
     * NativeJS.parseInt(0.00000000000434, 10); // Очень маленькие числа становятся 4
     * ```
     * @param value Значение, которое необходимо проинтерпретировать.
     *              Если значение параметра не принадлежит строковому
     *              типу, оно преобразуется в него (с помощью
     *              абстрактной операции ToString). Пробелы в начале
     *              строки не учитываются.
     * @param base Целое число в диапазоне между: `2` и `36`,
     *             представляющее собой основание системы счисления
     *             числовой строки: `value`, описанной выше. В
     *             основном пользователи используют десятичную
     *             систему счисления и указывают: `10`. Всегда
     *             указывайте этот параметр, чтобы исключить ошибки
     *             считывания и гарантировать корректность исполнения
     *             и предсказуемость результата. Когда основание
     *             системы счисления не указано, разные реализации
     *             могут возвращать разные результаты.
     * @return Целое число, полученное парсингом (разбором и интерпретацией)
     *         переданной строки. Если первый символ не получилось
     *         сконвертировать в число, то возвращается: `NaN`
     * 
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/parseInt
     */
    inline static public function parseInt(value:Dynamic, base:Int = 10):Int {
        return Syntax.code('parseInt({0},{1})', value, base);
    }

    /**
     * Прочитать число с плавающей запятой.  
     * Принимает строку в качестве аргумента и возвращает
     * десятичное число. *(Число с плавающей точкой)*
     * 
     * Пример:
     * ```
     * // Все примеры ниже вернут: 3.14
     * NativeJS.parseFloat(3.14);
     * NativeJS.parseFloat('3.14');
     * NativeJS.parseFloat('314e-2');
     * NativeJS.parseFloat('0.0314E+2');
     * NativeJS.parseFloat('3.14какие-нибудь не цифровые знаки');
     * 
     * // Этот пример вернёт: NaN
     * NativeJS.parseFloat('FF2');
     * ```
     * @param value Текстовая строка, из которой вам надо
     *              выделить десятичное число.
     * @return Число с плавающей точкой, полученное из строки.
     *         Если первый символ не может быть сконвертирован
     *         в число, то возвращается: `NaN`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/parseFloat
     */
    inline static public function parseFloat(value:Dynamic):Float {
        return Syntax.code('parseFloat({0})', value);
    }

    /**
     * Удалить свойство из объекта. 🔥  
     * Если результат вычисления выражения не является
     * свойством *(объекта)*, delete ничего не делает.
     * @param object Имя объекта или выражение, результатом
     *               вычисления которого является объект.
     * @param key Удаляемое свойство или индекс массива.
     * @return Возвращает: `false`, только если свойство
     *         существует в самом объекте, а не в его
     *         прототипах, и не может быть удалено. Во всех
     *         остальных случаях возвращает: `true`
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/delete
     */
    inline static public function delete(object:Dynamic, key:Dynamic):Bool {
        return Syntax.code('delete {0}[{1}]', object, key);
    }

    /**
     * Строгое равенство.  
     * Выполняет сравнение двух значений, используя
     * оператор: `===`
     * @param x Значение 1.
     * @param y Значение 2.
     * @return Результат строгого сравнения.
     */
    inline static public function eq(x:Dynamic, y:Dynamic):Bool {
        return Syntax.code('({0}==={1})', x, y);
    }

    /**
     * Строгое неравенство.  
     * Выполняет сравнение двух значений, используя
     * оператор: `!==`
     * @param x Значение 1.
     * @param y Значение 2.
     * @return Результат строгого сравнения.
     */
    inline static public function neq(x:Dynamic, y:Dynamic):Bool {
        return Syntax.code('({0}!=={1})', x, y);
    }

    /**
     * Отрицание.  
     * Выполняет автоматическое приведение переданного
     * значения к логическому типу и его отрицание.
     * @param value Значение.
     * @return Результат отрицания переданного значения.
     */
    inline static public function not(value:Dynamic):Bool {
        return Syntax.code('(!{0})', value);
    }

    /**
     * Двойное отрицание.  
     * Выполняет автоматическое приведение переданного
     * значения к логическому типу.
     * @param value Значение.
     * @return Результат приведения к: `Bool`
     */
    inline static public function dnot(value:Dynamic):Bool {
        return Syntax.code('(!!{0})', value);
    }

    /**
     * Получить значение без вызова геттера Haxe.  
     * Позволяет получить значение свойства объекта
     * в обход вызова геттера Haxe.
     * 
     * Родной геттер JavaScript будет по-прежнему
     * вызываться.
     * 
     * @param prop Свойство. Пример: `this.value`
     * @param value Значение указанного свойства.
     */
    inline static public function objGet(prop:Dynamic):Dynamic {
        return Syntax.code("{0}", prop);
    }

    /**
     * Установить значение без вызова сеттера Haxe.  
     * Позволяет передать значение в указанное свойство
     * в обход вызова сеттера Haxe, если он есть.
     * 
     * Родной сеттер JavaScript будет по-прежнему
     * вызываться.
     * 
     * @param prop Свойство. Пример: `this.value`
     * @param value Новое значение.
     */
    inline static public function objSet(prop:Dynamic, value:Dynamic):Void {
        Syntax.code("{0}={1};", prop, value);
    }

    /**
     * Создать массив заданной длины.  
     * Создаёт массив указанной длины, заполненный: `null`'ами.
     * Полезно для мгновенного выделения памяти нужной длины.
     * 
     * По сути, является аналогом для использования
     * конструктора: `new Vector(length)`
     * 
     * @param length Длина массива.
     * @return Новый массив. *(Без типизации, чтоб Haxe не бурагозил)*
     */
    inline static public function array(length:Int):Dynamic {
        return Syntax.code('new Array({0})', length);
    }

    /**
     * Получить время с момента запуска. *(mc)*  
     * Возвращает временную метку [DOMHighResTimeStamp](https://developer.mozilla.org/ru/docs/Web/API/DOMHighResTimeStamp),
     * измеряемую в миллисекундах, с точностью до одной тысячной
     * миллисекунды.
     * 
     * Значение, представленное типом: [DOMHighResTimeStamp](https://developer.mozilla.org/ru/docs/Web/API/DOMHighResTimeStamp),
     * изменяется в зависимости от контекста. Стоит иметь ввиду
     * следующее:
     * - В разделяемых или выделенных потоках выполнения, началом
     *   эпохи считается момент начала работы потока.
     * - Вне потоков выполнения, или в выделенных потоках, созданных
     *   в контексте: [Window](https://developer.mozilla.org/ru/docs/Web/API/Window),
     *   началом эпохи считается значение свойства: [PerformanceTiming.navigationStart](https://developer.mozilla.org/ru/docs/Web/API/PerformanceTiming/navigationStart).
     * - В выделенных потоках выполнения, созданных из другого потока,
     *   началом эпохи устанавливается начало эпохи этого самого потока.
     * @see https://developer.mozilla.org/ru/docs/Web/API/Performance/now
     */
    inline static public function uptime():Float {
        return Syntax.code('performance.now()');
    }

    /**
     * Вывести все ключи мапы.  
     * Печатает все ключи в мапе одной строкой и разделяет их
     * символом: `sep`
     * 
     * Пример:
     * ```
     * NativeJS.mapKeys({"dog":1, "cat":true, "23":null }, ","); // Строка: "dog,cat,23"
     * ```
     * @param map Хеш-мапа.
     * @param sep Символ разделителя.
     * @return Строка с ключами мапы.
     */
    static public function mapKeys(map:Dynamic, sep:String = ","):String {
        var s:String = '';
        Syntax.code('for (var i in {0}){1}+=i+{2}', map, s, sep);
        return s==''?'':s.substring(0,s.length-1);
    }

    /**
     * Получить первый элемент в мапе.  
     * Возвращает самый первый элемент мапы или: `null`,
     * если переданный объект не имеет свойств.
     * @param map Хеш-мапа.
     * @return Первый элемент в мапе или: `null`
     */
    static public function map0(map:Dynamic):Dynamic {
        Syntax.code("for (var i in {0})return {0}[i];", map);
        return null;
    }

    /**
     * Распарсить JSON текст.  
     * Разбирает строку и возвращает объект.
     * @param text Разбираемая строка. Смотрите документацию
     *             по объекту: [JSON](https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/JSON)
     *             для описания синтаксиса.
     * @return Возвращает объект, соответствующий переданной строке.
     * @throws SyntaxError Выбрасывает исключение [SyntaxError](https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/SyntaxError),
     *                     если разбираемая строка не является
     *                     правильным JSON.
     * @see https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/JSON/parse
     */
    inline static public function jsonRead(text:String):Dynamic {
        return Syntax.code('JSON.parse({0})', text);
    }

    /**
     * Получить текст в формате JSON.  
     * Преобразует переданное значение JavaScript в
     * строку JSON формата.
     * - Порядок преобразования в строку свойств объектов, не
     *   являющихся массивами, не гарантируется. Не полагайтесь
     *   на порядок свойств во время преобразования.
     * - Объекты `Boolean`, `Number` и `String` преобразуются в
     *   соответствующие примитивные значения, в соответствии
     *   с традиционным соглашением о семантике преобразований.
     * - Значение: `undefined`, функция или символ, встреченные
     *   во время преобразования, будут либо опущены *(если они
     *   найдены в объекте)*, либо превращены в: `null` *(если
     *   они найдены в массиве)*.
     * - Все свойства, имеющие ключ в виде символа, будут
     *   полностью проигнорированы.
     * @param value Значение, преобразуемое в строку JSON.
     * @return Строка в формате JSON.
     */
    inline static public function jsonWrite(value:Dynamic):String {
        return Syntax.code('JSON.stringify({0})', value);
    }
}