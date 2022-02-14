import UIKit

/*
 
 1) Создайте перечисление DayOfWeek, членами которого будут являться дни недели. У каждого члена должно быть связанное целочисленное значение. указывающее на его порядковый номер
 2) В составе перечисления создайте проваливающийся (failable) инициализатор, который принимает на вход название дня недели на русском языке и возвращает соответсвующий член перечисления
 В случае, если передано некорректное значение, необходимо вернуть nil
 3) Создайте переменную с использованием данного инициализатора

 */

enum DayOfWeek: Int {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    init?(day: String) {
        switch day {
        case "Понедельник":
            self = .monday
        case "Вторник":
            self = .tuesday
        case "Среда":
            self = .wednesday
        case "Четверг":
            self = .thursday
        case "Пятница":
            self = .friday
        case "Суббота":
            self = .saturday
        case "Воскресенье":
            self = .sunday
        default:
            return nil
        }
    }
}

var mon = DayOfWeek(day: "Понедельник")
var net = DayOfWeek(day: "AnotherDay")
var sut = DayOfWeek(day: "Суббота")
