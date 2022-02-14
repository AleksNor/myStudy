import UIKit
/*
//11

typealias Text = String

let const1: Text = "11"
let const2: Text = "222"
let const3: Text = "s7s7s"

if Int(const1) != nil {
    print(const1)
}
if Int(const2) != nil {
    print(const2)
}
if Int(const3) != nil {
    print(const3)
}


//7
var dairy = ["Ivanov" : ["01.02.1999": 3, "01.03.1999": 5], "Petrov" : ["01.02.1999": 2, "01.03.1999": 5], "Sidorov" : ["01.02.1999": 5, "01.03.1999": 4]]
dairy["Ivanov"]!["01.02.1999"]
var averegGroup = 0
var groupCount = 0
for man in dairy.keys {
    var result = 0
    var count = 0
    for date in dairy[man]!.keys {
        result += dairy[man]![date]!
        averegGroup += dairy[man]![date]!
        count += 1
        groupCount += 1
    }
    print("Ученик \(man) имеет средний бал \(result / count) ")
}
print("средний бал группы \(averegGroup / groupCount)")
*/
/*
 1) Создайте псевдоним Coordinates для типа кортежа (alpha: Character?, num: Int?). Данный тип будет описывать координаты шахматной фигуры на игровом поле. Если вместо элементов кортежа стоит nil, значит фигура не находится на игровом поле.
 2) Создайте псевдоним Chessman для типа словаря [String:Coordinates]. Данный тип описывает шахматную фигуру на игровом поле. В ключе словаря должно хранится имя фигуры, например "White King", а в значении – кортеж, указывающий на координаты фигуры на игровом поле.
 3) Создайте переменный словарь figures типа Chessman и добавьте в него три произвольные фигуры, одна из которых не должна иметь координат.
 4) Создайте цикл, которая обходит всех элементы словаря (все фигуры), и проверяет, убита ли очередная фигура (элемент словаря figures), далее выводит на консоль информацию либо о координатах фигуры, либо о ее отсутствии на игровом поле.
 */


typealias Coordinates = (alpha: Character?, num: Int?)
typealias Chessman = [String: Coordinates]
var figures: Chessman = ["White king": ("A", 1), "Black King": ("F", 2), "White Queen" : (nil, nil)]

for figure in figures.keys {
    if figures[figure]!.alpha != nil && figures[figure]!.num != nil {
        print("Фигура \(figure) расположена на клетке с координатами \(figures[figure]!.alpha!)\(figures[figure]!.num!)")
    } else {
        print("Фигура \(figure) убита")
    }
    
}
