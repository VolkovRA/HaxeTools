package tools;

import js.Browser;
import js.html.Blob;
import js.html.URL;

/**
 * Вспомогательные утилиты и инструменты. 🔨  
 * Класс содержит часто используемые методы и
 * функций общего назначения, чтобы не писать
 * их каждый раз заного.
 * 
 * Статический класс.
 */
@:dce
class Utils
{
    /**
     * Проверить значение на: `null`  
     * Используется как краткая форма записи проверки
     * на: `null` с возможностью указать значение по
     * умолчанию.
     * - Возвращает: `value`, если значение не равно: `null`
     * - Возвращает: `def` во всех остальных случаях.
     * @param value Проверяемое значение.
     * @param def Значение по умолчанию.
     * @return Проверенное значение.
     */
    inline static public function nvl(value:Dynamic, def:Dynamic):Dynamic {
        return value==null?def:value;
    }

    /**
     * Округлить число с заданной точностью.  
     * Возвращает число с округлением до указанной
     * точки после запятой.
     * 
     * Пример:
     * ```
     * Utils.round(0, 0);           // 0
     * Utils.round(10, 0);          // 10
     * Utils.round(10.1234567, 0);  // 10
     * Utils.round(10.1234567, 1);  // 10.1
     * Utils.round(10.1234567, 2);  // 10.12
     * Utils.round(10.1234567, 3);  // 10.123
     * Utils.round(10.1234567, 4);  // 10.1235
     * Utils.round(10.1234567, 5);  // 10.12346
     * Utils.round(10.1234567, 6);  // 10.123457
     * Utils.round(10.1234567, 10); // 10.1234567
     * ```
     * @param value Округляемое число.
     * @param n Количество знаков после запятой.
     * @return Округлённое число заданной точности.
     */
    static public function round(value:Float, n:Int):Float {
        var m:Float = Math.pow(10, n);
        return Math.round(value*m)/m;
    }

    /**
     * Получить количество знаков в числе после запятой.  
     * Парсит число и возвращает количество знаков после
     * запятой.
     * 
     * Пример:
     * ```
     * Utils.dec(0);     // 0
     * Utils.dec(0.1);   // 1
     * Utils.dec(0.12);  // 2
     * Utils.dec(0.123); // 3
     * ```
     * @param value Исходное число.
     * @return Количество знаков после запятой.
     */
    static public function dec(value:Float):Int {
        var v:String = value + "";
        var i:Int = v.indexOf(".");
        if (i == -1)
            return 0;
        return v.length-i-1;
    }

    /**
     * Получить знак числа.
     * - Возвращает: `1`, если число больше нуля.
     * - Возвращает: `-1`, если число меньше нуля.
     * - Возвращает: `0` во всех остальных случаях.
     * @param value Число.
     * @return Знак числа.
     */
    static public function sign(value:Float):Int {
        if (value > 0)
            return 1;
        if (value < 0)
            return -1;
        return 0;
    }

    /**
     * Проверить наличие флагов в битовой маске.  
     * - Возвращает: `true`, если маска содержит все
     *   указанные флаги.
     * - Возвращает: `false`, если маска не содержит
     *   хотя бы одного из флагов.
     * - Возвращает: `true`, если флаги не переданы.
     *   (`flags=0`)
     * 
     * Пример:
     * ```
     * Utils.maskAND(10, 0);   // true:  01010, 00000
     * Utils.maskAND(10, 10);  // true:  01010, 01010
     * Utils.maskAND(21, 4);   // true:  10101, 00100
     * Utils.maskAND(10, 512); // false: 01010, 01000
     * Utils.maskAND(10, 4);   // false: 01010, 00100
     * ```
     * 
     * **Обратите внимание**, в JavaScript побитовые
     * операций нормально работают только до числа:
     * `2147483647`, это:
     * `0b1111111111111111111111111111111` или:
     * `0x7fffffff`, или: `2^31 -1`. Вы не можете
     * использовать число больше этого, так как
     * последний бит используется для знака минус.
     * 
     * @param mask Битовая маска.
     * @param flags Флаги.
     * @return Маска содержит все указанные флаги.
     */
    inline static public function maskAND(mask:Int, flags:Int):Bool {
        return (mask&flags)==flags;
    }

