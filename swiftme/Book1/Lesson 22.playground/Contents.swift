import UIKit

/*
 1) Создайте класс RandomNumberGenerator, которы будет возвращать случайно сгенерированное число. Его инициализатор должен принимать свойства min и max, ограничивающие диапазон возможных значений сверху и снизу (максимальное и минимальное значения). Так же у класса должен быть метод getNumber(), возвращающий случайное целое число (из диапазона min...max).
 2) Создайте структуру Employee, содержащее три свойства:

 firstName – имя работника
 secondName – фамилия работника
 salary – заработная плата
 Типы данных свойств определите самостоятельно
 3) Создайте два массива типа [String] каждый. Первый должен содержать 5 вариантов имен, а второй – пять вариантов фамилий.
 4) Создайте экземпляр типа Employee. Значения имени и фамилии должны браться случайным образом из созданных в пункте 3 массивов. Значение заработной платы должно быть случайным целым числом в диапазоне от 20000 до 100000. Используйте созданный в шаге 1) класс RandomNumberGenerator.

*/

class RandomNumberGenerator {
    var min: Int
    var max: Int
    init (min: Int, max: Int) {
        self.min = min
        self.max = max
    }
    func getNumber() -> Int {
        return Int.random(in: min...max)
    }
}

struct Employee {
    var firstName: String
    var lastName: String
    var salary: Int
}

var firstNameArray = ["Александр","Борис","Виктор","Геннадий","Дмитрий"]
var lastNameArray = ["Иванов","Петров","Жклако","Сколь","Михайло"]

var randomRange = RandomNumberGenerator(min: 0, max: 4)

var somePeople = Employee(
    firstName: firstNameArray[randomRange.getNumber()],
    lastName: lastNameArray[randomRange.getNumber()],
    salary: RandomNumberGenerator(min: 20000, max: 100000).getNumber())
somePeople.firstName
somePeople.lastName
somePeople.salary
