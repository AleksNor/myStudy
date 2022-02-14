import UIKit

/*
func someFunc(bool:Bool) -> String {
    String(bool)
}
*/

/*
 Напишите функцию, которая принимает на вход массив с элементами типа Int, а возвращает целое число – сумму всех положительных элементов переданного массива.
 К примеру для массива [1,-2,3,4,-5] должно быть возвращено 1+3+4 = 8
 
func someFunc(array: [Int]) -> Int {
    var result = 0
    for num in array {
        guard num > 0 else {
            continue
        }
        result += num
    }
    return result
}
someFunc(array: [1,-2,3,4,-5])
*/

/*
 Напишите функцию, которая принимает на вход массив типа [Int] и, в случае, если количество элементов > 0, то возвращает целое число – произведение всех элементов переданной коллекции. Если количество элементов = 0, то возвращается 0.
 Пример:
 [1,2,3,4] -> 1 * 2 * 3 * 4 = 24


func someFunc(array: [Int]) -> Int {
    guard array.count != 0 else {
        return 0
    }
    var result = 1
    for num in array {
        result *= num
    }
    return result
}
someFunc(array: [1,2,3,4])
*/

/*
 Используя перегрузку (overloading) создайте две одноименные функции, которые могут принимать два однотипных параметра (Int или Double) и возвращают их произведение
 Пример:
 (4, 5) -> 4 * 5 = 20
 (4.1, 5.2) -> 4.1 * 5.2 = 21.32


func multiply (_ a:Double, _ b:Double) -> (Double) {a * b}

func multiply (_ a:Int, _ b:Int) -> (Int) {a * b}
*/

/*
 Напишите функцию, которая принимает на вход целое число и возвращает противоположное ему целое число
 Пример
 -12 -> 12
 32 -> -32


func reverse (_ num: Int) -> (Int) { -num}
*/

/*
 Напишите функцию, которая производит подсчет стоимости аренды квартиры с учетом следующих условий:
 1. Один день аренды стоит 850 рублей
 2. При аренде от 3 дней вы получаете скидку в размере 550 рублей от общей суммы
 3. При аренде от 7 дней вы получаете скидку в размере 1620 рублей от общей суммы
 Функция должна принимать на вход количество дней, а возвращать итоговую сумму.
 Пример
 funcName(5) -> 3700
 funcName(9) -> 6030


func funcName(_ dayCount: Int) -> Int {
    var result = 0
    switch dayCount {
    case 1...2 :
        result = dayCount * 850
    case 3...6 :
        result = dayCount * 850  - 550
    case 7... :
        result = dayCount * 850 - 1620
    default:
        break
    }
    return result
}

funcName(5)
funcName(9)
*/

/*
 Напишите функцию, которая принимает на вход массив типа [Int] и значение Int, проверяет содержится ли целочисленный элемент в массиве и возвращает true или false в зависимости от результата проверки
 Покажите не менее двух способов решения данной задачи
 Пример:
 funcName([1,2,3], 4) -> false
 funcName([2,3,4], 3) -> true
 

func funcName (_ array: [Int], _ num: Int) -> (Bool) {
    guard array.contains(num) else {
        return false
    }
    return array.contains(num)
}
funcName([1,2,3], 4)
funcName([2,3,4], 3)
*/

/*
 Напишите функцию, которая повторяет заданную строку N раз.
 Функция принимает на вход значение типа String (строку для повторений) и значение типа Int (количество повторений) и возвращает полученный результат.
 Пример:
 funcName("Swift", 2) -> "SwiftSwift"
 funcName("Xcode", 0) -> ""
 

func funcName (_ string: String, _ num: Int) -> String {
    var result = ""
    var count = num
    while count > 0 {
        result += string
        count -= 1
    }
    return result
}
funcName("Swift", 2)
funcName("Xcode", 0)
*/

/*
 Мальчик находится на N-ом этаже в здании. Мама мальчика смотрит в окно на M-ом этаже здания. Мальчик выпускает из рук мячик, он летит вниз, отскакивает на (высота броска) * L, вновь летит вниз, вновь отскакивает на (высота предыдущего отскока) * L и т.д, пока не окончит отскакивать.
 Реализуйте функцию, которая высчитывает, сколько раз мяч пролетит мимо мамы (вниз и вверх). Функция должна принимать на вход следующие параметры:
 – высота одного этажа (h > 0)
 – этаж мальчика (N >= 2)
 – этаж мамы (M >= 1)
 – коэффициент отскока (L < 1)
 */

func funcName (_ floorHeight: Double,_ guyFloor: Double,_ momFloor: Double,_ coef: Double) -> Int {
    guard floorHeight > 0 else {
        return 0
    }
    guard guyFloor >= 2 else {
        return 0
    }
    guard momFloor >= 1 else {
        return 0
    }
    guard coef < 1 else {
        return 0
    }
    var result = 1
    var startHeight = floorHeight * guyFloor
    let momHeight = floorHeight * momFloor
    while startHeight >= momHeight {
        startHeight *= coef
        result += 2
    }
    return result
}

funcName(10, 2, 1, 0.75)