    /**
     * Проверить наличие, как минимум, одного флага
     * в битовой маске.
     * - Возвращает: `true`, если маска содержит хотя бы один из переданных флагов.
     * - Возвращает: `false`, если маска не содержит ни одного флага.
     * - Возвращает: `false`, если флаги не переданы. (`flags=0`)
     * 
     * Пример:
     * ```
     * Utils.maskOR(0, 0);    // false: 00000 00000
     * Utils.maskOR(0, 1);    // false: 00000 00001
     * Utils.maskOR(21, 0);   // false: 10101 00000
     * Utils.maskOR(21, 512); // false: 10101 01000
     * Utils.maskOR(21, 4);   // true:  10101 00100
     * ```
     * 
     * **Обратите внимание**, в JavaScript побитовые
     * операций нормально работают только до числа:
     * `2147483647`, это:
     * `0b1111111111111111111111111111111` или:
     * `0x7fffffff`, или: `2^31 -1`. Вы не можете
     * использовать число больше этого, так как
     * последний бит используется для знака минус.
     * 
     * @param mask Битовая маска.
     * @param flags Флаги.
     * @return Возвращает результат сравнения маски и флагов.
     */
    inline static public function maskOR(mask:Int, flags:Int):Bool {
        return (mask&flags)>0;
    }

    /**
     * Перевести радианы в градусы.
     * @param rad Радианы.
     * @return Градусы.
     */
    inline static public function radToDeg(rad:Float):Float {
        return rad * 57.29577951308232; // rad * (180 / Math.PI);
    }

    /**
     * Перевести градусы в радианы.
     * @param deg Градусы.
     * @return Радианы.
     */
    inline static public function degToRad(deg:Float):Float {
        return deg * 0.017453292519943295; // deg * (Math.PI / 180);
    }

    /**
     * Придумать случайный пароль.  
     * Генерирует случайный пароль из указанного
     * набора символов и случайной длины.
     * 
     * Пример:
     * ```
     * var chars = ['1', '2', 'a', 'b', 'c', 'A', 'B', 'C'];
     * Utils.pswdGet(a, 5, 10);   // cCacCCBab
     * Utils.pswdGet(a, 5, 10);   // cB2ccbCC1C
     * Utils.pswdGet(a, 5, 10);   // 2Ca1cb1cb
     * Utils.pswdGet(a, 5, 10);   // 11BBB
     * Utils.pswdGet(a, 10, 10);  // AbbAABbBbc
     * Utils.pswdGet(a, 10, 10);  // aACC22A2CA
     * Utils.pswdGet(a, 10, 10);  // 2bAcbcab2c
     * Utils.pswdGet(a, 10, 0);   // 1ACCbAbCCa
     * Utils.pswdGet(a, 10, 0);   // a11bCacbba
     * ```
     * @param chars Таблица используемых символов при
     *              генераций случайного пароля.
     * @param lenMin Минимальная длина пароля.
     * @param lenMax Максимальная длина пароля.
     * @return Новый пароль.
     */
    static public function pswdGet(chars:Array<String>, lenMin:Int, lenMax:Int):String {
        var l = chars.length;
        if (lenMin <= 0)
            return "";

        var i = lenMin + Math.round(Math.random() * Math.max(0, lenMax-lenMin));
        var p = "";
        while (i-- > 0)
            p += chars[Math.floor(Math.random()*l)];

        return p;
    }

