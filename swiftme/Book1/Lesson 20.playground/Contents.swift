import UIKit
import libkern

/*
 
 Реализуйте структуру Point, описывающую точку на плоскости (2 оси)
 Структура должна обладать следующими характеристиками:
 – свойство, описывающее координаты очки на плоскости
 – метод, принимающую другую точку в качестве входного аргумента и возвращающий расстояние между текущей точкой и переданной
 Проверьте работоспособность вашей структуры
 Расстояние между точками с координатам (10,20) и (15,22) должно быть равно [Double] 5.385164807134504

 */

struct Point {
    var dotOne: (Int, Int)
    func distance (dotTwo: (Int,Int)) -> Double {
        return sqrt(
            pow(Double(dotTwo.0 - self.dotOne.0), 2) +
            pow(Double(dotTwo.1 - self.dotOne.1), 2))
    }
}

//var firstDot = Point(dotOne: (10, 20))
//firstDot.distance(dotTwo: (15,22))

/*
 Ранее мы уже моделировали с вами сущность шахматная фигура с помощью перечисления Chessman. В этот раз мы смоделируем фигуру с помощью структуры, значительно расширив возможности данной модели. Вы конечно же можете использовать наработки из заданий главы “Перечисления”.
 1) Создайте перечисление Color, которое будет содержать два члена, описывающих цвета фигур. Для каждого члена укажите связанное значение, определяющее наименование цвета на английском языке
 2) Создайте перечисление Type, членами которого будут являться шахматные фигуры. Для каждого члена укажите связанное значение, определяющее наименование фигуры на английском языке
 3) Объявите две переменные. Первой инициализируйте член перечисления Color, а второй – Type
 4) Создайте структуру Chessman, которая описывает сущность “шахматная фигура”.
 Перечисление должно содержать следующие элементы:
 – свойство color типа Color, определяющее цвет фиугры
 – свойство type типа Type, определяющее тип фигуры
 – свойство coordinates типа (Character, UInt)?, определяющее координаты фигуры на шахматной доске.
 – свойство symbol, определяющее UTF-символ данной шахматной фигуры (тип Character)
 – инициализатор, принимающий значения свойств color и type, и устанавливающий coordinates в nil, а symbol в ""
 – инициализатор, принимающий на вход значения для всех свойств: color, type, coordinates, symbol
 – метод setCoordinates(Character,UInt), позволяющий установить новые координаты фигуры
 – метод kill(), сменяющий координаты на nil (убивающий фигуру)
 5) Объявите переменную whiteKing и инициализируйте ей значение типа Chessman, описывающее фигуру “Белый король”. Попробуйте использовать каждый из созданных методов структуры.
 */

enum Color: String {
    case white = "White"
    case black = "Black"
}

enum Type: String {
    case king = "King"
    case queen = "Queen"
    case rook = "Rook"
    case bishop = "Bishop"
    case pawn = "Pawn"
    case knight = "Knight"
}

struct Chessman {
    var color: Color
    var type: Type
    var coordinates: (Character, UInt)?
    var symbol: Character?
    init (color: Color, type: Type) {
        self.color = color
        self.type = type
        self.coordinates = nil
        self.symbol
    }
    init (color: Color, type: Type, coordinates: (Character, UInt), symbol: Character) {
        self.color = color
        self.type = type
        self.coordinates = coordinates
        self.symbol = nil
    }
    mutating func setCoordinates (newCoordinates: (Character, UInt)) -> Void {
        self.coordinates = newCoordinates
    }
    mutating func kill() {
        self.coordinates = nil
    }
}

//var whiteKing = Chessman(color: .white, type: .king)
//whiteKing.setCoordinates(newCoordinates: ("A", 5))
//whiteKing.coordinates
//whiteKing.kill()
//whiteKing.coordinates


/*
 
 1) Cоздайте структуру, описывающую сущность “Пользователь”. В ее состав должны входить следюущие элементы:
 – свойства, содержащие имя и фамилию
 – инициализатор, принимающий только имя
 – инициализатор, принимающий имя и фамилию
 – метод, возвращающий информационную строку с указание имени и фамилии пользователя
 – методы, изменяющие имя и фамилию
 2) Проверьте созданную структуру
 
*/

struct Player {
    var wholeName: (firstName: String, lastName: String)
    init (firstName: String) {
        wholeName = (firstName, "")
    }
    init (firstName: String, lastName: String) {
        self.wholeName = (firstName, lastName)
    }
    func returnWholeName() {
        print(self.wholeName.firstName + " " + self.wholeName.lastName)
    }
    mutating func changePlayerName(newFirstName: String, newLatName: String) -> Void {
        self.wholeName = (newFirstName, newLatName)
    }
}

var player1 = Player(firstName: "Evgeniy", lastName: "Karpov")
player1.returnWholeName()
player1.changePlayerName(newFirstName: "Johnny", newLatName: "Thompson")
player1.returnWholeName()
