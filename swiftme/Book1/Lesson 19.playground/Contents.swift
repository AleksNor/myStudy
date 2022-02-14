import UIKit

/*
 
 1) В конце главы про “Перечисления” мы с вами начали создавать перечисление ArithmeticExpression, позволяющее выполнять арифметические операции. Сейчас перед вами стоит задача доработать данное перечисление, чтобы оно могло производить любые арифметические операции, включая сложение, вычитание, умножение, деление и возведение в степень.
 2) Проверьте работу перечисления на произвольных примерах

 */
/*
enum ArithmeticExpression {
    case number(Int)
    indirect case additional(ArithmeticExpression, ArithmeticExpression)
    indirect case subtraction(ArithmeticExpression, ArithmeticExpression)
    indirect case multiply(ArithmeticExpression, ArithmeticExpression)
    indirect case division(ArithmeticExpression, ArithmeticExpression)
    
    func evaluate(_ expression: ArithmeticExpression? = nil) -> Int {
        switch expression ?? self {
        case let.number(value):
            return value
        case let.additional(valueLeft, valueRight):
            return evaluate(valueLeft) + evaluate(valueRight)
        case let.subtraction(valueLeft, valueRight):
            return evaluate(valueLeft) - evaluate(valueRight)
        case let.multiply(valueLeft, valueRight):
            return evaluate(valueLeft) * evaluate(valueRight)
        case let.division(valueLeft, valueRight):
            guard evaluate(valueRight) != 0 else {
                print("delit' na 0 nelzya")
                return 0
            }
            return evaluate(valueLeft) / evaluate(valueRight)
        }
    }
}

let hardExpr = ArithmeticExpression.multiply(.number(14), .number(2))
hardExpr.evaluate()
*/

/*Простейшая модель сущности “Шахматная фигура” может быть выполнена с помощью перечисления.
 1) Создайте перечисление Chessman, члены которого определяют возможные типы шахматных фигур (всего 6 типов, без учета цвета).
 2) Внутри перечисления Chessman создайте перечисление Color, определяющее возможные цвета шахматных фигур.
 3) Для каждого члена перечисления Chessman создайте связанный параметр типа Color, позволяющий указать цвет шахматной фигуры
 4) Создайте несколько экземпляров типа Chessman, каждый из которых описывает свою шахматную фигуру
 5) Напишите конструкции switch-case, способную обрабатывать параметр типа Chessman и выводить на консоль информацию о типе и цвете фигуры
 6) Создайте новую переменную и инициализируйте ей значение типа Color, вложенного в перечисление Chessman*/

enum Chessman {
    case king(color: Color)
    case castle(color: Color)
    enum Color {
        case black, white
    }
}

let blackKing = Chessman.king(color: .black)

switch blackKing {
case .king(color: .black):
    print("Cheniy korol'")
case .king(color: .white):
    print("beliy korol'")
case .castle(color: .black):
    print("Cherniy ferz")
case .castle(color: .white):
    print("Beliy ferz")
}