    /**
     * Распечатать пароль звёздочками.  
     * Выводит пароль, скрывая его символы.
     * 
     * Пример:
     * ```
     * Utils.pswdPrint("123"); // ***
     * ```
     * 
     * **Обратите внимание**, несмотря на то, что
     * пароль скрыт, количество символов в нём
     * известно. Используйте с осторожностью.
     * 
     * @param pswd Пароль.
     * @param char Символ, используемый для скрытия пароля.
     * @return Представление пароля в виде символов.
     */
    static public function pswdPrint(pswd:String, char:String = "*"):String {
        var l = pswd.length;
        if (l == 0)
            return "";

        var p = "";
        while (l-- > 0)
            p += char;

        return p;
    }

    /**
     * Получить описание объёма информации.  
     * Возвращает строковое представление количества
     * информации в соответствий с гостом: `8.417—2002`
     * 
     * Пример:
     * ```
	 * Utils.size(0);          // 0 bytes
     * Utils.size(100);        // 100 bytes
     * Utils.size(1000);       // 1 KB
     * Utils.size(1024);       // 1.02 KB
     * Utils.size(10000000);   // 10 MB  
     * ```
     * @param bytes Количество байт.
     * @return Строковое описание количества информации.
     */
    static public function size(bytes:Int):String {

        // Таблица измерения количества информации:
        // https://ru.wikipedia.org/wiki/%D0%9C%D0%B5%D0%B3%D0%B0%D0%B1%D0%B0%D0%B9%D1%82
        // 	
        // +------------------------------+
        // |        ГОСТ 8.417—2002       |            
        // | Название Обозначение Степень |	
        // +------------------------------+
        // | байт        Б         10^0   |
        // | килобайт    Кбайт     10^3   |
        // | мегабайт    Мбайт     10^6   |
        // | гигабайт    Гбайт     10^9   |
        // | терабайт    Тбайт     10^12  |
        // | петабайт    Пбайт     10^15  |
        // | эксабайт    Эбайт     10^18  |
        // | зеттабайт   Збайт     10^21  |
        // | йоттабайт   Ибайт     10^24  |
        // +------------------------------+

        if (bytes < 1e3)		return bytes + " bytes";
        if (bytes < 1e6)		return Math.floor(bytes / 1e1) / 1e2 + " KB";
        if (bytes < 1e9)		return Math.floor(bytes / 1e4) / 1e2 + " MB";
        if (bytes < 1e12)		return Math.floor(bytes / 1e7) / 1e2 + " GB";
        if (bytes < 1e15)		return Math.floor(bytes / 1e10) / 1e2 + " TB";
        if (bytes < 1e18)		return Math.floor(bytes / 1e13) / 1e2 + " PB";
        if (bytes < 1e21)		return Math.floor(bytes / 1e16) / 1e2 + " EB";
        if (bytes < 1e24)		return Math.floor(bytes / 1e19) / 1e2 + " ZB";

        return Math.floor(bytes / 1e22) / 1e2 + " YB";
    }

    /**
     * Сохранить файл.  
     * Вызывает диалоговое окно для сохранения файла
     * в локальной, файловой системе пользователя.
     * @param data Данные.
     * @param name Имя файла.
     * @param type Тип файла, например: `text/plain`,
     *             `image/png`, `application/zip` и т.п.
     * @see Mime типы: https://en.wikipedia.org/wiki/Media_type
     */
    static public function save(data:Dynamic, name:String = "data", type:String = null):Void {
        var file = new Blob([data], {type: type});

        // IE10+
        if (untyped Browser.window.navigator.msSaveOrOpenBlob) {
            untyped Browser.window.navigator.msSaveOrOpenBlob(file, filename);
            return;
        }

        // Другие:
        var url = URL.createObjectURL(file);
        var a = Browser.document.createAnchorElement();
        a.href = url;
        a.download = name;
        Browser.document.body.appendChild(a);
        a.click();

        Browser.window.setTimeout(function() {
            Browser.document.body.removeChild(a);
            URL.revokeObjectURL(url);
        }, 0);
    }
}