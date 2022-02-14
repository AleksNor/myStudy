import UIKit

/*
 Расширьте класс Int, добавив в него свойства asDouble, asFloat и asString, возвращающие исходное целое число в преобразованном к другому типу данных виде (к Double, к Float, к String)
 Пример
 [Int] 12.asDouble -> [Double] 12
 */

extension Int {
    var asDouble: Double {return Double(self)}
    var asFloat: Float {return Float(self)}
    var asString: String {return String(self)}
}

var someInt = 12
12.asString

/*
 Напишите расширение к классу String, которое содержит метод, возвращающий закодированную строку по следующим правилам:
 – Первый символ каждого слова в строке меняется на Кодовую точку (набор цифр) данного символа в UTF
 – второй символ в каждом слове меняется местами с последним
 Пример
 "Я учу Swift".crypt() -> "1071 1091уч 83tifw"
 кодовые точки в данном случае представлены в десятиричной системе счисления
 */

//extension String {
//
//
//    func crypt(str: String) -> String {
//        var count = 0
//        let stringArray = str.split(separator: " ")
//        var resultStr = ""
//        for word in stringArray {
//            var tmp = word
//
//            }
//        }
//    }
//}
//var strToDecode = "Я"
//
//let str = strToDecode.unicodeScalars[strToDecode.startIndex].value


//var someClosure = {(num: Int) -> Int in
//        return num * num
//}



func storeTwoValues(value1: String, value2: String) -> (String) -> String {
    var previous = value1
    var current = value2
    return { new in
        let removed = previous
        previous = current
        current = new
        return "Removed \(removed)"
    }
}
let store = storeTwoValues(value1: "Hello", value2: "World")
let removed = store("Value Three")
print(removed)


func numSquare () -> (Int) -> Void {
    return {
        print("Квадратом числа \($0), является \($0 * $0)")
    }
}

func someFunc () -> (Int) -> Int {
    return {$0 * $0}
}

let result = someFunc()
result(12)


//

let movies = ["A New Hope", "Empire Strikes Back", "Return of the Jedi"]
movies.firstIndex(of: "A New Hope") == 4

//Попробуем воссоздать машину.
//Машина имеет марку, модель и пробег, а так же функцию увеличивающую ее пробег

struct Car {
    var mark: String
    var modael: String
    var currentDistance: Int = 0
    //Если свойству присвоено значение, то оно будет считаться по умолчанию
    //И оно будет применено в случае если при создании объекта не будет указано иного
    
    mutating func addDistance(distance: Int) {
        currentDistance += distance
    }
    //Функция имеет параметр mutating, который указывает на то,
    //что данная функция меняет одно из свойств структуры
    //в нашем случае, функция меняет пробег автомобиля
    
    //Давайте добавим вычисляемое свойство, амортизация
    //Вычесляемое свойство не будет вычисляться и забивать память до тех пор
    //пока его не вызвали
    
    var maintenanceCost: Int {
        //Пусть каждый киллометр стоит 6 рублей
        return currentDistance * 6
    }
}

//Создадим сущность подписанную на структуру Car

var newAuto = Car(mark: "BMW", modael: "103")
newAuto.currentDistance // 0
newAuto.addDistance(distance: 1302)
newAuto.currentDistance //1302
newAuto.maintenanceCost //7812
