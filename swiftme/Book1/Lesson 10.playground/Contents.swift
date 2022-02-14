import Foundation
// 1
/*
let name = "Johnny"
switch name {
case "Johnny" :
    print("Privet admin \(name)")
case "Thompson":
    print("Hello capral")
case "Guest":
    print("Hello guest")
default :
    print("Halye, a ti kto?")
}

if name == "Johnny" {
    print("Privet admin \(name)")
} else if name == "Thompson" {
    print("Hello capral")
} else if name == "Guest" {
    print("Hello guest")
} else {
    print("Halye, a ti kto?")
}
*/

//2
/*
var open = false
let someString = (open ? "открыто" : "закрыто")
*/

//3
/*
var var1 = 10
var var2 = 15
var var3 = 20

var result: Int
result = var1 > var2 ? var1 : var2
result = result > var3 ? result : var3
*/

//4
/*
var tdA = (1, 4)
var tdB = (1, 1)
var tdC = (1, 3)
//AB BC CA
var lenAB = sqrt(pow(Double(tdB.0 - tdA.0), 2) + pow(Double(tdB.1 - tdA.1), 2))
var lenBC = sqrt(pow(Double(tdC.0 - tdB.0), 2) + pow(Double(tdC.1 - tdB.1), 2))
var lenCA = sqrt(pow(Double(tdA.0 - tdC.0), 2) + pow(Double(tdA.1 - tdC.1), 2))

if ((lenAB + lenBC) > lenCA) && ((lenBC + lenCA) > lenCA) && ((lenCA + lenAB) > lenBC) {
    print("Такой треугольник существет")
} else {
    print("Такого треугольника не может существовать")
}
*/

//5
/*
var lang = "ru"
let enWeek = ["mon", "tue", "wed", "ther", "fry", "sat", "sun"]
let ruWeek = ["пон", "вт", "ср", "чт", "пт", "сб", "вс"]
var days: Array<String> = []
switch lang {
case "ru" :
    days = ruWeek
case "en" :
    days = enWeek
default :
    break
}
*/

//7
typealias Operation = (operandOne: Double,operandTwo: Double,operation: Character)
let someOper: Operation = ( 3.1, 33, "+")
var result: Double = 0

switch someOper.operation {
case "+" :
    result = someOper.operandOne + someOper.operandTwo
case "-" :
    result = someOper.operandOne - someOper.operandTwo
case "*" :
    result = someOper.operandOne * someOper.operandTwo
case "/" :
    result = someOper.operandOne / someOper.operandTwo
default :
    print("Wrong operation")
}


